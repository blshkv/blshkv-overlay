#!/bin/sh

VENUS_HOME="$XDG_RUNTIME_DIR/waydroid-venus"

mkdir -p $VENUS_HOME

LD_LIBRARY_PATH=/usr/lib/waydroid-nvidia \
RENDER_SERVER_EXEC_PATH=/usr/lib/waydroid-nvidia/virgl_render_server \
/usr/lib/waydroid-nvidia/virgl_test_server \
    --venus --multi-clients \
    --socket-path "$VENUS_HOME/venus.sock" &
