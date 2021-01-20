INSTALLATION_PATH = /usr/bin/isla

main: compile

compile:
	@valac --pkg glib-2.0 --pkg gdk-3.0 --pkg gtk+-3.0 --pkg vte-2.91 Isla.vala
	@mv ./Isla ./isla

install:
	@cp ./isla $(INSTALLATION_PATH)
	@echo -e "\033[37mIsla\033[0m installed successfuly in '$(INSTALLATION_PATH)'. run: isla"