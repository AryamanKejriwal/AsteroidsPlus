class ParticleSystem {

  PVector pos;

  int frequency;

  ArrayList<Particle> particles = new ArrayList<Particle>();

  ParticleSystem(float x, float y, int f) {
    pos = new PVector(x, y);
    frequency = f;
  }

  void update(float x, float y, boolean isOn) {
    
    float a = player.angle;
    
    /*
    {x + ((-15) * cos) - (20    * sin), y + ((-15) * sin) + ((20)  * cos)}, //x = -15, y =  20
    {x + ((15)  * cos) - (20    * sin), y + (15    * sin) + ((20)  * cos)}, //x =  15, y =  20
    */
    
    pos.x = ((x + ((-15) * cos(a)) - (20    * sin(a))) + (x + ((15)  * cos(a)) - (20    * sin(a))))/2.0;
    pos.y = ((y + ((-15) * sin(a)) + ((20)  * cos(a))) + (y + (15    * sin(a)) + ((20)  * cos(a))))/2.0;
    
    for(int i = particles.size() - 1; i >= 0; i--) {
      if(!(particles.get(i).alive)) {
        particles.remove(i);
      }
    }
    
    
    if (isOn) {
      for (int i = 0; i < frequency * frequency/2200.0; i++) {
        if (random(0, 1) > 0.5) {
          particles.add(new Particle((int)pos.x, (int)pos.y, random(-3, 3), random(4,6)));
        }
      }
    }

    for (Particle p : particles) {
      p.update();
    }
  }

  void show() {
    for (Particle p : particles) {
      p.show();
    }
  }
}
