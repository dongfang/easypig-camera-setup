#!/bin/bash
for vid in $(ls -1 /home/pi/videos); do
scp /home/pi/videos/${vid} onedrive@autocampers.de:OneDrive/Sites/FarmerCarsten_20180611/videos/ && rm /home/pi/videos/${vid}
done
