local M = {}
local H = {} -- Internal helper functions

-- Cache for repository information
-- Key: Repository root path
-- Value: { branch = string|nil, last_update = number, is_updating = boolean }
local git_cache = {}

-- Cache timeout in seconds (increased slightly, frequent updates might not be needed)
local CACHE_TIMEOUT = 10

-- Current buffer's associated git info (if any)
-- Avoids recalculating root for the same buffer repeatedly
local current_buf_repo_root = nil
local current_bufnr = -1

-- --- Internal Helper Functions (H) ---

-- Find git repository root for a directory (memoized)
local find_git_root_memo = {}
H.find_git_root = function(start_dir)
  -- Check memoization cache first
  if find_git_root_memo[start_dir] then
    return find_git_root_memo[start_dir] -- Can return nil if known not to be in a repo
  end

  -- Check if we're in a git repo using a more robust check
  local cmd = { "git", "-C", start_dir, "rev-parse", "--show-toplevel" }
  -- Use pcall for safety, especially if start_dir doesn't exist (though unlikely here)
  local ok, output = pcall(vim.fn.system, cmd)

  local root = nil
  -- Ensure command succeeded and output is not empty
  if ok and vim.v.shell_error == 0 and output and output ~= "" then
    root = vim.trim(output)
    -- Ensure the root exists as a directory (safety check)
    if vim.fn.isdirectory(root) == 0 then
      root = nil
    end
  end

  -- Store result (even nil) in memoization cache
  find_git_root_memo[start_dir] = root
  return root
end

-- Clear the find_git_root memoization cache (e.g., on DirChanged)
H.clear_git_root_memo = function()
  find_git_root_memo = {}
end

-- Update git branch information asynchronously for a repository root
H.update_git_branch_async = function(repo_root)
  -- Initialize cache for this repo if it doesn't exist
  if not git_cache[repo_root] then
    git_cache[repo_root] =
      { branch = nil, last_update = 0, is_updating = false }
  end
  local repo_info = git_cache[repo_root]

  -- Debounce: Don't update if already updating
  if repo_info.is_updating then
    -- vim.notify("Git update already in progress for: " .. repo_root, vim.log.levels.DEBUG)
    return
  end

  -- Rate Limit: Check cache timeout only if we have a branch already
  local current_time = os.time()
  if
    repo_info.branch and (current_time - repo_info.last_update < CACHE_TIMEOUT)
  then
    -- vim.notify("Git cache still valid for: " .. repo_root, vim.log.levels.DEBUG)
    return
  end

  -- Mark as updating
  repo_info.is_updating = true
  -- vim.notify("Starting git update for: " .. repo_root, vim.log.levels.DEBUG)

  local cmd = { "git", "-C", repo_root, "rev-parse", "--abbrev-ref", "HEAD" }

  -- Prefer vim.system (Nvim 0.10+)
  if vim.fn.has("nvim-0.10") == 1 then
    vim.system(cmd, { text = true }, function(obj)
      repo_info.is_updating = false
      repo_info.last_update = os.time() -- Use time update finished

      local new_branch = nil
      if obj.code == 0 and obj.stdout and obj.stdout ~= "" then
        new_branch = " " .. vim.trim(obj.stdout) .. " "
      end

      -- Only redraw if branch actually changed or was nil
      if repo_info.branch ~= new_branch then
        repo_info.branch = new_branch
        -- vim.notify("Git branch updated (async): " .. (new_branch or "nil"), vim.log.levels.DEBUG)
        -- Schedule redraw to avoid issues in callbacks
        vim.schedule(function()
          vim.cmd("redrawstatus")
        end)
      else
        -- vim.notify("Git branch unchanged (async).", vim.log.levels.DEBUG)
      end
    end)
  else
    -- Fallback for older Neovim using defer_fn + system()
    vim.defer_fn(function()
      local output = vim.fn.system(cmd)
      repo_info.is_updating = false
      repo_info.last_update = os.time() -- Use time update finished

      local new_branch = nil
      if vim.v.shell_error == 0 and output and output ~= "" then
        new_branch = " " .. vim.trim(output) .. " "
      end

      -- Only redraw if branch actually changed or was nil
      if repo_info.branch ~= new_branch then
        repo_info.branch = new_branch
        -- vim.notify("Git branch updated (defer_fn): " .. (new_branch or "nil"), vim.log.levels.DEBUG)
        -- No need for vim.schedule here as defer_fn already does scheduling
        vim.cmd("redrawstatus")
      else
        -- vim.notify("Git branch unchanged (defer_fn).", vim.log.levels.DEBUG)
      end
    end, 20) -- Small delay
  end
