
install:
	brew install koekeishiya/formulae/yabai
	[ ! -e $(HOME)/Library/LaunchAngents/com.koekeishiya.yabai.plist ] && yabai --install-service || true
	yabai --start-service
	ln -shF $(CURDIR)/config $(HOME)/.config/yabai


install-scripting-addition:
	echo "$$(whoami) ALL=(root) NOPASSWD: sha256:$$(shasum -a 256 $$(which yabai) | cut -d " " -f 1) $$(which yabai) --load-sa" \
		| sudo tee /private/etc/sudoers.d/yabai

install-config:
	ln -shF $(CURDIR)/config $(HOME)/.config/yabai

uninstall:
	yabai --stop-service
	yabai --uninstall-service || true
	sudo yabai --uninstall-sa
	brew uninstall yabai
	rm -rf /tmp/yabai_$$USER.out.log
	rm -rf /tmp/yabai_$$USER.err.log
	rm -r ~/.config/yabai
	rm -r /tmp/yabai_$$USER.lock
	rm -r /tmp/yabai_$$USER.socket
	rm -r /tmp/yabai-sa_$$USER.socket
	killall Dock

