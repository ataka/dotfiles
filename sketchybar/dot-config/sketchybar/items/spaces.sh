#!/bin/bash

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all)
do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
              background.color=$BORDER_COLOR \
              background.corner_radius=5 \
              background.height=20 \
              background.drawing=off \
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
