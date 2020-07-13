source = newArray("D:","G:");
sink = "F:\\" + "2PBehaviorTraces3.csv";

folders = newArray("M35");
subfolders = newArray("010");

run("Close All");
print("STARTING...\n");

for(h = 0; h < source.length; h++){
	
	for (i = 0; i < folders.length; i++) {
		
		print(folders[i] + "\n");
	
		for (j = 0; j < subfolders.length; j++) {
			
			path = source[h] + "\\" + folders[i] + "\\" + "2P_BEHAVIOR" + "\\" + subfolders[j] + "\\" + "OpticalFlow" + "\\";
			
			if(File.exists(path)){
				fileList = getFileList(path);
				if(fileList.length>0){
					File.append(folders[i] + " - " + subfolders[j],sink);
					print(subfolders[j]);
					
					open(path);
					rename("ONE");
					run("Duplicate...", "title=TWO duplicate");
					
					selectWindow("ONE");
					setSlice(7200);
					run("Delete Slice");
					selectWindow("TWO");
					setSlice(1);
					run("Delete Slice");
					
					imageCalculator("Subtract create 32-bit stack", "TWO","ONE");
					selectWindow("Result of TWO");
					run("Plot Z-axis Profile");
					Plot.getValues(x, y);
					
					for (k=0; k<=x.length-1; k++){
						File.append(d2s(x[k],4) + "," + d2s(y[k],4),sink);
					}
				} else {
					File.append("SKIPPED! GO BACK AND CHECK: " + folders[i] + " - " + subfolders[j],sink);
				}
			}
			run("Close All");
		}
			
		print("\n");
		run("Close All");
	}
}