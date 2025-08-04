// This macro is meant to help your flight assay measurement.

run("Set Measurements...");


// Step 1: Prompt user to choose a file
path = File.openDialog("Select a clipped image file");

// Remove extension from path
dotIndex = lastIndexOf(path, ".");
if (dotIndex != -1) {
    base = substring(path, 0, dotIndex);
} else {
    base = path; // no extension found
}

// Open the selected file
open(path);



// Step 2: Convert the image to 8-bit

run("8-bit");


// Step 3: Ask user to draw a line for scale

waitForUser("Draw a straight line with the Line tool to set the scale, then click OK.");



// Step 4: Open Set Scale dialog

run("Set Scale...");
run("Select None");


getPixelSize(unit, pixelWidth, pixelHeight);




// Step 5: Adjust brightness
run("Brightness/Contrast...");
waitForUser("Adjust brightness/contrast, click Apply, close the Brightness/Contrast window, then click OK here to continue.");


// Step 6: Set threshold
run("Threshold...");
waitForUser("Adjust the threshold, click Apply, close the Threshold window, then click OK to continue.");



// Step 7: Particle analysis and ROI recording
run("Analyze Particles...", "size=0.01-0.1 show=Nothing clear include exclude add");
roiPath = base + "_roi.zip";
roiManager("Save", roiPath);
roiManager("Reset");
run("Close All");

// Step 8: 

open(path);
open(roiPath);
run("Set Scale...", "distance=1 known=" + pixelWidth + " unit=" + unit);
run("Select None");

// Step 3: Ask user to draw a line for scale

//waitForUser("Draw a straight line with the Line tool to set the scale, then click OK.");

waitForUser("In the ROI manager, tick 'Lables'. By clicking 'Show All', you can toggle labels in the image viewer. You can manually add/remove ROIs, then make a measurement.");

