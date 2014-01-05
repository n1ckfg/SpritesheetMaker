import java.awt.Desktop;

String openFilePath = "output";
String folderPath;
String fileName = "spritesheet";
File dataFolder;

void saveHandler(){
  try{
    alphaImg.save(openFilePath + "/" + fileName + ".png"); 
    println(fileName + ".png saved.");
  }catch(Exception e){
    println("Failed to save file.");  
  }
  openAppFolderHandler();
  exit();
}

//~~~~~~~~~~~~~~~~~~~~~~~~
//choose folder dialog, Processing 2 version

void chooseFolderDialog(){
    selectFolder("Choose a PNG, JPG, GIF, or TGA sequence.","chooseFolderCallback");  // Opens file chooser
}

void chooseFolderCallback(File selection){
    if (selection == null) {
      println("No folder was selected.");
      exit();
    } else {
      folderPath = selection.getAbsolutePath();
      println(folderPath);
      countFrames(folderPath);
    }
}

void countFrames(String usePath) {
    imgNames = new ArrayList();
    //loads a sequence of frames from a folder
    dataFolder = new File(usePath); 
    String[] allFiles = dataFolder.list();
    for (int j=0;j<allFiles.length;j++) {
      if (
        allFiles[j].toLowerCase().endsWith("png") ||
        allFiles[j].toLowerCase().endsWith("jpg") ||
        allFiles[j].toLowerCase().endsWith("jpeg") ||
        allFiles[j].toLowerCase().endsWith("gif") ||
        allFiles[j].toLowerCase().endsWith("tga")){
          imgNames.add(usePath+"/"+allFiles[j]);
        }
    }
    if(imgNames.size()==0){
      exit();
    }else{
      // We need this because Processing 2, unlike Processing 1, will not automatically wait to let you pick a folder!
      firstRun = false;
    }
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//reveal folder, processing 2 version

void openAppFolderHandler(){
  if(System.getProperty("os.name").equals("Mac OS X")){
    try{
      print("Trying OS X Finder method.");
      open(sketchPath(openFilePath));
      //open(sketchPath("ManosOsc.app/Contents/Resources/Java/" + openFilePath));
    }catch(Exception e){ }
  }else{
    try{
      print("Trying Windows Explorer method.");
      Desktop.getDesktop().open(new File(sketchPath("") + "/" + openFilePath));
    }catch(Exception e){ }
  }
}

//run at startup if you want to use app data folder--not another folder.
//This accounts for different locations and OS conventions
void scriptsFolderHandler(){
  String s = openFilePath;
  if(System.getProperty("os.name").equals("Mac OS X")){
    try{
      print("Trying OS X Finder method.");
      openFilePath = dataPath("") + "/" + s;
    }catch(Exception e){ }
  }else{
    try{
      print("Trying Windows Explorer method.");
      openFilePath = sketchPath("") + "/data/" + s;
    }catch(Exception e){ }
  }
}

