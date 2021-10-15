#!/bin/bash
printf "Radar Collector [ hit CTRL+C to stop ]\n\n\n"

for (( ; ; ))
do
DATE=$(date +"%Y%m%d%H%M")
HOUR=$(date +"%H")
	printf "[ACTION] Collection Started: ${HOUR}z\n"
	mkdir -p ./map/latest
	cd ./map


	find *.png -mmin -120 -exec cp -a -t ./latest "{}" \+
	rm ./latest/traffic*
	rm ./latest/base*

	cd ./latest
	#cat *.png | ffmpeg -loglevel panic -f image2pipe -r 1 -i - -vcodec libx264 radar_2h.mp4
	cat $(find . -maxdepth 1 -name "*.png" | sort -V) | ffmpeg -framerate 15 -i - radar_2h.avi
	rm -rf ./*.png
	cp radar_2h.avi ~/radar_$DATE.avi
	rm radar_2h.avi
	cd ../../

	printf "[ACTION] Sleeping for 2 hours ...\n\n\n"
	sleep 2h
done
