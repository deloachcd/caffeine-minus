#!/bin/sh

if test $XDG_SESSION_TYPE = x11; then
    xdotool key Pause
else
    wtype Pause
fi
