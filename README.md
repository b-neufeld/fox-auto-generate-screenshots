# fox-auto-generate-screenshots
* Use case #1: Take screenshots of graphics or overlays in specified subfolders on the Foxboro DCS. Useful for sharing screenshots of graphics with plant personnel for marking up, error correction, documentation, etc. 
* Use case #2: Comment out the screenshot function and run the script to simply and sequentially open all graphics on a workstation. In FoxView, graphic optimization occurs the first time a graphic is opened on a workstation, so this can save considerable time for operators who can be frustrated by slow or unresponsive graphics on a new machine. 

Brahm Neufeld, May 2016

With help from Foxboro freelists: 

http://www.freelists.org/post/foxboro/Sharing-ksh-script-for-FoxView-display-overlay-screenshots

Instructions

1. Create a blank FoxView graphic called BLANKSCRN.fdf, save it to your graphics folder.

2. Ensure the path to BLANKSCRN.fdf in the script below is correct.

3. Populate the first line of the script with your graphics subfoldfers. 

4. Find-and-replace all instances of LTRBUG with the Display Manager name that will cycle through your graphics and screenshot them (the DM name can be found in the top-left corner of an open FoxView window). 

5. Open command prompt in directory containing this script on the D drive. type sh, type generate_fox_screenshots.ksh. You will see the DM on your workstation open BLANKSCRN.fdf and start cycling through graphics and taking screenshots. 

6. After starting the script, select (give focus to) your FoxView/Control HMI window immediately. The screenshot is taken of the "active window".

7. Depending on how many graphics you have, it may take a while to run. The built-in delays are required so that the graphic can load all objects from the OM. 
