
SpaceShip player = new SpaceShip(0, 0, 0, 0, 0);

boolean start = false;
long score    = 0;

final int sizeConst = 1;

ArrayList<Planet> planets = new ArrayList<Planet>(); //ArrayList of Planets
ArrayList<Debris> debris  = new ArrayList<Debris>();

int planetNum = planets.size();  //A variable that wadaaaaaaaaaaaaaa    keeps updating to store the size of the ArrayList of Planets 
int debrisNum = 0;

float cover = 0;

float[] pos = {0, 0};
Midpoint m = new Midpoint(pos, 0.025/4 , 5, 100, 1500, true, 255);

void setup() {     //Function that runs once after start is pressed    
  //size(1280, 720, P2D);
  fullScreen(P2D);
  background(0);
  frameRate(60);

  intitializePlanets();

  rectMode(CENTER);
  noStroke();
  translate(width/2, height/2); 
  //showAll();
  //player.angle = HALF_PI;
}

void draw() {   //Method that keeps looping forever after void setup() is run

  background(0);
  if (start) {
    float scale = 1;

    noStroke();
    translate(width/2, height/2);  //Ignore this, it is to do with arranging the graph (canvas) so that origin
                                   //is in the centre, not in the corner
    pushMatrix();
    translate(-player.position.x * scale, -player.position.y * scale);
    scale(scale);
    

    //fill(0, 255, 0);
    //ellipse(0, 0, 10, 10);

    updateAll();
     
    player.run();
    //player.update();
    //player.show();

    if (planetNum < 50) {
      addPlanet();
    }
    planetNum = planets.size();

    //fill(255, 0, 0);
    //ellipse(0, 0, 4, 4);
    checkDeath();
    checkDist();
    popMatrix();
    
    fill(255, 255, 255);
    stroke(255, 255, 255);
    textAlign(LEFT, TOP);
    textSize(32);
    int c = 10;
    text("Score : " + score, -width/2 + c, -height/2 + c);

    fill(0, 0, 0, cover);
    noStroke();
    rect(0, 0, width, height);

    if (!player.isAlive) {
      cover += 2;
    }
    if (cover >= 256) {
      //planets = new ArrayList<Planet>();
      //debris  = new ArrayList<Debris>();
      start = false;
      planets.clear();
      debris.clear();
      //float f = 0; //<>//
    }
    
  } else {
    if (player.isAlive) {
      colorMode(RGB);
      textFont(createFont("Hyperspace Bold Italic.otf", 80, true));
      //createFont("Hyperspace Bold Italic.otf", 80, true);
      pushMatrix();
      translate(width/2, height/2);
      m.update();
      m.show();
      popMatrix();
      if(mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 + 205 - 50 && mouseY < height/2 + 205 + 50) {
        fill(0);
        stroke(255);
      } else {
        fill(255);
        //noFill();
        stroke(255);
      }
      rectMode(CENTER);
      rect(width/2, height/2 + 205, 300, 100, 10);
      
      if(mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 + 205 - 50 && mouseY < height/2 + 205 + 50) {
        fill(255);
      } else {
        fill(0);
      }
      
      textAlign(CENTER, CENTER);
      textSize(80);
      text("START", width/2, height/2 + 200);
      
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(200);
      text("ASTEROIDS", width/2, height/2 - 150);
      textSize(50);
      text("with gravity", width/2, height/2);
      
      //rectMode(CENTER);
      //textMode(CORNER);
      
    } else {
      
      /*fill(0, 0, 0, cover);
      noStroke();
      rect(width/2, height/2, width, height);
      
      cover += 1;*/
      pushMatrix();
      translate(width/2, height/2);
      m.update();
      m.show();
      popMatrix();
      if (cover >= 256) {
        fill(255, 255, 255, cover - 256);
        stroke(255, 255, 255);
        textAlign(CENTER, CENTER);
        textSize(128);
        text("Final Score : " + score, width/2, height/2);
      }
      //println("End");
      //println(player.isAlive);
      cover += 2;
      println(cover);
    }
  }
}

void keyPressed() {
  if (start) {
    if (key == 'w' || key == 'W') {
      player.thrust = true;
      player.thrusters.isOn = true;
    }

    if (key == 'a' || key == 'A') {
      player.turn[1] = true;
    }
    if (key == 'd' || key == 'D') {
      player.turn[0] = true;
    }

    if (key == ' ') {
      player.fire();
    }
  }
}

