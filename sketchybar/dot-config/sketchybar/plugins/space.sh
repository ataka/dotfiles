#!/bin/bash

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

source "$CONFIG_DIR/colors.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on \
                         background.color=$ACCENT_COLOR \
                         label.color=$BAR_COLOR \
                         icon.color=$BAR_COLOR \
                         icon=$1 \
                         label.font="sketchybar-app-font:Regular:16.0" \
                         label="$($CONFIG_DIR/plugins/workspace_icon.rb $CONFIG_DIR $1)"
else
  sketchybar --set $NAME background.drawing=off \
                         label.color=$WHITE \
                         icon.color=$WHITE \
                         icon=$1 \
                         label.font="sketchybar-app-font:Regular:16.0" \
                         label="$($CONFIG_DIR/plugins/workspace_icon.rb $CONFIG_DIR $1)"
fi
