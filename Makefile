# -*- mode: makefile-gmake -*-

.PHONY: all
all: link

.PHONY: link
link:
	./link.sh

.PHONY: setup
setup:
	brew install stow

#
# Install
# ============================================================

.PHONY: install
install: install-pre install-cui install-font install-programming

.PHONY: install-pre
install-pre:
	brew install wget

.PHONE: install-cui
install-cui: install-bat
	brew install --cask nikitabobko/tap/aerospace
	brew install --cask fontforge
	brew install --cask ghostty
	brew install --cask karabiner-elements
	brew install --cask wezterm
	brew install --formula FelixKratz/formulae/borders
	brew install --formula jandedobbeleer/oh-my-posh/oh-my-posh
	brew tap FelixHerrmann/tap
	brew install swift-package-list
	brew install deskpad
	brew install eza
	brew install fd
	brew install fzf
	brew install git-delta
	brew install git-filter-repo
	brew install nushell
	brew install screen
	brew install starship
	brew install tldr
	brew install tmux
	brew install tree
	brew install zoxide
	brew install zsh
	brew install zsh-autosuggestions
	brew install zsh-completion
	brew install zsh-git-prompt
	brew install zsh-syntax-highlighting

.PHONY: install-bat
bat_config_dir := ./bat/dot-config/bat/themes
install-bat:
	brew install bat
	if [ ! -f "$(bat_config_dir)/Catppuccin Latte.tmTheme" ]; then\
	  mkdir -p $(bat_config_dir); \
	  wget -P $(bat_config_dir) https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme     ;\
	  wget -P $(bat_config_dir) https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme    ;\
	  wget -P $(bat_config_dir) https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme ;\
	  wget -P $(bat_config_dir) https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme     ;\
	fi

.PHONY: install-font
install-font:
	brew install --cask font-jetbrains-mono-nerd-font

.PHONY: install-programming
install-programming: install-programming-bash install-programming-lua install-programming-markdown
	brew install node
	brew install plantuml

.PHONY: install-programming-bash
install-programming-bash:
	brew install bash-language-server

.PHONE: install-programming-lua
install-programming-lua:
	brew install lua
	brew install lua-language-server

.PHONY: install-programming-markdown
install-programming-markdown:
	brew install markdown
