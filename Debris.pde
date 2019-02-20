class Debris extends Planet {
  
  int life;
  float rad;
  
  Planet parent;
  
  Debris(float x, float y, float vx, float vy, float r, float df, Planet p) {
    super(x, y, vx, vy, r, df);
    life = 0;
    rad = p.radius;
    
    parent = p;
  }
  
  void show() {//to actually draw the planes
    
    colorMode(HSB);
    stroke(0, 100, 255);
    noFill();
    //fill(255, 255, 255, 180);
    ellipse(position.x, position.y, radius, radius);
    colorMode(RGB);
  }
  
  void forceCalc(Planet other) {  //Calculates amount of force acting on the planet

    PVector force = PVector.sub(other.position, position); // Vector from one planet to the other
    float d = force.mag();
    force.normalize();
    
    if(d < other.radius) {
      d = other.radius;
    }

    float strength = (G * mass * other.mass)/(d * d);//calculate strength of vector
    force.mult(strength);
    
    applyForce(force);//Multiply the normalised vector with the strenth to get final force between objects
  }
  
  void update() {
    super.update();
    life++;
  }
  
}
