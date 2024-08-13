

piantor_pro/setup: QMK_HOME := $(CURDIR)/qmk_firmware
piantor_pro/setup:
	qmk config user.qmk_home=$(QMK_HOME) \
		user.keyboard=beekeeb/piantor_pro \
		user.keymap=brutalsimplicity
	[ -e "$(QMK_HOME)" ] && echo "QMK firmware already setup" || qmk setup zsa/qmk_firmware -b firmware23 -y
	ln -shF $(CURDIR)/keyboards/beekeeb/piantor_pro/keymaps/brutalsimplicity $(QMK_HOME)/keyboards/beekeeb/piantor_pro/keymaps/brutalsimplicity
	qmk generate-compilation-database

voyager/setup: QMK_HOME := $(PWD)/zsa_qmk_firmware
voyager/setup:
	qmk config user.qmk_home=$(QMK_HOME) \
		user.keyboard=voyager \
		user.keymap=brutalsimplicity
	[ -e "$(QMK_HOME)" ] && echo "ZSA QMK firmware already setup" || qmk setup zsa/qmk_firmware -b firmware23 -y
	ln -shF $(CURDIR)/keyboards/zsa/voyager/keymaps/brutalsimplicity $(QMK_HOME)/keyboards/voyager/keymaps/brutalsimplicity
	qmk generate-compilation-database
	cp "$(QMK_HOME)/compile_commands.json" .
