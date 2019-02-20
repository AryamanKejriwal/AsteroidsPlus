class SParticle{
  PVector pos;
  PVector vel;
  
  float radius;
  
  float colour;
  int vis = 255;
  
  SParticle(float x, float y, float xVel, float yVel, float r, float col) {
    pos = new PVector(x, y);
    vel = new PVector(xVel, yVel);
    
    radius = r;
    
    colour = col;
  }
  
  void show() {
    colorMode(HSB);
    //fill(255, 255, 255, map(vel.y, 0, maxYvel, 0, 200));
    
    fill(colour, 255, 255);
    noStroke();
    ellipse(pos.x, pos.y, radius, radius);
    
    colorMode(RGB);
  }
  
  void update() {
    pos.add(vel);
    vis--;
    colour += 2.8;
  }
}
