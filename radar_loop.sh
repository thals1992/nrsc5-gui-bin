mkdir -p ./map/latest
cd ./map
find *.png -mmin -120 -exec cp -a -t ./latest "{}" \+
rm ./latest/traffic*
cat ./latest/*.png | ffmpeg -f image2pipe -r 1 -i - -vcodec libx264 ../radar_2h.mp4
rm -rf ./latest
cd ../
ffmpeg -y -f concat -i radar_loop.txt -c copy radar_loop.mp4

rm radar_2h.mp4