void keyReleased() {
  if (start) {
    if (key == 'w' || key == 'W') {
      player.thrust = false;
      player.thrusters.isOn = false;
    }

    if (key == 'a' || key == 'A') {
      player.turn[1] = false;
    }
    if (key == 'd' || key == 'D') {
      player.turn[0] = false;
    }
  }
}

void mousePressed() {
  if(player.isAlive) {
    if(mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 + 205 - 50 && mouseY < height/2 + 205 + 50) {
      start = true;
    }
  }
}






void intitializePlanets() {                    //Initializes all planets so we do not get confused. Don't delete lines but
  //comment them out. you can add more. Refer to the Planet class for constructor
  //arguments.

  int num = (int)random(100, 150);//(int)random(100, 150);
  //num = 10;
  num = 200;

  for (int i = 0; i < num; i++) {
    planets.add(new Planet(random(-sizeConst * width, sizeConst * width), random(-sizeConst * width, sizeConst * width), random(-2, 2), random(-2, 2), random(25, 60), random(0.1, 5)));

    if (dist(planets.get(i).position.x, planets.get(i).position.y, player.position.x, player.position.y) > sizeConst * width) {
      planets.remove(i);
      i--;
    } else if (dist(planets.get(i).position.x, planets.get(i).position.y, 0, 0) < planets.get(i).radius + 50) {
      planets.remove(i);
      i--;
    }
  }

  /*planets.add(new Planet(0, 0, 0, 0.07, 100, 19));
   planets.add(new Planet(300, 0, 0, -7, 20, 15));
   planets.add(new Planet(330, 0, 0, 5.5, 10, 10));
   planets.add(new Planet(-450, 0, 0, 1, 30, 0.1));
   
   planets.add(new Planet(185, 0, 0, 12, 10, 1));
   planets.add(new Planet(-340, 0, 0, -6, 10, 1));
   planets.add(new Planet(500, 0, 0, -5, 25, 1));
   
   planets.add(new Planet(185, 100, 0, 12, 10, 1));
   planets.add(new Planet(-340, -200, 0, -6, 10, 1));
   planets.add(new Planet(500, 300, 0, -5, 25, 1));
   
   planets.add(new Planet(250, 100, 0, 12, 10, 1));
   planets.add(new Planet(340, -200, 0, -6, 10, 1));
   planets.add(new Planet(-500, 300, 0, -5, 25, 1));*/

  //planets.add(new Planet(200, 0, -10, 0.4, 5, 1));
  //planets.add(new Planet(-200, 0, 0, 0, 50, 1));

  //planets.add(new Planet(0, -200, 0, 0, 50, 1));

  //planets.add(new Planet(0, 0, 0, 0, 25, 1));

  planetNum = planets.size();
}

void updateAll() {                            //loops through planets twice to get every planet's force on every other planet
  planetNum = planets.size();

  for (int i = 0; i < planetNum; i++) {
    for (int j = 0; j < planetNum; j++) {

      if (i != j) {
        try {

          planets.get(i).forceCalc(planets.get(j));
        } 
        catch(Exception e) {
        }

        planetNum = planets.size();
      }
    }
  }
  planetNum = planets.size();
  for (Planet i : planets) {
    i.update();
    planetNum = planets.size();
  }

  for (int i = 0; i < planets.size(); i++) {
    for (int j = 0; j < planets.size(); j++) {
      if (i != j) {
        //if (planets.get(i).mass >= planets.get(j).mass) {//Don't question the if statment. I can't explain in words
        try {
          planets.get(i).combine(planets.get(j));
        } catch(Exception e) {
          
        }
        //}
      }
    }
  }

  updateDebris();
}

void updateDebris() {
  for (int i = 0; i < debrisNum; i++) {
    for (int j = 0; j < planetNum; j++) {
      debris.get(i).forceCalc(planets.get(j));
    }
  }

  for (Debris d : debris) {
    d.update();
  }

  /*for(int i = debrisNum - 1; i <= 0; i--) {
   try {
   Debris D = debris.get(i);
   float  d = dist(player.position.x, player.position.y, D.position.x, D.position.y);
   if(d > sizeConst * width) {
   debris.remove(i);
   }
   debrisNum = debris.size();
   } catch(Exception e) {
   println(i);
   }
   }*/

  for (int i = 0; i < planets.size(); i++) {
    for (int j = 0; j < debris.size(); j++) {
      //if(debris.get(i).life > debris.get(i).rad * 5) {
      planets.get(i).combine(debris.get(j));
      //}
    }
  }
}

void showAll() {                 //For 1st frame. Update() function has show() built-in for the rest of the frames.
  for (Planet p : planets) {
    p.show();
  }

  for (Debris d : debris) {
    d.show();
  }
}

