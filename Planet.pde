class Planet {

  PVector position;
  PVector velocity;
  PVector acceleration;

  float radius;
  float volume;
  float mass;
  float density;

  final static float G = 0.00008; //Gravitational Constant (It is an arbitrarily chosen number based on intuition after tests)

  Planet(float x, float y, float vx, float vy, float r, float df) {//ARGS:( X position, Y position, initial X velocity,
                                                                  //initial Y velocity, radius, df is density  
    position = new PVector(x, y);
    velocity = new PVector(vx, vy);
    acceleration = new PVector(0, 0);

    radius = r;
    volume = (float)((4.0/3.0) * PI * Math.pow(r, 3));
    mass = volume * df;  //mass == volume * density
    density = df;
  }

  void show() {//to actually draw the planes

    //fill(255);
    noFill();
    stroke(255);
    //strokeWeight(2);
    ellipse(position.x, position.y, radius, radius);
  }

  void update() {//The update function, from the draw(), it gets called after forceCalc, so force is already calculated.

    //forceCalc(other);
    acceleration.div(mass);//Amount of force is stored as acceleration, so to make it real acceleration, divide by mass a
                           // F = ma
    velocity.add(acceleration);
    position.add(velocity);

    acceleration.mult(0);//To reset acceleration as to make sure it doesn't transfer over (think about it before refuting)

    show();
  }

  void forceCalc(Planet other) {  //Calculates amount of force acting on the planet

    PVector force = PVector.sub(other.position, position); // Vector from one planet to the other
    float d = force.mag();
    force.normalize();

    float strength = (G * mass * other.mass)/(d * d);//calculate strength of vector
    force.mult(strength);                            //Multiply the normalised vector with the strenth to get final force between objects

    applyForce(force);

    //if (mass > other.mass) {

    //  combine(other);
    //} else {

    //  touching(other);
    //}
    //if (mass >= other.mass) {//Don't question the if statment. I can't explain in words
    //  combine(other);
    //}
  }

  void applyForce(PVector force) { // adds required force

    acceleration.add(force);
  }

  void touching(Planet other) { //Removed feature, keep it in here if we ever need it again
    //PVector x = PVectoe.sub(other.position, position);
    float x = dist(position.x, position.y, other.position.x, other.position.y);
    if (x < (radius + other.radius)/2) {
      //println("THERE!");
      //x = 2/0;
      //PVector Dir = new PVector(0, 0);
      //Dir = PVector.sub(other.velocity, velocity);

      //Dir.normalize();
      //Dir.mult(velocity.mag());
      //Dir.mult(mass);

      //applyForce(Dir);
      ////Dir.mult((-1 * other.mass)/mass);
      //Dir.mult(-1);
      //other.applyForce(Dir);

      PVector DIR = PVector.sub(other.position, position);
      DIR.setMag(velocity.mag());
      DIR.mult(mass);
      other.applyForce(DIR);
      DIR.mult(-1);
      applyForce(DIR);
    }
  }

  void combine(Planet other) { //Function to combine planets if they collide
    float x = dist(position.x, position.y, other.position.x, other.position.y);
    if (x < (radius + other.radius)/2) {
      
      PVector dirCollision = PVector.sub(other.position, position);
      float r = radius;
      PVector pos = new PVector(position.x, position.y);
      
      PVector velDiff = PVector.sub(other.velocity, velocity);
      float velMag = velDiff.mag();
      //volume += other.volume;
      //mass += other.mass;
      //radius = (float)Math.pow((3 * volume)/(4 * PI), 1.0/3.0);
      
      //density = mass/volume;
      //density = (density + other.density)/2;
      
      //radius = (float)(Math.pow(((3*mass)/(4 * PI))/density, 1.0/3.0));
    
      position.add((PVector.sub(other.position, position)).mult(other.mass/(mass + other.mass)));
      
      PVector p1 = new PVector(velocity.x, velocity.y);
      p1.mult(mass);
      PVector p2 = new PVector(other.velocity.x, other.velocity.y);
      p2.mult(other.mass);
      //println(p1);
      //println(p2);
      
      velocity  = (p1.add(p2)).div(mass + other.mass);
      
      //velocity = (velocity.mult(mass).add(other.velocity.mult(other.mass))).div(mass + other.mass);
      //acceleration.add(other.acceleration.mult(other.mass/mass));
      
      //print(velocity);
      
      volume += other.volume;
      mass += other.mass;
      radius = (float)Math.pow((3 * volume)/(4 * PI), 1.0/3.0);
      
      density = mass/volume;
      
      createDebris(dirCollision, pos, r, other, velMag);
      
      takeOut(other);
    }
  }
  
  void combine(Debris other) { //Function to combine planets if they collide
    float x = dist(position.x, position.y, other.position.x, other.position.y);
    if (x < (radius + other.radius)/2) {
    
      position.add((PVector.sub(other.position, position)).mult(other.mass/(mass + other.mass)));
      
      PVector p1 = new PVector(velocity.x, velocity.y);
      p1.mult(mass);
      PVector p2 = new PVector(other.velocity.x, other.velocity.y);
      p2.mult(other.mass);
      //println(p1);
      //println(p2);
      
      velocity  = (p1.add(p2)).div(mass + other.mass);
      
      //velocity = (velocity.mult(mass).add(other.velocity.mult(other.mass))).div(mass + other.mass);
      //print(velocity.mag());
      //acceleration.add(other.acceleration.mult(other.mass/mass));
      
      volume += other.volume;
      mass += other.mass;
      radius = (float)Math.pow((3 * volume)/(4 * PI), 1.0/3.0);
      
      density = mass/volume;
        
      takeOut(other);
    }
  }
  
  void createDebris(PVector dir, PVector pos, float r, Planet other, float velMag) {
    
    //print(dir);
    
    PVector point = getIntersection(dir, r, other);
    float slope = getPerpendicular(dir);
    
    float totalMass = (random(1, 10)/100.0) * mass;
    
    mass = mass - totalMass;
    volume = mass/density;
    radius = (float)Math.pow((3 * volume)/(4 * PI), 1.0/3.0);
    
    int num = (int)random(40, 120);
    
    float[] masses = new float[num];
    
    int[] ratios   = new int[num];
    int sumTerms = 0;
    
    for(int i = 0; i < ratios.length; i++) {
      ratios[i] = (int)random(1, 10);
      sumTerms += ratios[i];
    }
    
    for(int i = 0; i < masses.length; i++) {
      masses[i] = ((float)ratios[i] * totalMass)/((float)sumTerms);
    }
    
    for(int i = 0; i < num; i++) {
      float vx, vy;
      //println(slope);
      
      if(dir.y != 0) {
        vx = random(-1, 1);// * velocity.x;
        vy = (slope * vx) + random(-0.03, 0.03);
      } else {
        vx = random(-0.03, 0.03);
        vy = random(-1, 1);
      }
      
      float k = 0.0008;
      
      PVector vel = new PVector(vx, vy);
      vel.normalize();
      vel.mult(velMag * k * mass);
      vel.div(masses[i]);
      
      if(Math.abs(volume - other.volume) < (95.0/100.0) * (volume > other.volume? volume:other.volume)) {
        vel.mult(3);
      }
      
      
      float v = masses[i]/density;
      float rad = (float)Math.pow((3 * v)/(4 * PI), 1.0/3.0);
      
      /*debris.add(new Debris(pos.x + point.x + random(-radius/10, radius/10), pos.y + point.y + random(-radius/10, radius/10),
                              vel.x, vel.y, rad, density, this));
      */
      
      float a = random(0, TWO_PI);
      
      float c = ((mass - other.mass)/2.0) * 0.000007;
      float con = random(-c, c);
      
      debris.add(new Debris(pos.x + point.x + random(-radius/10, radius/10), pos.y + point.y + random(-radius/10, radius/10),
                            sin(a) * con, cos(a) * con, rad, density, this));
      
      //print(point.x);
                            
      debrisNum++;
    }
  }
  
  PVector getIntersection(PVector dir, float r, Planet other) {
    float k = 2;
    float x = (r * dir.x)/(dir.mag() * k);
    float y = (r * dir.y)/(dir.mag() * k);
    
    return(new PVector(x, y));
  }
  
  float getPerpendicular(PVector dir) {
    if(dir.y != 0) {
      return(-1 * (dir.x/dir.y));
    } else {
      return(0);
    }
  }
}
