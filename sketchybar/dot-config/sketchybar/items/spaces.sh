#!/bin/bash

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all)
do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
              icon.padding_right=0 \
              label.padding_left=0 \
              background.color=$BORDER_COLOR \
              background.corner_radius=5 \
              background.height=20 \
              background.drawing=off \
              label="$sid" \
              click_script="aerospace workspace $sid" \
              script="$CONFIG_DIR/plugins/space.sh $sid"
done
#   sketchybar --add item space.$sid left \
#              --subscribe space.$sid aerospace_workspace_change \
#              --set space.$sid label=$sid \
#                               background.color=$ACCENT_COLOR \
#                               background.corner_radius=5 \
#                               background.height=20 \
#                               background.drawing=off \
#                               label.font="sketchybar-app-font:Regular:16.0" \
#                               label.y_offset=-1 \
#                               click_script="aerospace workspace $sid" \
#                               script="$PLUGIN_DIR/space.sh $sid" \
# done