void addPlanet() {
  float r = random(25, 60);
  float w = width + r;
  float h = height + r;

  Planet planet = new Planet(player.position.x + random(-sizeConst * w, sizeConst * w), player.position.y + random(-sizeConst * w, sizeConst * w), random(-2, 2), random(-2, 2), r, random(0.1, 5));
  //if(dist(planet.position.x, planet.position.y, player.position.x, player.position.y) > sizeConst * width) {
  //  planets.remove(i);
  //}


  //if(!(planet.position.x > -w/2.0 && planet.position.x < w/2.0 && planet.position.y > -h/2.0 && planet.position.y < h/2.0)) {
  if (dist(planet.position.x, planet.position.y, player.position.x, player.position.y) > (width + planet.radius + 100)/2.0) {
    planets.add(planet);
    planetNum = planets.size();
  }
}

void takeOut(Planet p) {      //To take out one planet once it collides with another 
  planets.remove(p);
  planetNum = planets.size(); //To update planetNum
}

void takeOut(Debris d) {
  debris.remove(d);
  debrisNum = debris.size();
}

void hit(Bullet b, Planet p) {
  score += 20;
  player.gun.takeOut(b);
  takeOut(p);

  int r1 = (int)random(1, 4);
  int r2 = (int)random(1, 4);

  float dMass = (random(10, 25)/100.0) * p.mass;
  //float dMass = 0;
  float mass  = p.mass - dMass;

  float m1 = (mass * r1)/(r1 + r2);
  float m2 = (mass * r2)/(r1 + r2);

  float v1 = m1/p.density;
  float v2 = m2/p.density;

  float rad1 = (float)Math.pow((3 * v1)/(4 * PI), 1.0/3.0);
  float rad2 = (float)Math.pow((3 * v2)/(4 * PI), 1.0/3.0);

  float density = p.density;

  PVector dir = new PVector(b.velocity.x, b.velocity.y);
  //dir.sub(b.position);
  float slope = p.getPerpendicular(dir);

  boolean slopeIsInfinity = (dir.y == 0);

  PVector position1;
  PVector position2;

  PVector velocity1;
  PVector velocity2;

  if (slopeIsInfinity) {
    position1 = new PVector(p.position.x, p.position.y - rad1/2.0 - 1);
    position2 = new PVector(p.position.x, p.position.y + rad2/2.0 + 1);

    float c = (mass + dMass) * 2;

    velocity1 = new PVector(0, -1 * c);
    velocity1.add(p.velocity);
    velocity1.div(m1);
    velocity2 = new PVector(0, 1 * c);
    velocity2.add(p.velocity);
    velocity2.div(m2);
  } else {
    float a = atan(slope);

    position1 = new PVector(p.position.x - cos(a) * (rad1/2.0 + 1), p.position.y - sin(a) * (rad1/2.0 - 1));
    position2 = new PVector(p.position.x + cos(a) * (rad2/2.0 - 1), p.position.y + sin(a) * (rad2/2.0 + 1));

    float c = (mass + dMass) * 2;

    velocity1 = new PVector(-1 * cos(a) * c, -1 * sin(a) * c);
    velocity1.add(p.velocity);
    //println(velocity1);
    velocity1.div(m1);
    //println(velocity1);
    //println(v1);
    velocity2 = new PVector(1 * cos(a) * c, 1 * sin(a) * c);
    velocity2.add(p.velocity);
    velocity2.div(m2);
  }

  Planet p1 = new Planet(position1.x, position1.y, velocity1.x, velocity1.y, rad1, density);
  Planet p2 = new Planet(position2.x, position2.y, velocity2.x, velocity2.y, rad2, density);

  planets.add(p1);
  planets.add(p2);

  if (p1.radius < 25) {
    makeDebris(p1);
    addPlanet();
    
    score += 10;
  }
  if (p2.radius < 25) {
    makeDebris(p2);
    addPlanet();
    
    score += 10;
  }

  planetNum = planets.size();
  debrisNum = debris.size();

  //p1.createDebris((new PVector(p2.position.x, p2.position.y)).sub(p1.position), new PVector(p1.position.x, p1.position.y), rad1, p2, ((new PVector(p2.velocity.x, p2.velocity.y)).sub(p1.position).mag()));
  //p2.createDebris((new PVector(p1.position.x, p1.position.y)).sub(p2.position), new PVector(p2.position.x, p2.position.y), rad2, p1, ((new PVector(p1.velocity.x, p1.velocity.y)).sub(p2.position).mag()));
  createDebris(dMass, p.position, density, p);
}

