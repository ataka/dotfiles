# -*- mode: makefile-gmake -*-

.PHONY: all
all: link

.PHONY: link
link:
	./link.sh

.PHONY: unlink
unlink:
	./link.sh --delete

.PHONY: setup
setup:
	brew install stow

#
# Install
# ============================================================

.PHONY: install
install: install-pre install-emacs-requires install-cui install-font install-programming

.PHONY: install-pre
install-pre:
	brew install wget

# https://github.com/d12frosted/homebrew-emacs-plus/blob/master/Formula/emacs-plus%4031.rb
.PHONY: install-emacs-requires
install-emacs-requires:
	brew install autoconf
	brew install automake
	brew install gcc
	brew install gmp
	brew install gnutls
	brew install libgccjit
	brew install librsvg
	brew install mailutils
	brew install pkgconf
	brew install sqlite
	brew install texinfo
	brew install tree-sitter
	brew install webp
	brew install jpeg-turbo
	brew install dbus
	brew install little-cms2

.PHONE: install-cui
install-cui: install-bat
	brew install --cask nikitabobko/tap/aerospace
	brew install --cask fontforge
	brew install --cask ghostty
	brew install --cask keycastr
	brew install --cask mouseless@preview
	brew install --cask raycast
	brew install --cask wezterm
	brew install --formula FelixKratz/formulae/borders
	brew install --formula FelixKratz/formulae/sketchybar
	brew install --formula jandedobbeleer/oh-my-posh/oh-my-posh
	brew install --formula lusingander/tap/serie
	brew tap FelixHerrmann/tap
	brew install swift-package-list
	brew install atuin
	brew install cmake
	brew install deskpad
	brew install eza
	brew install fd
	brew install fzf
	brew install fastfetch
	brew install git-delta
	brew install git-filter-repo
	brew install gnuplot
	brew install imagemagick
	brew install jq
	brew install just
	brew install mas
	brew install meetingbar
	brew install nushell
	brew install pandoc
	brew install screen
	brew install starship
	brew install tldr
	brew install tmux
	brew install tree
	brew install zoxide
	brew install zsh
	brew install zsh-autosuggestions
	brew install zsh-completions
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
	brew install --cask font-hack-nerd-font
	brew install --cask font-jetbrains-mono-nerd-font
	brew install --cask font-noto-serif-hentaigana
	brew install --cask font-victor-mono-nerd-font
	brew install --cask sf-symbols
	brew install font-sf-pro

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

.PHONY: install-kmonad
install-kmonad:
	brew install haskell-stack

.PHONY: install-codex
install-codex:
	brew install codex

.PHONY: install-claude
install-claude:
	brew install --cask claude-code

#
# App Store からインストールするアプリ; mas を使っていインストール
# ------------------------------------------------------------------------------
.PHONY: install-via-appstore
install-via-appstore:
	mas install 1569813296  # 1Password for Safari
	mas install 1503446680  # PastePal
	mas install 1530751461  # Snippety


#
# 同僚etc.が使っているアプリ; 同僚らのサポート用に...
# ------------------------------------------------------------------------------

.PHONY: install-for-support
install-for-support:
	brew install --cask visual-studio-code

#
# 過去に使っていたアプリ
# ------------------------------------------------------------------------------

.PHONE: install-archived
install-archived:
	brew install --cask karabiner-elements