end

-- Get the repository root for the current buffer (cached per buffer)
H.get_current_buf_repo_root = function()
  local bufnr = vim.api.nvim_get_current_buf()
  -- If buffer changed, reset cache
  if bufnr ~= current_bufnr then
    current_buf_repo_root = nil
    current_bufnr = bufnr
    -- Clear git root finding memoization too, as context might change
    H.clear_git_root_memo()
  end

  -- If already calculated for this buffer, return it
  if current_buf_repo_root ~= nil then
    -- Check if the cached root is still valid (e.g., directory deleted?)
    -- Return empty string instead of nil if known non-repo or invalid
    if
      current_buf_repo_root == ""
      or vim.fn.isdirectory(current_buf_repo_root) == 1
    then
      return current_buf_repo_root
    else
      -- Cached root became invalid, reset
      current_buf_repo_root = nil
    end
  end

  local file_path = vim.fn.expand("%:p")
  local repo_root = nil
  if file_path and file_path ~= "" then
    local file_dir = vim.fn.fnamemodify(file_path, ":h")
    -- Only try finding root if the directory exists
    if vim.fn.isdirectory(file_dir) == 1 then
      repo_root = H.find_git_root(file_dir)
    end
  else
    -- If no file path (e.g., new buffer), try current working directory
    local cwd = vim.fn.getcwd()
    if vim.fn.isdirectory(cwd) == 1 then
      repo_root = H.find_git_root(cwd)
    end
  end

  -- Cache the result (use "" for non-repo to avoid re-checking)
  current_buf_repo_root = repo_root or ""
  return current_buf_repo_root
end

-- Trigger a Git update check for the current context
H.request_git_update = function()
  local repo_root = H.get_current_buf_repo_root()
  if repo_root and repo_root ~= "" then
    -- vim.notify("Requesting git update for: " .. repo_root, vim.log.levels.DEBUG)
    H.update_git_branch_async(repo_root)
  else
    -- vim.notify("Not in a git repo, skipping update request.", vim.log.levels.DEBUG)
    -- Optional: If we previously had a branch for this buffer,
    -- we might need to explicitly clear it and redraw if we moved *out* of a repo.
    -- This depends on desired behavior.
  end
end

-- Get cached git branch for statusline (DOES NOT trigger updates)
H.get_cached_git_branch = function()
  local repo_root = H.get_current_buf_repo_root()
  if repo_root and repo_root ~= "" and git_cache[repo_root] then
    -- Return cached branch or empty string if update is in progress/failed
    return git_cache[repo_root].branch or ""
  end
  return ""
end

-- Function to get mode with proper casing (Unchanged)
H.get_mode = function()
  -- Use vim.fn.mode(true) to get full mode string, potentially more robust
  local mode_code = vim.fn.mode(true)
  local mode_map = {
    ["n"] = "NORMAL",
    ["no"] = "OP-PENDING",
    ["nov"] = "OP-PENDING",
    ["noV"] = "OP-PENDING",
    ["no\22"] = "OP-PENDING", -- CTRL-V
    ["niI"] = "NORMAL", -- Normal mode (insert completion) - Show as Normal?
    ["niR"] = "NORMAL", -- Normal mode (replace completion) - Show as Normal?
    ["niV"] = "NORMAL", -- Normal mode (virtual replace completion) - Show as Normal?
    ["nt"] = "NORMAL", -- Normal terminal mode
    ["v"] = "VISUAL",
    ["V"] = "V-LINE",
    ["\22"] = "V-BLOCK", -- CTRL-V
    ["s"] = "SELECT",
    ["S"] = "S-LINE",
    ["\19"] = "S-BLOCK", -- CTRL-S
    ["i"] = "INSERT",
    ["ic"] = "INSERT", -- Insert mode completion
    ["ix"] = "INSERT", -- Insert mode (command line completion)
    ["R"] = "REPLACE",
    ["Rc"] = "REPLACE", -- Replace mode completion
    ["Rx"] = "REPLACE", -- Replace mode (command line completion)
    ["Rv"] = "V-REPLACE",
    ["Rvc"] = "V-REPLACE",
    ["Rvx"] = "V-REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MORE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL", -- Terminal-Job mode
  }
  -- Fallback to the raw mode code if not in map
  return (" " .. (mode_map[mode_code] or mode_code):upper() .. " ") -- Add padding
