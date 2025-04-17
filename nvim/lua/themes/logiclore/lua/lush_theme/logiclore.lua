local lush = require("lush")
local hsl = lush.hsl

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym

  -- Define color palette using HSL
  local palette = {
    bg0 = hsl(225, 4, 12), -- #1D1E20
    bg1 = hsl(225, 6, 13), -- #1F2023
    fg = hsl(223, 6, 75), -- #BBBEC3
    bg_d = hsl(223, 8, 18), -- #2A2C32
    lines = hsl(220, 6, 21), -- #323438
    yellow = hsl(56, 35, 54), -- #B2AE6A
    orange = hsl(20, 50, 62), -- #CF8E6E
    red = hsl(356, 73, 65), -- #E7656D
    purple = hsl(310, 41, 64), -- #C97EBC
    blue = hsl(209, 89, 65), -- #56A8F5
    light_blue = hsl(198, 34, 56), -- #699EB5
    cyan = hsl(186, 61, 45), -- #2DABB9
    green = hsl(128, 28, 54), -- #69AB72
    grey = hsl(222, 4, 50), -- #7A7D85
    light_grey = hsl(220, 8, 32), -- #4B4F58
    cursor = hsl(218, 10, 16), -- #25282D
    dirty = hsl(27, 57, 63), -- #D69B6B
    select = hsl(220, 60, 32), -- #214283
  }

  return {
    -- The following are the Neovim highlight groups
    -- See :h highlight-groups

    IndentLines({ bg = "NONE", fg = palette.lines }),

    -- ColorColumn    { }, -- Columns set with 'colorcolumn'
    -- Conceal        { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    -- Cursor         { }, -- Character under the cursor
    -- CurSearch      { }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
    -- lCursor        { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM       { }, -- Like Cursor, but used when in IME mode |CursorIM|
    -- CursorColumn   { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine({ bg = palette.cursor }), -- #131313 - Screen-line at the cursor, when 'cursorline' is set.
    -- Directory      { }, -- Directory names (and other special names in listings)
    -- DiffAdd        { }, -- Diff mode: Added line |diff.txt|
    -- DiffChange     { }, -- Diff mode: Changed line |diff.txt|
    DiffDelete({ fg = palette.red }), -- Diff mode: Deleted line |diff.txt|
    -- DiffText       { }, -- Diff mode: Changed text within a changed line |diff.txt|
    -- EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    -- TermCursor     { }, -- Cursor in a focused terminal
    -- TermCursorNC   { }, -- Cursor in an unfocused terminal
    ErrorMsg({ fg = palette.red }), -- Error messages on the command line
    -- VertSplit      { }, -- Column separating vertically split windows
    Folded({ bg = palette.cursor, fg = palette.light_grey }), -- Line used for closed folds
    -- FoldColumn     { }, -- 'foldcolumn'
    -- SignColumn     { }, -- Column where |signs| are displayed
    -- IncSearch      { }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    -- Substitute     { }, -- |:substitute| replacement text highlighting
    LineNr({ fg = palette.light_grey }), -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    -- LineNrAbove    { }, -- Line number for when the 'relativenumber' option is set, above the cursor line
    -- LineNrBelow    { }, -- Line number for when the 'relativenumber' option is set, below the cursor line
    -- CursorLineNr   { }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    -- CursorLineFold { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
    -- CursorLineSign { }, -- Like SignColumn when 'cursorline' is set for the cursor line
    MatchParen({ fg = hsl(23, 96, 75), bg = "NONE", underline = true }), -- #fab387
    -- ModeMsg        { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea        { }, -- Area for messages and cmdline
    -- MsgSeparator   { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    -- MoreMsg        { }, -- |more-prompt|
    -- NonText        { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal({ bg = palette.bg1, fg = palette.fg }),
    NormalFloat({ bg = palette.bg1 }), -- Normal text in floating windows.
    FloatBorder({ fg = palette.lines, bg = palette.bg1 }), -- Border of floating windows.
    FloatTitle({ fg = palette.fg }), -- Title of floating windows.
    -- NormalNC       { }, -- normal text in non-current windows
    -- Pmenu          { }, -- Popup menu: Normal item.
    PmenuSel({ bg = palette.grey, fg = palette.bg1, reverse = false }), -- Popup menu: Selected item.
    -- PmenuKind      { }, -- Popup menu: Normal item "kind"
    -- PmenuKindSel   { }, -- Popup menu: Selected item "kind"
    -- PmenuExtra     { }, -- Popup menu: Normal item "extra text"
    -- PmenuExtraSel  { }, -- Popup menu: Selected item "extra text"
    -- PmenuSbar      { }, -- Popup menu: Scrollbar.
    -- PmenuThumb     { }, -- Popup menu: Thumb of the scrollbar.
    -- Question       { }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine   { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    -- Search         { }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    -- SpecialKey     { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    -- SpellBad       { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    -- SpellCap       { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    -- SpellLocal     { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare      { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine({ bg = palette.bg_d, fg = palette.fg }), -- Status line of current window
    -- StatusLineNC   { }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine({ fg = palette.bg0, bg = palette.bg0 }), -- Tab pages line, not active tab page label
    TabLineFill({ fg = palette.bg0, bg = palette.bg0 }), -- Tab pages line, where there are no labels
    TabLineSel({ fg = palette.bg0, bg = palette.bg0 }), -- Tab pages line, active tab page label
    -- Title          { }, -- Titles for output from ":set all", ":autocmd" etc.
    Visual({ bg = palette.select.mix(palette.bg1, 10) }), -- Visual mode selection
    -- VisualNOS      { }, -- Visual mode selection when vim is "Not Owning the Selection".
    -- WarningMsg     { }, -- Warning messages
    -- Whitespace     { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WinSeparator({ fg = palette.bg_d, bg = "NONE" }), -- #1D1D1D
    WinSeparatorNC({ fg = palette.bg_d, bg = "NONE" }), -- #888888
    -- WildMenu       { }, -- Current match in 'wildmenu' completion
    -- WinBar         { }, -- Window bar of current window
    -- WinBarNC       { }, -- Window bar of not-current windows
    --

    -- StatusLineMode({ fg = "#282828", bg = "#83a598", bold = true }),
    -- StatusLineModeDiv({ fg = "#83a598", bg = "NONE" }),
    -- StatusLineFile({ fg = "#ebdbb2", bg = "NONE", bold = true }),
    -- StatusLineGit({ fg = "#b8bb26", bg = "NONE" }),
    -- StatusLineInfo({ fg = "#fabd2f", bg = "NONE" }),
    -- StatusLinePosition({ fg = "#fb4934", bg = "NONE" }),

    StatusLineMode({ fg = palette.bg1, bg = palette.light_blue, bold = true }),
    StatusLineModeDiv({ fg = palette.grey, bg = "NONE" }),
    StatusLineFile({ fg = palette.grey, bg = "NONE" }),
    StatusLineGit({ fg = palette.fg, bg = "NONE", bold = true }),
    StatusLineInfo({ fg = palette.grey, bg = "NONE" }),
    StatusLinePosition({ fg = palette.grey, bg = "NONE" }),

    String({ fg = palette.green }),
    Statement({ fg = palette.orange }),
    Special({ fg = palette.red }),
    Constant({ fg = palette.cyan }),
    Identifier({ fg = palette.fg }),
    Type({ fg = palette.fg }),

    -- Plugin-specific highlights

    NvimTreeNormalNC({ bg = "NONE" }),
    NvimTreeNormal({ bg = "NONE" }),
    NvimTreeRootFolder({ fg = palette.fg, bold = true }),
    NvimTreeFolderName({ fg = palette.fg }),
    NvimTreeEmptyFolderName({ fg = palette.fg }),
    NvimTreeOpenedFolderName({ fg = palette.fg }),
    NvimTreeSymlinkFolderName({ fg = palette.fg }),
    NvimTreeGitFileDeletedHL({ fg = palette.dirty }), -- #BD817C
    NvimTreeGitFileDirtyHL({ fg = palette.dirty }),
    NvimTreeGitFileNewHL({ fg = palette.green }),
    NvimTreeGitFileIgnoredHL({ fg = palette.grey }),
    NvimTreeGitFolderDeletedHL({ fg = palette.red }), -- #BD817C
    NvimTreeGitFolderDirtyHL({ fg = palette.orange }),
    NvimTreeGitFolderIgnoredHL({ fg = palette.grey }),

    -- cmp
    CmpItemMenu({ bg = "NONE", fg = palette.fg }),
    CmpItemAbbr({ bg = "NONE", fg = palette.fg }),
    CmpItemAbbrDeprecated({
      bg = "NONE",
      fg = palette.fg,
      strikethrough = true,
    }),
    CmpItemAbbrMatch({ bg = "NONE", fg = palette.blue }),
    CmpItemAbbrMatchFuzzy(CmpItemAbbrMatch),
    CmpItemKind({ bg = "NONE", fg = palette.grey }),
    CmpItemKindVariable({ bg = "NONE", fg = palette.grey }),
    CmpItemKindInterface({ bg = "NONE", fg = palette.grey }),
    CmpItemKindText(CmpItemKindVariable),
    CmpItemKindFunction({ bg = "NONE", fg = palette.grey }),
    CmpItemKindMethod(CmpItemKindFunction),
    CmpItemKindKeyword({ bg = "NONE", fg = palette.grey }),
    CmpItemKindProperty(CmpItemKindKeyword),
    CmpItemKindUnit(CmpItemKindKeyword),
    CmpDocumentationBorder({ bg = palette.bg_d, fg = palette.bg_d }),

    FzfLuaTitle({ fg = palette.grey }),
    FzfLuaLiveSym({ fg = palette.light_blue }),
    FzfLuaLivePrompt({ fg = palette.fg }),
    FzfLuaFzfPrompt({ fg = palette.light_blue }),
    FzfLuaFzfPointer({ fg = palette.light_blue }),
    FzfLuaMatch({ fg = palette.light_blue }),
    FzfLuaFzfMatch({ fg = palette.light_blue }),
    FzfLuaBorder({ fg = palette.bg_d }),
    FzfLuaPreviewBorder(IndentLines),
    FzfLuaFzfBorder({ fg = palette.bg_d }),
    FzfLuaNormal(Normal),
    FzfLuaMatchCaret({ fg = palette.light_blue }),
    FzfLuaMatchExact({ fg = palette.light_blue }),
    FzfLuaMatchFuzzy({ fg = palette.light_blue }),
    FzfLuaBufFlagCur({ fg = palette.light_blue }),
    FzfLuaBufNr({ fg = palette.yellow }),
    FzfLuaHeaderText({ fg = palette.light_blue }),
    FzfLuaTabMarker({ fg = palette.yellow }),
    FzfLuaPathLineNr({ fg = palette.green }),

    -- Visual Multi
    -- VM_Mono        { },
    VM_Extend(Visual),
    VM_Cursor({ bg = palette.dirty, fg = palette.bg1 }),
    -- VM_Insert      { },

    -- -------------------------------------------------------
    -- LSP Diagnostic Highlights
    -- -------------------------------------------------------
    -- Main diagnostic highlights
    DiagnosticError({ fg = palette.red }), -- Error text
    DiagnosticWarn({ fg = palette.yellow }), -- Warning text
    DiagnosticInfo({ fg = palette.blue }), -- Info text
    DiagnosticHint({ fg = palette.cyan }), -- Hint text

    -- Underline highlights
    DiagnosticUnderlineError({ fg = palette.red, undercurl = true }),
    DiagnosticUnderlineWarn({ fg = palette.yellow, undercurl = true }),
    DiagnosticUnderlineInfo({ fg = palette.blue, undercurl = true }),
    DiagnosticUnderlineHint({ fg = palette.cyan, undercurl = true }),

    -- Virtual text (inline annotations)
    DiagnosticVirtualTextError({
      fg = palette.red.mix(palette.bg1, 40),
      bg = palette.red.mix(palette.bg1, 95),
    }),
    DiagnosticVirtualTextWarn({
      fg = palette.yellow.mix(palette.bg1, 40),
      bg = palette.yellow.mix(palette.bg1, 95),
    }),
    DiagnosticVirtualTextInfo({
      fg = palette.blue.mix(palette.bg1, 40),
      bg = palette.blue.mix(palette.bg1, 95),
    }),
    DiagnosticVirtualTextHint({
      fg = palette.cyan.mix(palette.bg1, 40),
      bg = palette.cyan.mix(palette.bg1, 95),
    }),

    -- Sign column icons
    DiagnosticSignError({ fg = palette.red }),
    DiagnosticSignWarn({ fg = palette.yellow }),
    DiagnosticSignInfo({ fg = palette.blue }),
    DiagnosticSignHint({ fg = palette.cyan }),

    -- Floating windows
    DiagnosticFloatingError({ fg = palette.red }),
    DiagnosticFloatingWarn({ fg = palette.yellow }),
    DiagnosticFloatingInfo({ fg = palette.blue }),
    DiagnosticFloatingHint({ fg = palette.cyan }),

    -- Common vim syntax groups used for all kinds of code and markup.
    -- See :h group-name
    Comment({ fg = palette.light_grey }), -- Any comment

    -- sym"@text.literal"      { }, -- Comment
    -- sym"@text.reference"    { }, -- Identifier
    -- sym"@text.title"        { }, -- Title
    -- sym"@text.uri"          { }, -- Underlined
    -- sym"@text.underline"    { }, -- Underlined
    -- sym"@text.todo"         { }, -- Todo
    -- sym"@comment"           { }, -- Comment
    sym("@punctuation")({ fg = palette.fg }), -- Delimiter
    sym("@constant")({ fg = palette.fg }), -- Constant
    sym("@constant.builtin")({ fg = palette.fg }), -- Special
    sym("@constant.macro")({ fg = palette.fg }), -- Define
    -- sym"@define"            { }, -- Define
    -- sym"@macro"             { }, -- Macro
    sym("@string")({ fg = palette.green }), -- String
    sym("@string.escape")({ fg = palette.green }), -- SpecialChar
    sym("@string.special")({ fg = palette.green }), -- SpecialChar
    sym("@character")({ fg = palette.fg }), -- Character
    -- sym"@character.special" { }, -- SpecialChar
    sym("@number")({ fg = palette.cyan }), -- Number
    sym("@boolean")({ fg = palette.purple }), -- Boolean
    sym("@float")({ fg = palette.purple }), -- Float
    sym("@function")({ fg = palette.blue }), -- Function
    sym("@function.builtin")({ fg = palette.fg }), -- Special
    -- sym"@function.macro"    { }, -- Macro
    sym("@parameter")({ fg = palette.fg }), -- Identifier
    -- sym"@method"            { }, -- Function
    sym("@field")({ fg = palette.fg }), -- Identifier
    -- sym"@property"          { }, -- Identifier
    sym("@constructor")({ fg = palette.fg }), -- Special
    -- sym"@conditional"       { }, -- Conditional
    -- sym"@repeat"            { }, -- Repeat
    sym("@label")({ fg = palette.fg }), -- Label
    sym("@operator")({ fg = palette.fg }), -- Operator
    sym("@keyword")({ fg = palette.orange }), -- Keyword
    -- sym"@exception"         { }, -- Exception
    sym("@variable")({ fg = palette.fg }), -- Identifier
    sym("@type")({ fg = palette.fg }), -- Type
    sym("@type.definition")({ fg = palette.fg }), -- Typedef
    -- sym"@storageclass"      { }, -- StorageClass
    -- sym"@structure"         { }, -- Structure
    sym("@namespace")({ fg = palette.orange }), -- Identifier
    -- sym"@include"           { }, -- Include
    -- sym"@preproc"           { }, -- PreProc
    -- sym"@debug"             { }, -- Debug
    sym("@tag")({ fg = palette.fg }), -- Tag

    -- Typescript
    sym("@tag.tsx")({ fg = palette.yellow }), -- Tag
    sym("@tag.jsx")({ fg = palette.yellow }), -- Tag
    sym("@tag.builtin.tsx")({ fg = palette.yellow }), -- Tag
    sym("@tag.builtin.jsx")({ fg = palette.yellow }), -- Tag
    sym("@tag.delimiter.tsx")({ fg = palette.yellow }), -- Tag
    sym("@tag.delimiter.jsx")({ fg = palette.yellow }), -- Tag
  }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
