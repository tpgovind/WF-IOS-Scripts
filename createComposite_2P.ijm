dir = "H:\\DATA SOME ONLY ON HERRREEE\\ALL 2P\\Dec22 (N1)\\";
list = getFileList(dir);


for (i = 0; i < list.length; i++){
print(list[i]);
}



for (i = 0; i < list.length; i++){
	open(dir+list[i]);
	run("Deinterleave", "how=2");
	run("Merge Channels...", "c1=["+list[i]+" #2]"+" c2=["+list[i]+" #1] create");
	selectWindow("Composite");
	rename(list[i]);
	//saveAs(dir+"Composite\\"+"("+toString(i)+") "+list[i]);
	//run("Close All");
}



/*
names = newArray(nImages);
ids = newArray(nImages);
for (i=0; i < ids.length; i++){
        selectImage(i+1);
        ids[i] = getImageID();
        names[i] = getTitle();
        saveAs(dir+"("+toString(i+1)+") "+names[i]);
        print(names[i]);
}
*/

/*
names = newArray(nImages);
ids = newArray(nImages);
for (i=0; i < ids.length; i++){
        selectImage(i+1);
        ids[i] = getImageID();
        names[i] = getTitle();
        run("Deinterleave", "how=2");
        run("Merge Channels...", "c1=["+names[i]+" #2]"+" c2=["+names[i]+" #1] create");
        selectWindow("Composite");
        rename(names[i]);
        print(i);
}
*/

