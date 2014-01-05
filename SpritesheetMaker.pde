// http://processing.org/discourse/beta/num_1191532471.html

PImage img;
PGraphics alphaImg;
ArrayList imgNames;
int maxWidth = 512;
int rowCount, sW, sH;
boolean firstRun = true;
void setup(){
  Settings settings = new Settings("settings.txt");
  chooseFolderDialog();

  while(firstRun){
    try{
      if(imgNames.size() > 0) img = loadImage((String) imgNames.get(0));
    }catch(Exception e){ }
  }
  
  rowCount = int(maxWidth/img.width);
  if(rowCount<1)rowCount=1;
  sW = img.width*rowCount;
  sH = int(img.height * rounder(float(imgNames.size())/float(rowCount), 0));  
  size(sW+img.width,sH+img.height); 
  // create a pgraphics object for rendering on a transparent background 
  alphaImg = createGraphics(width,height,JAVA2D);  
}

void draw() {
    background(0);
    
    // draw into the pgraphics object
    alphaImg.beginDraw();
    // make sure its alpha is set to 0
    alphaImg.loadPixels();
    for(int i=0;i<alphaImg.pixels.length;i++){
      alphaImg.pixels[i] = color(0,0);
    }
    alphaImg.updatePixels();
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  int xPos = 0;
  int yPos = 0;
  for (int i=0;i<imgNames.size();i++) {
    try{
      img = loadImage((String) imgNames.get(i));
    }catch(Exception e){ }
    alphaImg.image(img, xPos*img.width, yPos*img.height);
    xPos++;
    if(xPos>=rowCount){
      xPos = 0;
      yPos++;
    }
  }
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    alphaImg.endDraw();
   
    // draw the second renderer into the window, so we can see something 
    image(alphaImg, 0,0);
    saveHandler();
}

float rounder(float _val, float _places) {
  _val *= pow(10, _places);
  _val = round(_val);
  _val /= pow(10, _places);
  return _val;
}

