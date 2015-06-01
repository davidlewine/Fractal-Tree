
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
int recIters = 0, maxIters = 35000;


TUI tui;


void setup() {
  size(1400, 600);
  tui = new TUI();
  g = createGraphics(1400,600);
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
    recIters = 0;
    drawBranch(4, 80, 0, width*.4, height*1.1, wl, wr, c);
    g.endDraw();
    image(g, 0, 0);
  tui.display();
  println("recIters: " + recIters);
}

void drawBranch(float w, float s, float theta, float x, float y, float wr, float wl, color c) {
  recIters++;
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
  if (s > minLength && recIters < maxIters) {
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

