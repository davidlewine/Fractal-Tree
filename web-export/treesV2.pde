
int m = 2;
int minLength = 2;
float sc = 1;
int leaf = -1;
int leafColor = 1;
float t = 9;
float wr = 1.5;
float wl = 1.5;
color c;
PGraphics g;


TUI tui;


void setup() {
  size(800, 600);
  tui = new TUI();
  g = createGraphics(1200,600);
  g.beginDraw();
  g.clear();
  g.fill(200);
  g.rect(20, 20, 200, 200);
  g.endDraw();
}

void draw() {
  background(200);
  leafColor = 1;
  t = tui.theta; //tSlider.y * 20 / height;
  wr = 2 -  tui.wr/350;
  wl = 2 -  tui.wl/350;
  
  //scale(sc, sc); 
  tui.update();

    
    if (wr>wl) {
      c = color(125, 75, 75);
    } else {
      c = color(100, 50, 50);
    }
    g.beginDraw();
    g.clear();
    drawBranch(4, 80, 0, width*.4, height*1.1, wl, wr, c);
    g.endDraw();
    image(g, 0, 0);
  tui.display();
}

void drawBranch(float w, float s, float theta, float x, float y, float wr, float wl, color c) {
  
  color newCR, newCL;
  
  if (wr>wl) {
    newCR = color(125, 75, 75);
    newCL = color(100, 50, 50);
  } else {
    newCR = color(100, 50, 50);
    newCL = color(125, 75, 75);
  }
  
  g.stroke(c);
  g.strokeWeight(s/2);
  g.translate(x, y);
  g.rotate(theta);
  g.line(0, 0, 0, -s*m);
  if (s > minLength) {
    if (tui.nonAlt.on) {//don't alternate lengths of branches
      drawBranch(w, s/wr, t, 0, -s*m, wr, wl, newCR);
      drawBranch(w, s/wl, -t, 0, -s*m, wr, wl, newCL);
    } else {//alternate lengths of branches
      drawBranch(w, s/wr, t, 0, -s*m, wl, wr, newCR);
      drawBranch(w, s/wl, -t, 0, -s*m, wl, wr, newCL);
    }
  } else {
    if (leaf > 0) {
      drawLeaf(0, -s*m);
    }
  }
  g.rotate(-theta);
  g.translate(-x, -y);
}

void drawLeaf(float x, float y) {

  fill((leafColor)%255, 255 -(leafColor)%255, 0, 100);

  int r = 30;
  ellipse(x, y, r, r);
  leafColor = leafColor+1;
} 

void keyReleased() {
  if (key == 'o') {
    sc += .1;
  }

  if (key == 'i') {
    sc -= .1;
  }
  if (key == ' ') {
    leaf = leaf * -1;
  }
}


class TUI{
  float theta = 0;
  float wr = 0;
  float wl = 0;
  float xo, yo;
  int w = 300;
  int h = 400;
  int offset = 50;
  int maxGrowth = 300;
  Draggable2 lNode;
  Draggable2 rNode;
  Button alt, nonAlt;
  
  boolean changed = false;
  
  TUI(){
    xo = width-(w/2+offset);
    yo = height - offset;
  lNode = new Draggable2(width - 3*(w - offset)/3, height - h/2, color(0, 255, 0, 150), 20);
  rNode = new Draggable2(width - 2*(w - offset)/3, height - h/2, color(0, 255, 0, 150), 10);
  alt = new Button("alternating.png",width -250, 50);
  nonAlt = new Button("nonAlternating.png",width - 100,50);
  }
  
  void update(){
    //display(); 
    alt.update();
  if(alt.on){
    nonAlt.off();
  }
  nonAlt.update();
  if(nonAlt.on){
    alt.off();
  }
    lNode.update();
    rNode.update();
    if(lNode.changed || rNode.changed || alt.changed || nonAlt.changed){
      changed = true;
    }
    else{
      changed = false;
    }
    wr = min(maxGrowth,sqrt(pow(rNode.x-xo, 2) + pow(rNode.y - yo, 2)));
    wl = min(maxGrowth,sqrt(pow(lNode.x-xo, 2) + pow(lNode.y - yo, 2)));
    theta = PI - (atan(abs((yo - rNode.y)/(xo - rNode.x))) + atan(abs((yo - lNode.y)/(xo - lNode.x))));
    //println(theta);
  }
  void display(){
    fill(225, 225, 225, 100);
    rect(width - (w+offset), height - (h+offset), w, h);
    strokeWeight(10);
    stroke(255, 0, 0);
    line(lNode.x, lNode.y, xo, yo);
    line(rNode.x, rNode.y, xo, yo);
    lNode.display();
    rNode.display();
    alt.display();
    nonAlt.display();
    
  }
  
 
}
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
class Draggable {

  boolean dragging = false;
  float x = 0;
  float y = 0;
  float r;
  color c;
  color cInd;


  Draggable(float xx, float yy, color cc) {
    x = xx;
    y = yy;
    cInd = cc;
    c = cInd;
    r = 20;
  }

  void update() {
    if (mousePressed) {
      if (dist (mouseX, mouseY, x, y) < r) {
        if (!dragging) {
          dragging = true;
          c = color(255, 255, 0);
        }
        
      } 
      else {
        dragging = false;
        c = cInd;
      }
    }
    if (dragging) {
      if (keyPressed) {
        if (keyCode == UP) {
          y -= 2;
        } 
        else if (keyCode == DOWN) {
          y += 2;
        }
      }
    }
    fill(c);
    ellipse(x, y, 2*r, 2*r);
  }
}

class Draggable2 {

  boolean dragging = false;
  boolean changed = false;
  float x, y, oldx = 0, oldy = 0;
  float r;
  color c;
  color cInd;


  Draggable2(float xx, float yy, color cc, int rr) {
    x = xx;
    y = yy;
    cInd = cc;
    c = cInd;
    r = rr;
  }

  void update() {
    if (mousePressed) {
      if (dist (mouseX, mouseY, x, y) < r) {
        if (!dragging) {
          dragging = true;
          c = color(255, 255, 0);
        }
      }
    } else {
      dragging = false;
      c = 0;
    }
    if (dragging) {
      x = mouseX;
      y = mouseY;
      if(oldx != x || oldy != y){
        changed = true;
        oldx = x;
        oldy = y;
      }
      else{
        changed = false;
      }
    }
    
  }
  
  void display(){
    fill(c);
    stroke(cInd);
    strokeWeight(10);
    ellipse(x, y, 2*r, 2*r);
  }
}