end

-- Function to get file info (Unchanged)
H.get_file_info = function()
  local file_name = "%<%f" -- Use %f for relative path. Use %F for absolute if preferred.
  local modified = "%m"
  local readonly = "%r"
  local preview = "%w"
  local help = "%h"
  -- Simply concatenate the flags. Vim handles their display.
  return file_name .. modified .. readonly .. preview .. help
end

-- Function to get file type (Unchanged)
H.get_filetype = function()
  local ft = vim.bo.filetype
  if ft == "" then
    return "no ft"
  else
    return ft
  end
end

-- Function to get file format (Unchanged)
H.get_fileformat = function()
  local formats = {
    unix = "LF",
    dos = "CRLF",
    mac = "CR",
  }
  return formats[vim.bo.fileformat] or vim.bo.fileformat
end

-- Function to get file encoding (Unchanged)
H.get_fileencoding = function()
  local enc = vim.bo.fileencoding
  if enc == "" then
    enc = vim.o.encoding
  end
  return enc
end

-- --- Public Module Functions (M) ---

-- Main statusline function (reads cache, doesn't trigger updates)
function M.get_statusline()
  -- Left side
  local statusline = "%#StatusLineMode#"
    .. H.get_mode()
    .. "%#StatusLineModeDiv#%#StatusLine#"

  -- Git branch (read directly from cache)
  local branch = H.get_cached_git_branch()
  if branch ~= "" then
    statusline = statusline .. "%#StatusLineGit# " .. branch .. " %#StatusLine#"
  end

  -- File information
  statusline = statusline
    .. "%#StatusLineFile# "
    .. H.get_file_info()
    .. " %#StatusLine#"

  -- Right side separator
  statusline = statusline .. "%="

  -- File type, format, encoding
  statusline = statusline .. "%#StatusLineInfo# " .. H.get_filetype()
  statusline = statusline .. "  " .. H.get_fileencoding()
  statusline = statusline .. "  " .. H.get_fileformat() .. " " -- Use pipe separators

  -- Line and column information
  statusline = statusline .. "%#StatusLinePosition# %l:%c %P %% " -- Show percentage and line/col

  return statusline
end

-- Initialize the statusline and autocommands
function M.setup()
  -- Set statusline option to call our function
  -- Use luaeval for slightly better error reporting if get_statusline fails
  vim.opt.statusline = "%!v:lua.require('config.statusline').get_statusline()"

  -- Create autocommand group
  local group = vim.api.nvim_create_augroup("MyStatuslineGit", { clear = true })

  -- Trigger git update checks on relevant events
  -- BufEnter: When entering a buffer (good primary trigger)
  -- DirChanged: When vim's CWD changes (clears root cache, triggers update)
  -- FocusGained: When regaining focus (might have changed branch externally)
  -- BufWritePost: After saving (less critical, but branch *could* change post-commit hook)
  -- VimResized: Sometimes redraws are needed? Less critical for git.
  -- TermLeave: If you were in a terminal where you might have changed branch

  vim.api.nvim_create_autocmd(
    { "BufEnter", "FocusGained", "BufWritePost", "TermLeave" },
    {
      group = group,
      pattern = "*",
      callback = H.request_git_update,
      desc = "Request git status update",
    }
  )

  vim.api.nvim_create_autocmd("DirChanged", {
    group = group,
    pattern = "*",
    callback = function()
      H.clear_git_root_memo() -- Clear root finding cache
      H.request_git_update() -- Request update for new dir
    end,
    desc = "Handle directory change for git status",
  })

  -- Initial git status check for the current buffer on setup
  vim.schedule(H.request_git_update)
end

return M
