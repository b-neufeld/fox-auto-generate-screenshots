# Auto-generate screenshots of Foxboro DCS graphics
# Brahm Neufeld, May 2016
# With help from Foxboro freelists: 
# http://www.freelists.org/post/foxboro/Sharing-ksh-script-for-FoxView-display-overlay-screenshots
# 
# Instructions
# 1. Create a blank graphic called BLANKSCRN.fdf, save it to your graphics folder1/
# 2. Ensure the path to BLANKSCRN.fdf in the script below is correct
# 3. Populate the first line of the script with your graphics subfoldfers. 
# 4. Find-and-replace all instances of LTRBUG with the Display Manager name 
#    that will cycle through your graphics and screenshot them. 
# 5. Open command prompt in directory containing this script on the D drive. 
#    type sh, type  generate_fox_screenshots.ksh. You will see the DM on your workstation 
#    open BLANKSCRN.fdf and start cycling through graphics and taking screenshots. 
# 6. Depending on how many graphics you have, it may take a while to run. The 
#    delays are required so that the graphic can load all objects from the OM.

# This for loop will screenshot all .fdf files in folder1, folder2, and folder3, omitting any 
# graphics that contain "exclude" in the filename. List as many folders as required, excluding
# strings as required. 
for DISP in $(find /opt/graphics/folder1/ /opt/graphics/folder2/ /opt/graphics/folder3/ -name "*.fdf" ! -name "*exclude*")
do
	cd d:
	pref -LTRBUG dmcmd /opt/graphics/BLANKSCRN.fdf
	sleep 2
	echo $DISP
	# uncomment the line below for "base" graphics
	pref -LTRBUG dmcmd $DISP
	# uncomment the line below for "overlay" graphics (popup windows)
	# pref -LTRBUG dmcmd "dmcmd ov $DISP -l MIDDLE -move"
	sleep 5
	# Path to Hypersnap on Foxboro workstation
	cd 'C:/Program Files (x86)/HyperSnap 6'
	echo $PWD
	FILE=$(echo `date +%Y-%m-%d`$DISP | sed 's/\//-/g')
	echo $FILE
	# specify where you want to save screenshots to. 
	SAV="D:/opt/graphics/screenshots/$FILE.png"
	echo $SAV
	HprSnap6 -snap:awin -save:png $SAV
	pref -LTRBUG dmcmd close
done


exit
