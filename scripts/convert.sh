# mv ~/Soulseek\ Downloads/complete/* ~/Downloads
cd ~/Downloads
find . -name "*.flac" -exec ffmpeg -i {} -qscale:a 0 {}.mp3 \;
find . -name "*.m4a" -exec ffmpeg -i {} -qscale:a 0 {}.mp3 \;
find . -name "*.flac" -exec rm -r {} \;
find . -name "*.m4a" -exec rm -r {} \;
find . -name "*.txt" -exec rm -r {} \;
find . -name "*.log" -exec rm -r {} \;
find . -name "*.png" -exec rm -r {} \;
find . -name "*.jpg" -exec rm -r {} \;
find . -name "*.cue" -exec rm -r {} \;
find . -name "*.m3u" -exec rm -r {} \;
cd ~
