
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
