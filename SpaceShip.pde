class SpaceShip {
  PVector position;
  PVector velocity;
  
  boolean thrust;
  
  float angle;
  float angleVel;
  boolean[] turn = {false, false};
  
  boolean isAlive = true;
  
  Gun gun = new Gun();
  Jetpack thrusters;
  
  ArrayList<SParticle> parts = new ArrayList<SParticle>();
  
  final float size = 1;
  
  final static float maxVel = 7.5;
  
  SpaceShip(float x, float y, float vx, float vy, float a) {
    position = new PVector(x, y);
    velocity = new PVector(vx, vy);
    
    thrust = false;
    
    angle = a;
    angleVel = 0;
    
    thrusters = new Jetpack(230, x, y);
  }
  
  void run() {
    if(isAlive) {
      update();
      show();
    } else {
      updateP();
    }
  }
  
  void show() {
    thrusters.show();
    //stroke(100, 200, 160);
    fill(255);
    noStroke();
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    //rect(position.x, position.y, 80, 30);
    
    beginShape();
    vertex(  0 * size, -20  * size);
    vertex(-15 * size,  20  * size);
    vertex( 15 * size,  20  * size);
    endShape(CLOSE);
    
    popMatrix();
    
    gun.show();
  }
  
  void update() {
    float k = 0.4;
    if(thrust) {
      velocity.add(new PVector(sin(angle) * k, -1 * cos(angle) * k));
    }
    
    if(velocity.mag() > maxVel) {
      velocity.normalize();
      velocity.mult(maxVel);
    }
    
    position.add(velocity);
    
    if(turn[0] && turn[1]) {
      
    } else if(turn[0]) {
      angleVel += radians(0.5);
    } else if(turn[1]) {
      angleVel -= radians(0.5);
    }
    if(thrust) {
      angleVel *= 0.95;
    } else {
      angleVel *= 0.99;
    }
    if(angleVel > radians(3)) {
      angleVel = radians(3);
    } else if(angleVel < -1 * radians(3)) {
      angleVel = -1 * radians(3);
    }
    angle += angleVel;
    
    gun.update();
    thrusters.update(position.x, position.y);
  }
  
  void fire() {
    gun.fire(position.x + 20 * sin(angle), position.y - 20 * cos(angle), angle);
  }
  
  
  void dead() {
    if(isAlive) {
      createParticles();
    }
    
    isAlive = false;
  }
  
  void createParticles() {
    int num = (int)random(400, 450);
    for(int i = 0; i < num; i++) {
      float a = random(0, TWO_PI);
      float k = random(10, 15);
      parts.add(new SParticle(position.x, position.y, sin(a) * k, cos(a) * k, random(3, 7), 0));
    }
  }
  
  void updateP() {
    for(SParticle p : parts) {
      p.update();
      p.show();
    }
  }
}
