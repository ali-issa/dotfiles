# Defines a function 'note' to quickly create and open a timestamped markdown note in nvim.
function note --description "Create and open a new timestamped note in nvim"
    # Define the notes directory path
    set notes_dir ~/notes

    # Ensure the notes directory exists, creating it if necessary.
    # The '-p' flag prevents errors if the directory already exists.
    mkdir -p $notes_dir

    # Check the exit status of the mkdir command.
    # If it's non-zero, an error occurred.
    if test $status -ne 0
        echo "Error: Could not create directory: $notes_dir" >&2 # Print error to stderr
        return 1 # Exit the function with an error status
    end

    # Generate the filename using the current date and time.
    # Format: YYYY-MM-DD_HHMMSS.md
    set filename $notes_dir/(date +%Y-%m-%d_%H%M%S).md

    # Define the nvim command to insert the formatted header.
    # Uses nvim's strftime function.
    set header_cmd ':put =strftime(\"# %A, %B %d, %Y at %H:%M:%S\")'

    # Define the nvim command to insert a newline character after the header.
    # nvim's ':put =' requires the string "\n" literally.
    set newline_cmd ':put =\"\\n\"'

    # Define the nvim command to move the cursor to the end of the file (the blank line).
    set goto_end_cmd 'normal G'

    # Execute nvim with the generated filename and the commands.
    # `command nvim` ensures the actual nvim executable is called,
    # bypassing any potential 'nvim' alias.
    # -c executes a command after opening the file.
    # +startinsert puts nvim directly into insert mode.
    command nvim $filename \
        -c $header_cmd \
        -c $newline_cmd \
        -c $goto_end_cmd \
        +startinsert

    # Check nvim's exit status (optional)
    if test $status -ne 0
       echo "nvim exited with status $status" >&2
    end

    # The function implicitly returns the exit status of the last command (nvim)
end
