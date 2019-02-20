class Gun {
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
  void update() {
    for(int i = bullets.size() - 1; i >= 0; i--) {
      float d = dist(player.position.x, player.position.y, bullets.get(i).position.x, bullets.get(i).position.y);
      if(d > sizeConst * width) {
        bullets.remove(i);
      } else {
        bullets.get(i).update();
      }
    }
    
    checkHit();
  }
  
  void show() {
    for(Bullet b : bullets) {
      b.show();
    }
  }
  
  void fire(float x, float y, float a) {
    float k = 15 ;
    bullets.add(new Bullet(x, y, sin(a) * k, -1 * cos(a) * k, a));
  }
  
  void checkHit() {
    for(int i = planets.size() - 1;  i >= 0; i--) {
      for(int j = bullets.size() - 1;j >= 0; j--) {
        try{
          if(dist(planets.get(i).position.x, planets.get(i).position.y, bullets.get(j).position.x, bullets.get(j).position.y) <= ((planets.get(i).radius)/2.0)) {
            hit(bullets.get(j), planets.get(i));
          }
        } catch(Exception e) {
          //j++;
        }
      }
    }
  }
  
  void takeOut(Bullet b) {
    bullets.remove(b);
  }
}
