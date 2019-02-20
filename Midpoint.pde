class Midpoint {

  float[] centre;

  boolean orientation = Math.random() > 0.5? true:false;

  float x;
  float y;

  float radius;

  float distance;

  Midpoint[] D;
  int rate;

  float angle;

  boolean first;

  int fill1;   //only here because I had it in earlier for rainbow colours and I would need to change a lot to fix it...
  //int fill2;
  //int fill3;

  float speed;


  Midpoint(float[] CR, float Speed, int Rate, float Radius, float Dist, boolean xz, int Fill) {

    centre   = CR;
    rate     = Rate;
    radius   = Radius;
    distance = Dist;
    fill1     = Fill;

    first = xz;

    speed = Speed;

    //switch(rate) {
    //case 7:
    //  fill1 = 255;
    //    fill2 = 0;
    //    fill3 = 0;

    //    break;

    //case 6:

    //  fill1 = 255;
    //    fill2 = 127;
    //    fill3 = 0;

    //    break;

    //case 5:

    //  fill1 = 255;
    //    fill2 = 255;
    //    fill3 = 0;

    //    break;

    //case 4:

    //  fill1 = 0;
    //    fill2 = 255;
    //    fill3 = 0;

    //    break;

    //case 3:
    //  fill1 = 0;
    //    fill2 = 0;
    //    fill3 = 255;

    //    break;

    //case 2:
    //  fill1 = 75;
    //    fill2 = 0;
    //    fill3 = 130;

    //    break;

    //case 1:
    //  fill1 = 0;
    //    fill2 = 0;
    //    fill3 = 211;

    //    break;

    //default:
    //  fill1 = 255;
    //  fill2 = 255;
    //  fill3 = 255;
    //}

    double chance = Math.random();
    if (!first) {

      if (chance < 0.25) {

        x = centre[0] + Dist;
        y = 0;
        angle = 0;
      } else if (chance < 0.5) {

        x = 0;
        y = centre[1] - Dist;
        angle = 90;
      } else if (chance < 0.75) {

        x = centre[0] - Dist;
        y = 0;
        angle = 180;
      } else {

        x = 0;
        y = centre[1] + Dist;
        angle = 270;
      }

      if (rate < 0) {
        rate = 0;
      }
    }

    D = new Midpoint[rate];

    for (int i = 0; i < D.length; i++) {
      float []abc = {x, y};
      Midpoint next = new Midpoint(abc, 
        (speed * (float)((Math.random() *2.3) + 1)), 
        (int)(rate - 1), //(int)(rate - (Math.random() * (rate - 7) + 3)), 
        (float)(radius * 0.4), 
        distance * 0.4, //(float)(distance * ((Math.random() * 0.2) + 0.25))); 
        false, 
        fill1 - 100); 

      D[i] = next;
    }
  }


  void show() {
    if(!first) {
      noStroke();
      //fill(fill1, fill2, fill3);
      fill(255, 255, 255, 100);

      ellipse(x, y, radius, radius);
    }

    for (Midpoint i : D) {
      i.show();
    }
  }

  void update() {
    for (Midpoint i : D) {
      i.update();
      float []xyz = {x, y};
      i.centre = xyz;
    }

    if (!first) {

      if (orientation) {

        x = (float)Math.cos(angle % 360);
        y = (float)Math.sin(angle % 360);
      } else {

        x = (float)Math.sin(angle % 360);
        y = (float)Math.cos(angle % 360);
      }

      x *= distance;
      y *= distance;

      x += centre[0];
      y += centre[1];

      angle += speed;
    }
  }
}
