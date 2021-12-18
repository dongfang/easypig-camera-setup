for pic in $(ls -1 /home/pi/pictures); do
pic=/home/pi/pictures/$pic
if [ -d $pic ]; then continue; fi
#scp pictures/${pic} onedrive@autocampers.de:OneDrive/Sites/FarmerCarsten_20180611/pictures2/ && rm pictures/${pic}
dir=$(echo $pic | cut -d_ -f2)
simple=webcam_$(echo $pic | cut -d_ -f3)
dir=/home/pi/pictures/${dir}
if [ ! -d $dir ]; then 
echo creating daydir: $dir
mkdir $dir
fi
#mv $pic $dir
echo move $pic to $dir/$simple
mv $pic $dir/$simple
done

for dir in $(ls -1 /home/pi/pictures); do
if [ -d /home/pi/pictures/$dir ]; then
echo now copying $dir
scp -r /home/pi/pictures/${dir} onedrive@autocampers.de:OneDrive/Sites/FarmerCarsten_20180611/pictures2/ && rm -rf /home/pi/pictures/${dir}
# also remove it.
fi
done
