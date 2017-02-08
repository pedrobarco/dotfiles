#!/bin/bash

parallel ffmpeg -i {} -qscale:a 0 {.}.mp3 ::: ./*/*.flac
parallel ffmpeg -i {} -qscale:a 0 {.}.mp3 ::: ./*/*/*.flac

parallel ffmpeg -i {} -qscale:a 0 {.}.mp3 ::: ./*/*.flac
parallel ffmpeg -i {} -qscale:a 0 {.}.mp3 ::: ./*/*/*.flac

parallel ffmpeg -i {} -qscale:a 0 {.}.mp3 ::: ./*/*.flac
parallel ffmpeg -i {} -qscale:a 0 {.}.mp3 ::: ./*/*/*.flac

find . -type f -name "*.flac" | parallel rm
find . -type f -name "*.wav" | parallel rm
find . -type f -name "*.m4a" | parallel rm
