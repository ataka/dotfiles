#!/usr/bin/env zsh

# ~/ に置く設定ファイル
stow $argv --target ~ screen tmux zsh

# ~/.config に置く設定ファイル
stow $argv --dotfiles --target ~ aerospace atuin bat git jankyborders karabiner nushell sketchybar starship wezterm

# ~/Library/Developer/Xcode に置く設定ファイル
stow $argv --target ~/Library/Developer/Xcode Xcode

#
# 下記のファイルは symlink を使うと設定ファイルを読み込まれないようです:
#

# MacTcode

cp -p tcode/config.json ~/Library/Containers/jp.mad-p.inputmethod.MacTcode/Data/Library/Application\ Support/MacTcode

# Mouseless

cp -p mouseless/config.yaml ~/Library/Containers/net.sonuscape.mouseless/Data/.mouseless/configs
