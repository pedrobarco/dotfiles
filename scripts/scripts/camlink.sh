#!/bin/bash

modprobe -r v4l2loopback
modprobe v4l2loopback devices=1 exclusive_caps=1

v4l2-ctl --list-devices # Get the video devices for the camlink and dummy

ELGATO=/dev/video0

V4LOOP=/dev/video2

ffmpeg -f v4l2 -input_format yuyv422 -framerate 60 -video_size 1920x1080 -i $ELGATO -pix_fmt yuyv422 -codec copy -f v4l2 $V4LOOP

