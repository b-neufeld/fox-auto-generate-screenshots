# fox-auto-generate-screenshots
* Use case: Take screenshots of graphics or overlays in specified subfolders on the Foxboro DCS. Useful for sharing screenshots of graphics with plant personnel for marking up, error correction, documentation, etc. 
* Use case: Comment out the screenshot function and run the script to open all graphics on a workstation (graphic optimization occurs the first time a graphic is opened on a WP). Useful for quickly eliminating the lag associated with opening graphics for the first time on a new AW or WP.

Brahm Neufeld, May 2016

With help from Foxboro freelists: 

http://www.freelists.org/post/foxboro/Sharing-ksh-script-for-FoxView-display-overlay-screenshots

Instructions

1. Create a blank graphic called BLANKSCRN.fdf, save it to your graphics folder1

2. Ensure the path to BLANKSCRN.fdf in the script below is correct

3. Populate the first line of the script with your graphics subfoldfers. 

4. Find-and-replace all instances of LTRBUG with the Display Manager name  that will cycle through your graphics and screenshot them. 

5. Open command prompt in directory containing this script on the D drive. type sh, type  generate_fox_screenshots.ksh. You will see the DM on your workstation  open BLANKSCRN.fdf and start cycling through graphics and taking screenshots. 

6. Be sure to select your FoxView/Control HMI window immediately after starting the script. The screenshot is taken of the "active window".

7. Depending on how many graphics you have, it may take a while to run. The delays are required so that the graphic can load all objects from the OM.
