class Bullet {
  PVector position;
  PVector velocity;
  
  float angle;
  
  float radius = 10;
  
  Bullet(float x, float y, float vx, float vy, float a) {
    position = new PVector(x, y);
    velocity = new PVector(vx, vy);
    
    angle = a;
  }
  
  void update() {
    position.add(velocity);
    if(dist(position.x, position.y, player.position.x, player.position.y) > sizeConst * width) {
      player.gun.takeOut(this);
    }
  }
  
  void show() {
    pushMatrix();
    
    translate(position.x, position.y);
    rotate(angle);
    
    colorMode(HSB);
    stroke(140, 100, 255);
    noFill();
    ellipse(0, 0, radius, radius);
    colorMode(RGB);
    
    popMatrix();
  }
}
