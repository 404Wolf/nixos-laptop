#!/bin/bash

tmux rename-window -t :0 'gemini-flash'
tmux send-keys -t :0 "gpt general-gemini-2.0-flash" C-m

tmux new-window -n 'sonnet'
tmux send-keys -t :1 "gpt general-claude-3-7-sonnet-latest" C-m

tmux new-window -n 'openai-4o'
tmux send-keys -t :2 "gpt general-gpt-4o" C-m

tmux new-window -n 'townie-claude-3-8-sonnet-latest'
tmux send-keys -t :3 "townie-claude-3-8-sonnet-latest" C-m

