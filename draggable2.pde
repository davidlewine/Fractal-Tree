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

