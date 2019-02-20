class Jetpack {
  
  boolean isOn = false;
  
  int fuel;
  int maxFuel;
  
  PVector pos;
  
  ParticleSystem p;
  
  Jetpack(int f, float x, float y) {
    
    maxFuel = f;
    fuel    = f;
    
    pos = new PVector(x, y);
    
    p = new ParticleSystem(x, y, fuel);
  }
  
  void update(float x, float y) {
    pos.x = x;
    pos.y = y;
    
    p.frequency = fuel;
    p.update(pos.x, pos.y, isOn);
  }
  
  void show() {
    p.show();
  }
  
  void fillFuel() {
    fuel += (int)(maxFuel/40.0);
    fuel = constrain(fuel, 0, maxFuel);
  }
  
  
  
}