void makeDebris(Planet p) {
  planets.remove(p);
  debris.add(new Debris(p.position.x, p.position.y, p.velocity.x, p.velocity.y, p.radius, p.density, p));
  if (random(0, 1) < 0.5) {
    addPlanet();
  }
}

void createDebris(float mass, PVector point, float density, Planet p) {
  int num = (int)random(100, 200);

  float[] masses = new float[num];

  int[] ratios   = new int[num];
  int sumTerms = 0;

  for (int i = 0; i < ratios.length; i++) {
    ratios[i] = (int)random(1, 10);
    sumTerms += ratios[i];
  }

  for (int i = 0; i < masses.length; i++) {
    masses[i] = ((float)ratios[i] * mass)/((float)sumTerms);
  }

  for (int i = 0; i < num; i++) {
    float v = masses[i]/density;
    float r = (float)Math.pow((3 * v)/(4 * PI), 1.0/3.0);

    float a = random(0, TWO_PI);
    float k = random(-10, 10);
    //parts.add(new SParticle(position.x, position.y, sin(a) * k, cos(a) * k, random(3, 7), 0));
    //debris.add(new Debris(point.x, point.y, random(-10, 10), random(-10, 10), r, density, p));

    debris.add(new Debris(point.x, point.y, sin(a) * k, cos(a) * k, r, density, p));
  }

  debrisNum = debris.size();
}

void checkDeath() {
  float x = player.position.x;
  float y = player.position.y;

  float sin = sin(player.angle);
  float cos = cos(player.angle);

  float size = player.size;

  float[][] points ={{x + (0     * cos) - ((-20) * sin), y + (0     * sin) + ((-20) * cos)}, //x =   0, y = -20
    {x + ((-15) * cos) - (20    * sin), y + ((-15) * sin) + ((20)  * cos)}, //x = -15, y =  20
    {x + ((15)  * cos) - (20    * sin), y + (15    * sin) + ((20)  * cos)}, //x =  15, y =  20
    {0, 0}, 
    {0, 0}, 
    {0, 0}};

  for (int i = 0; i < 3; i++) {
    if (i != 2) {
      points[i + 3][0] = (points[i][0] + points[i + 1][0])/2.0;
      points[i + 3][1] = (points[i][1] + points[i + 1][1])/2.0;
    } else {
      points[i + 3][0] = (points[i][0] + points[0][0])/2.0;
      points[i + 3][1] = (points[i][1] + points[0][1])/2.0;
    }
  }



  /*stroke(255);
   noFill();
   beginShape();
   vertex(points[0][0], points[0][1]);
   vertex(points[3][0], points[3][1]);
   vertex(points[1][0], points[1][1]);
   vertex(points[4][0], points[4][1]);
   vertex(points[2][0], points[2][1]);
   vertex(points[5][0], points[5][1]);
   endShape(CLOSE);*/

  /*point(points[0][0], points[0][1]);
   point(points[3][0], points[3][1]);
   point(points[1][0], points[1][1]);
   point(points[4][0], points[4][1]);
   point(points[2][0], points[2][1]);
   point(points[5][0], points[5][1]);*/

  boolean dead = checkIntersection(points);

  if (dead) {
    //noLoop();

    player.dead();
    //start = false;
  }
}

boolean checkIntersection(float[][] points) {

  for (Planet p : planets) {
    for (int i = 0; i < points.length; i++) {
      if (dist(p.position.x, p.position.y, points[i][0], points[i][1]) < p.radius/2.0) {
        return(true);
      }
    }
  }
  return(false);
}
void checkDist() {
  for (int i = 0; i < planetNum; i++) {
    float d = dist(player.position.x, player.position.y, planets.get(i).position.x, planets.get(i).position.y); 
    if (d > sizeConst * width) {
      Planet p = planets.get(i);
      takeOut(planets.get(i));

      float x = 2 * player.position.x - p.position.x;
      float y = 2 * player.position.y - p.position.y;

      //createPlanet(x, y, p.velocity.x, p.velocity.y);
      addPlanet();
    }
  }

  for (int i = 0; i < debrisNum; i++) {
    float d = dist(player.position.x, player.position.y, debris.get(i).position.x, debris.get(i).position.y); 
    if (d > sizeConst * width) {
      takeOut(debris.get(i));
    }
  }

  planetNum = planets.size();
  debrisNum = debris.size();
}

void createPlanet(float x, float y, float vx, float vy) {
  planets.add(new Planet(x, y, vx, vy, random(25, 60), random(0.1, 5)));
  planetNum = planets.size();
}
