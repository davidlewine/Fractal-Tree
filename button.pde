class Button{
  PImage img;
  int x, y;
  boolean on = false;
  boolean changed = false;
  
  Button(String imgFile, int xx, int yy){
    img = loadImage(imgFile);
    x = xx;
    y = yy;
  }
  
  void display(){
    image(img, x, y);
    if(on){
      fill(255, 255, 0, 50);
      noStroke();
      ellipse(x+img.width/2, y+img.height/2, img.width, img.height);
    }
  }
  
  void update(){
    if(mousePressed && mouseX > x && mouseX < x + img.width 
        && mouseY > y && mouseY < y+img.height){
       on = true;
       changed = true;
    }
    else{
      changed = false;
    }
    display();
  }
  
  void off(){
    on = false;
  }
}
