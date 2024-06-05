#!/usr/bin/env bash

set -eu -o pipefail

tmux_active_session() {
	tmux lsp -F '#{?#{pane_active},#{session_id},}' | tr -d '\n'
}

tmux_pane_curdir() {
	tmux lsp -F '#{?#{pane_active},#{pane_current_path},}' | tr -d '\n'
}

tmux_get_existing_session() {
	session_name="$1"
	tmux ls -F "#{?#{==:#{session_name},$session_name},#{session_id},}" | tr -d '\n'
}

case "$1" in
new-directory-session)
	if [[ -z "${2:-}" ]]; then
		pane_dir=$(tmux_pane_curdir)
	else
		pane_dir="$2"
	fi
	window_name=$(basename "$pane_dir")
	existing_session=$(tmux_get_existing_session "$pane_dir")
	if [[ -z "$existing_session" ]]; then
		session=$(tmux new-session -c "$pane_dir" -P -d -s "$pane_dir" -n "$window_name")
		tmux switch-client -t "$session"
		tmux send-keys -t "$session" 'nvim' Enter
		tmux select-layout -t "$session" 'main-vertical' \; \
			split-window -c "$pane_dir" -t "$session" \; \
			split-window -c "$pane_dir" -h \; \
			select-pane -U \; \
			resize-pane -y '60%' \; \
			resize-pane -Z
	else
		tmux switch-client -t "$existing_session" \; display-message 'Session already exists!'
	fi
	;;
new-directory-window)
	if [[ -z "${2:-}" ]]; then
		pane_dir=$(tmux_pane_curdir)
	else
		pane_dir="$2"
	fi
	window_name=$(basename "$pane_dir")
	window=$(tmux new-window -P -c "$pane_dir" -n "$window_name")
	tmux send-keys -t "$window" 'nvim' Enter
	tmux select-layout -t "$window" 'main-vertical' \; \
		split-window -c "$pane_dir" -t "$window" \; \
		split-window -c "$pane_dir" -h \; \
		select-pane -U \; \
		resize-pane -y '60%' \; \
		resize-pane -Z
	;;
new-current-window)
	if [[ -z "${2:-}" ]]; then
		pane_dir=$(tmux_pane_curdir)
	else
		pane_dir="$2"
	fi
	window_name=$(basename "$pane_dir")
	tmux rename-window "$window_name"
	tmux send-keys A c-u "cd $pane_dir && nvim" Enter
	tmux select-layout 'main-vertical' \; \
		split-window -c "$pane_dir" \; \
		split-window -c "$pane_dir" -h \; \
		select-pane -U \; \
		resize-pane -y '60%' \; \
		resize-pane -Z
	;;
toggle-zoom-nvim-pane)
	nvim_active_pane=$(
		tmux lsp -F '#{?#{==:#{pane_current_command},nvim},#{pane_id},}' | tr -d '\n'
	)
	active_pane=$(
		tmux display -p '#{pane_id}'
	)
	if [ "$nvim_active_pane" != "$active_pane" ]; then
		tmux select-pane -t "$nvim_active_pane"
		tmux resize-pane -Z -t "$nvim_active_pane"
	else
		tmux last-pane || true
	fi
	;;
toggle-goto-nvim-pane)
	nvim_active_pane=$(
		tmux lsp -F '#{?#{==:#{pane_current_command},nvim},#{pane_id},}' | tr -d '\n'
	)
	active_pane=$(
		tmux display -p '#{pane_id}' | tr -d '\n'
	)
	if [ "$nvim_active_pane" != "$active_pane" ]; then
		tmux select-pane -t "$nvim_active_pane"
	else
		tmux last-pane || true
	fi
	;;
open-aws-sessions)
	if [[ -z "${2:-}" ]]; then
		pane_dir=$(tmux_pane_curdir)
	else
		pane_dir="$2"
	fi
	shift 2
	window=$(tmux new-window -P -c "$pane_dir")
	if [[ "$#" -eq 1 ]]; then
		tmux send-keys -t "$window" "\$(awsl --profile $1 --export-profile)" Enter
	elif [[ "$#" -eq 2 ]]; then
		tmux send-keys -t "$window" "\$(awsl --profile $1 --export-profile)" Enter \; \
			split-window -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $2 --export-profile)" Enter
	elif [[ "$#" -eq 3 ]]; then
		tmux send-keys -t "$window" "\$(awsl --profile $1 --export-profile)" Enter "clear" Enter \; \
			split-window -h -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $2 --export-profile)" Enter "clear" Enter \; \
			split-window -h -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $3 --export-profile)" Enter "clear" Enter \; \
			select-layout -E
	elif [[ "$#" -eq 4 ]]; then
		tmux send-keys -t "$window" "\$(awsl --profile $1 --export-profile)" Enter "clear" Enter \; \
			split-window -h -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $2 --export-profile)" Enter "clear" Enter \; \
			split-window -v -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $3 --export-profile)" Enter "clear" Enter \; \
			select-pane -L \; \
			split-window -v -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $4 --export-profile)" Enter "clear" Enter \; \
			select-layout -E \; \
			select-pane -R \; \
			select-layout -E \;
	elif [[ "$#" -eq 5 ]]; then
		tmux send-keys -t "$window" "\$(awsl --profile $1 --export-profile)" Enter "clear" Enter \; \
			split-window -v -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $2 --export-profile)" Enter "clear" Enter \; \
			resize-pane -y 67% \; \
			split-window -h -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $3 --export-profile)" Enter "clear" Enter \; \
			split-window -v -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $5 --export-profile)" Enter "clear" Enter \; \
			select-pane -L \; \
			split-window -v -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $4 --export-profile)" Enter "clear" Enter \; \
			select-layout -E \; \
			select-pane -R \; \
			select-layout -E \;
	elif [[ "$#" -eq 6 ]]; then
		tmux send-keys -t "$window" "\$(awsl --profile $1 --export-profile)" Enter "clear" Enter \; \
			split-window -h -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $2 --export-profile)" Enter "clear" Enter \; \
			split-window -h -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $3 --export-profile)" Enter "clear" Enter \; \
			split-window -v -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $6 --export-profile)" Enter "clear" Enter \; \
			select-layout -E \; \
			select-pane -L \; \
			split-window -v -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $5 --export-profile)" Enter "clear" Enter \; \
			select-layout -E \; \
			select-pane -L \; \
			split-window -v -c "$pane_dir" \; \
			send-keys "\$(awsl --profile $4 --export-profile)" Enter "clear" Enter \; \
			select-layout -E \; \
			select-layout -E \;
	else
		tmux display-message 'ERROR[tmux-ctrl]: only up to 6 profiles are allowed'
	fi
	;;
*)
	tmux display-message 'ERROR[tmux-ctrl]: invalid selection'
	;;
esac
