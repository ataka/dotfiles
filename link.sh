#!/usr/bin/env zsh

# ~/ に置く設定ファイル
stow $argv --target ~ screen tmux zsh

# ~/.config に置く設定ファイル
stow $argv --dotfiles --target ~ aerospace atuin bat git jankyborders karabiner nushell sketchybar starship wezterm

# ~/Library/Developer/Xcode に置く設定ファイル
stow $argv --target ~/Library/Developer/Xcode Xcode
