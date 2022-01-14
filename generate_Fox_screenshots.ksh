# Auto-generate screenshots of Foxboro DCS graphics
# Brahm Neufeld, May 2016
# With help from Foxboro freelists: 
# http://www.freelists.org/post/foxboro/Sharing-ksh-script-for-FoxView-display-overlay-screenshots
# 
# Instructions
# 1. Create a blank graphic called BLANKSCRN.fdf, save it to your graphics folder
# 2. Ensure the path to BLANKSCRN.fdf in the script below is correct
# 3. Populate the first line of the script with your graphics subfoldfers. 
# 4. Find-and-replace all instances of LTRBUG with the Display Manager name 
#    that will cycle through your graphics and screenshot them. 
# 5. Open command prompt in directory containing this script on the D drive. 
#    type sh, type  generate_fox_screenshots.ksh. You will see the DM on your workstation 
#    open BLANKSCRN.fdf and start cycling through graphics and taking screenshots. 
# 6. Depending on how many graphics you have, it may take a while to run. The 
#    delays are required so that the graphic can load all objects from the OM.
# 7. The screenshot functions can be commented out to simply open all graphics or 
#    overlays one by one (graphics optimizer)



# initial sleep command so that user has time to give focus to the appropriate FoxView DM. 
sleep 5

# This for loop will screenshot all .fdf files in folder1, folder2, and folder3, omitting any 
# graphics that contain "exclude" in the filename. List as many folders as required, excluding
# strings as required. 
for DISP in $(find /opt/graphics/folder1/ /opt/graphics/folder2/ /opt/graphics/folder3/ -name "*.fdf" ! -name "*exclude*")
do
	cd d:
	pref -LTRBUG dmcmd /opt/graphics/BLANKSCRN.fdf
	sleep 1
	# debug output
	echo $DISP
	
	# display manager command to open display. 
	pref -LTRBUG dmcmd $DISP
	
	# pause script for this long to ensure graphic has time to make all connections
	sleep 5
	
	# SCREENSHOT SECTION----------------------------------
	#  COMMENT OUT THIS WHOLE SECTION TO TRANSFORM THIS SCRIPT 
	#  INTO A GRAPHICS OPTIMIZER 
	# Path to Hypersnap on Foxboro workstation
	cd 'C:/Program Files (x86)/HyperSnap 6'
	# specify where you want to save screenshots to. 
	# screenshots will be saved in the same folder structure as the Foxboro workstation
	# but in the directory tree specified below.
	SAV="D:/opt/graphics/screenshots/$DISP.png"
	# if a directory doesn't exist, create it. 
	DIR=$(dirname "${SAV}")
	mkdir -p $DIR
	# echo debug output 
	echo $SAV
	# save command to HyperSnap (FoxView DM must have focus) 
		# EXTRA NOTES 2022-01-14 from Brian Long, running on a Win2008/HyperSnap6 setup:
		# "It needed to have an -exit at the end of the command line otherwise it only works once. Also had to put in a few more sleeps to give everything a “chance” to work."
		# "One more thing, since DISP is /x/x/x, it was putting an extra slash in in the command line as well, changed to D:/opt/graphics/screenshots$DISP.jpeg"
		# Brian's edited line for the main command: 
		# HyprSnap6.exe -snap:awin -save d:/blah/blah.jpeg -exit
	HprSnap6 -snap:awin -save:png $SAV
	# END SCREENSHOT SECTION------------------------------
	
	
	
	# close graphic
	pref -LTRBUG dmcmd close
done

# This is nearly the exact same loop as above, but is optimized for overlays. It opens and 
# closes them properly and doesn't include the background graphic in the screenshot. 
for DISP in $(find /opt/overlays/folder1/ /opt/overlays/folder2/ /opt/overlays/folder3/ -name "*.fdf" ! -name "*exclude*")
do
	cd d:
	pref -LTRBUG dmcmd /opt/graphics/BLANKSCRN.fdf
	sleep 1
	# debug output
	echo $DISP
	
	# display manager command to open display. (overlay-specific) 
	pref -LTRBUG dmcmd "dmcmd ov $DISP -l MIDDLE -move"
	
	# pause script for this long to ensure graphic has time to make all connections
	sleep 5
	
	# SCREENSHOT SECTION----------------------------------
	#  COMMENT OUT THIS WHOLE SECTION TO TRANSFORM THIS SCRIPT 
	#  INTO A GRAPHICS OPTIMIZER 
	# Path to Hypersnap on Foxboro workstation
	cd 'C:/Program Files (x86)/HyperSnap 6'
	# specify where you want to save screenshots to. 
	# screenshots will be saved in the same folder structure as the Foxboro workstation
	# but in the directory tree specified below.
	SAV="D:/opt/graphics/screenshots/$DISP.png"
	# if a directory doesn't exist, create it. 
	DIR=$(dirname "${SAV}")
	mkdir -p $DIR
	# echo debug output 
	echo $SAV
	# save command to HyperSnap (FoxView DM must have focus) 
	HprSnap6 -snap:awin -save:png $SAV
	# END SCREENSHOT SECTION------------------------------
	
	# close graphic - the -all ensures all overlays are closed. 
	pref -LTRBUG dmcmd close -all
done


exit
