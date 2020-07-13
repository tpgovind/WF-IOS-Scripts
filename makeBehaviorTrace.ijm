//source = newArray("D:\\","G:\\");
source = newArray("D:\\");
//folder = newArray("M1","M2","M3","M4","M5","M6","M7","M8","M9","M10","M11\\AFTER 3mgPerKg C21","M11\\BEFORE 3mgPerKg C21","M12\\BEFORE C21","M12\\AFTER 1st C21 (+0.03 mgPerKg)","M12\\AFTER 2nd C21 (+0.06 mgPerKg)","M12\\AFTER 3rd C21 (+0.09 mgPerKg)","M13\\BEFORE C21","M13\\AFTER 1st C21 (+0.1 mgPerKg)","M13\\AFTER 2nd C21 (+0.1 mgPerKg)","M14\\BEFORE C21","M14\\AFTER 1st C21 (+0.15 mgPerKg)","M15\\BEFORE","M15\\AFTER 0.1mgPerKg","M16\\BEFORE","M16\\AFTER 0.1 mgPerKg C21","M17","M18");
//folder = newArray("M18\\FITC","M19","M20","M21","M22","M23","M24","M25","M26","M27","M28","M29","M29\\FITC","M30","M31","M32","M33","M34","M35","M36","M37","M38","M39","M40","M41","M42","M43","M44","M45","M46","M47","M48","M49","M50","M51","M52","M53","M54","M55","M56","M57","M58","M59","M60","M61","M62","M63","M64","M65","M66","M67","M68","M69","M70","M71","M72","M73","M74","M75");
folder = newArray("M12\\AFTER_1st_C21","M12\\AFTER_2nd_C21","M12\\AFTER_3rd_C21","M13\\AFTER_1st_C21","M13\\AFTER_2nd_C21");
basal = newArray("Basal 1", "Basal 2", "Basal 3", "Basal 4", "Basal 5", "Basal 6", "Basal 7", "Basal 8", "Basal 9", "Basal 10");
trial = newArray("Trial 1", "Trial 2", "Trial 3", "Trial 4", "Trial 5", "Trial 6", "Trial 7", "Trial 8", "Trial 9", "Trial 10");
//basal = newArray("Basal", "Basal 1", "Basal 2", "Basal 3", "Basal 4", "Basal 5", "Basal 6", "Basal 7", "Basal 8", "Basal 9", "Basal 10", "Basal 11", "Basal 12", "Basal 13", "Basal 14", "Basal 15", "Basal 16", "Basal 17", "Basal 18", "Basal 19", "Basal 20");
//trial = newArray("Trial 0", "Trial 1", "Trial 2", "Trial 3", "Trial 4", "Trial 5", "Trial 6", "Trial 7", "Trial 8", "Trial 9", "Trial 10", "Trial 11", "Trial 12", "Trial 13", "Trial 14", "Trial 15", "Trial 16", "Trial 17", "Trial 18", "Trial 19", "Trial 20");
sink = "F:\\" + "BehaviorTraces.txt";

run("Close All");
print("STARTING...\n");

for(h = 0; h < source.length; h++){
	
	for (i = 0; i < folder.length; i++) {
		
		print(folder[i] + "\n");
	
		for (j = 0; j < basal.length; j++) {
			
			path = source[h] + folder[i] + "\\" + basal[j] + "\\" + "OpticalFlow" + "\\";
			//path = source[h] + folder[i] + "\\" + basal[j] + "\\" + "Beh" + "\\";
			
			if(File.exists(path)){
				fileList = getFileList(path);
				if(fileList.length>0){
					File.append(folder[i] + " - " + basal[j],sink);
					print(basal[j]);
					
					open(path);
					rename("ONE");
					//roiManager("select", 0);
					//selectWindow("ONE");
					//run("Crop");
					//selectWindow("ONE");
					run("Duplicate...", "title=TWO duplicate");
					
					selectWindow("ONE");
					setSlice(7200);
					//setSlice(3600);
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
					File.append("SKIPPED! GO BACK AND CHECK: " + folder[i] + " - " + basal[j],sink);
				}
			}
			run("Close All");
			//File.append("\n",sink);
		}
			
		for (l = 0; l < trial.length; l++) {
			
			path = source[h] + folder[i] + "\\" + trial[l] + "\\" + "OpticalFlow" + "\\";
			//path = source[h] + folder[i] + "\\" + trial[l] + "\\" + "Beh" + "\\";
			
			if(File.exists(path)){
				fileList = getFileList(path);
				if(fileList.length>0){
					File.append(folder[i] + " - " + trial[l],sink);
					print(trial[l]);
					
					open(path);
					rename("ONE");
					//roiManager("select", 0);
					//selectWindow("ONE");
					//run("Crop");
					//selectWindow("ONE");
					run("Duplicate...", "title=TWO duplicate");
					
					selectWindow("ONE");
					//setSlice(7200);
					setSlice(7200);
					run("Delete Slice");
					selectWindow("TWO");
					setSlice(1);
					run("Delete Slice");
						
					imageCalculator("Subtract create 32-bit stack", "TWO","ONE");
					selectWindow("Result of TWO");
					run("Plot Z-axis Profile");
					Plot.getValues(x, y);
						
					for (m=0; m < x.length; m++){
						File.append(d2s(x[m],4) + "," + d2s(y[m],4),sink);
					}
				} else {
					File.append("SKIPPED! GO BACK AND CHECK: " + folder[i] + " - " + trial[l],sink);
				}
			}
			run("Close All");
			//File.append("\n",sink);
		}
		print("\n");
		run("Close All");
	}
}