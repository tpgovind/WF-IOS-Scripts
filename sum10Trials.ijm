sourceDir = "D:\\C21 (Driving Gq Signaling)\\18-Jul (#F)\\AFTER 2nd C21 (+0.1 mgPerKg)\\";
sinkDir = "D:\\C21 (Driving Gq Signaling)\\18-Jul (#F)\\AFTER 2nd C21 (+0.1 mgPerKg)\\SUM_TRIALS\\";
File.makeDirectory(sinkDir);

numTrials = 6;
trials = newArray(numTrials);

for (i=0;i<numTrials;i++) {
	
	trials[i] = "Trial " + i+1;
	//trials[i] = "T" + i+1;
}

run("Image Sequence...", "open=["+sourceDir+trials[0]+"\\CaHemo\\] sort");
rename("SUM");

for (k=1;k<trials.length;k++) {
	selectWindow("SUM");
	rename("PREVIOUS_SUM");
	run("Image Sequence...", "open=["+sourceDir+trials[k]+"\\CaHemo\\] sort");
	rename("CURR");
	imageCalculator("Add create 32-bit stack", "PREVIOUS_SUM","CURR");
	rename("SUM");
	close("\\Others");
	print("Trial loop:" + k);
}

selectWindow("SUM");
run("Image Sequence... ", "format=TIFF name=CaHemo save=["+sinkDir+"]");
run("Close All");