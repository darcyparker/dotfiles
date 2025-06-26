#!/bin/bash
if ! declare -f cursor &>/dev/null; then
  function cursor() {
    # Path to the Cursor AppImage
    LOCAL_APPIMAGE_PATH="$HOME/Applications/Cursor.AppImage"
    LOG_FILE="/tmp/cursor_appimage.log" # Log for the AppImage launch

    # Find all possible 'cursor' commands in the PATH using 'which -a'.
    # We then filter for executable files that are NOT our AppImage script.
    FOUND_EXTERNAL_CURSOR=""
    while IFS= read -r line; do
      if [ -f "$line" ] && [ -x "$line" ] && [ "$line" != "$LOCAL_APPIMAGE_PATH" ]; then
        FOUND_EXTERNAL_CURSOR="$line"
        break # Found the first suitable external executable, stop searching
      fi
    done < <(which -a cursor) # Process output of which -a

    if [ -n "$FOUND_EXTERNAL_CURSOR" ]; then
      # If an external (likely Windows) executable for 'cursor' is found
      echo "Launching Windows Cursor IDE ($FOUND_EXTERNAL_CURSOR)..."
      # Using nohup is safer for backgrounding, even with Windows executables
      # when called directly from WSL.
      nohup "$FOUND_EXTERNAL_CURSOR" "$@" >/dev/null 2>&1 &
      echo "Windows Cursor launched in background."
    elif [ -f "$LOCAL_APPIMAGE_PATH" ] && [ -x "$LOCAL_APPIMAGE_PATH" ]; then
      # If no external Windows cursor, but our local AppImage exists and is executable, use it.
      echo "Launching Cursor AppImage..."
      nohup "$LOCAL_APPIMAGE_PATH" --no-sandbox "$@" >"$LOG_FILE" 2>&1 &
      echo "AppImage Cursor launched in the background. Output redirected to: $LOG_FILE"
      echo "You can check its output with: tail -f $LOG_FILE"
    else
      # If neither is found, inform the user
      echo "Error: 'cursor' command not found."
      echo "Neither Windows Cursor executable nor Cursor AppImage found or executable."
      echo "Windows Cursor: Check if it's correctly installed and its directory is in your Windows PATH."
      echo "AppImage Cursor: Ensure it's at $LOCAL_APPIMAGE_PATH and is executable."
      return 1 # Return a non-zero exit code to indicate failure
    fi
  }
  export -f cursor
fi
