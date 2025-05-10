#!/usr/bin/env bash

SESSION_NAME="chatgpt"

create_and_setup_window() {
    local window_name="$1"
    local command="$2"

    # Create a new window
    tmux new-window -t "$SESSION_NAME"

    # Get the index of the newly created window
    local window_index
    window_index=$(tmux display-message -p -t "$SESSION_NAME" '#I')

    # Send the command to the window
    tmux send-keys -t "$SESSION_NAME:$window_index" "$command" C-m

    # Rename the window
    tmux rename-window -t "$SESSION_NAME:$window_index" "$window_name"
}

# Create a new session with the first window
tmux new-session -d -s "$SESSION_NAME" -n "gemini-flash"
tmux send-keys -t "$SESSION_NAME:0" "gpt general-gemini-2.0-flash" C-m

# Create and set up each additional window
create_and_setup_window "sonnet" "gpt general-claude-3-7-sonnet-latest"
create_and_setup_window "openai-4o" "gpt general-gpt-4o"
create_and_setup_window "townie" "gpt townie-claude-3-7-sonnet-latest"

# Attach to the session
tmux attach-session -t "$SESSION_NAME"

