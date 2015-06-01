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

