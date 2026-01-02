#!/bin/bash
# Get the ID of the currently active workspace
ACTIVE_WS=$(hyprctl activeworkspace -j | jq '.id')

# Get PIDs of all windows on that workspace and kill them
hyprctl clients -j | jq ".[] | select(.workspace.id == $ACTIVE_WS) | .pid" | xargs kill
