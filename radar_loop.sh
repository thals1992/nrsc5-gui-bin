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
	cat ./latest/*.png | ffmpeg -loglevel panic -f image2pipe -r 1 -i - -vcodec libx264 ../radar_2h.mp4
	rm -rf ./latest
	cd ../

	printf "[ACTION] Outputting Radar Video\n"
	ffmpeg -loglevel panic -y -f concat -i radar_loop.txt -c copy radar_loop_$DATE.mp4

	rm radar_2h.mp4
	cp radar_loop_$DATE.mp4 ~/
	rm radar_loop_$DATE
	
	printf "[ACTION] Sleeping for 2 hours ...\n\n\n"
	sleep 2h
done
