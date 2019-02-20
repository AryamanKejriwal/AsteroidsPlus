class Particle {
  
  PVector pos;
  PVector vel;
  PVector acc = new PVector(random(-0.01, 0.01), random(-0.8, -6));
  
  PVector dev = new PVector(random(-1, 1), random(-1, 1));
  
  float radius = random(3, 10);
  
  float maxYvel;
  
  boolean alive = true;
  
  float angle = player.angle;
  
  Particle(float x, float y, float xVel, float yVel) {
    pos = new PVector(x + random(-10, 10), y + random(-10, 10));
    vel = new PVector(xVel, yVel);
    
    maxYvel = yVel;
  }
  
  void show() {
    colorMode(HSB);
    //fill(255, 255, 255, map(vel.y, 0, maxYvel, 0, 200));
    
    fill(map(vel.y, 1.5, maxYvel, 0, 255), 255, 255, map(vel.y, 0, maxYvel, 0, 255));
    noStroke();
    ellipse(pos.x, pos.y, radius, radius);
    
    colorMode(RGB);
  }
  
  void update() {
    
    /*if(pos.y > height/2 - 20) {
      vel.x *= (1 + vel.y/25);
      vel.y *= 0.9;
      
    }*/
    
    vel.add(acc);
    pos.add(new PVector(vel.x * sin(angle) + dev.x, vel.y * cos(angle) + dev.y));
    
    if(vel.y <= 0) {
      alive = false;
    }
    
    //wrapAround();
  }
  
    void wrapAround() {
    if(pos.x - radius > width/2) {
      pos.x = -width/2 - radius;
    } else if(pos.x + radius < -width/2) {
      pos.x = width/2 + radius;
    }
  }
}

/*
{x + ((-15) * cos) - (20    * sin), y + ((-15) * sin) + ((20)  * cos)}, //x = -15, y =  20
{x + ((15)  * cos) - (20    * sin), y + (15    * sin) + ((20)  * cos)}, //x =  15, y =  20
*/
