final int NB = 1000;  // Nombre de Moving Lines
MovingLine[] lines = new MovingLine[NB];

void setup() {
  size(900, 800);
  for (int i = 0; i < NB; i++) {
    lines[i] = new MovingLine(new PVector(width / MovingLine.SIZE /2, height / MovingLine.SIZE /2), new PVector(1, 0));
  }
}

    initialT = new PVector();
    this.a = new PVector(0,0);
    this.b = b;
    r = initial;
  }
  
  void show() {
    stroke(0);
    strokeWeight(8);
    pushMatrix();
    
    switch (animation) {
      case 1 :
        if (r < initial + HALF_PI) r += speed / 1.3;
        else {
          initial = 0;
          r = 0;
          replace(true);
          animation = 0;
          ready = true;
        }
        break;
      case 2 :
        if (r > initial - HALF_PI) r -= speed / 1.3;
        else {
          initial = 0;
          r = 0;
          replace(false);
          animation = 0;
          ready = true;
        }
        break;
      case 3 :
        if (r < initial + HALF_PI) r += speed / 1.3;
        else {
          initial = 0;
          r = 0;
          if (a.x == -1) {
            t.set(t.x, t.y + a.x);
            b.set(0,1);
          } else if (a.x == 1) {
            t.set(t.x, t.y + a.x);
            b.set(0,-1);
          } else {
            if (a.y == 1) {
              t.set(t.x - a.y, t.y);
              b.set(1,0);
            } else {
              t.set(t.x - a.y, t.y);
              b.set(-1,0);
            }
          }
          a.set(0,0);
          animation = 0;
          ready = true;
        }
        break;
      case 4 :
        if (r > initial - HALF_PI) r -= speed / 1.3;
        else {
          initial = 0;
          r = 0;
          if (a.x == 1) {
            t.set(t.x, t.y - a.x);
            b.set(0,1);
          } else if (a.x == -1) {
            t.set(t.x, t.y - a.x);
            b.set(0,-1);
          } else {
            if (a.y == 1) {
              t.set(t.x + a.y, t.y);
              b.set(-1,0);
            } else {
              t.set(t.x + a.y, t.y);
              b.set(1,0);
            }
          }
          a.set(0,0);
          animation = 0;
          ready = true;
        }
        break;
      case 5 :
        if (b.x == 1) {
          if (t.x < initialT.x + 1) t.x += speed / 2;
          else {
            initialT.set(t.x, t.y);
            animation = 0;
            ready = true;
          }
        } else if (b.x == -1) {
          if (t.x > initialT.x - 1) t.x -= speed / 2;
          else {
            initialT.set(t.x, t.y);
            animation = 0;
            ready = true;
          }
        } else {
          if (b.y == 1) {
            if (t.y < initialT.y + 1) t.y += speed / 2;
            else {
              initialT.set(t.x, t.y);
              animation = 0;
              ready = true;
            }
          } else {
            if (t.y > initialT.y - 1) t.y -= speed / 2;
            else {
              initialT.set(t.x, t.y);
              animation = 0;
              ready = true;
            }
          }
        }
        break;
      case 6 :
        if (b.x == 1) {
          if (t.x > initialT.x - 1) t.x -= speed / 2;
          else {
            initialT.set(t.x, t.y);
            animation = 0;
            ready = true;
          }
        } else if (b.x == -1) {
          if (t.x < initialT.x + 1) t.x += speed / 2;
          else {
            initialT.set(t.x, t.y);
            animation = 0;
            ready = true;
          }
        } else {
          if (b.y == 1) {
            if (t.y > initialT.y - 1) t.y -= speed / 2;
            else {
              initialT.set(t.x, t.y);
              animation = 0;
              ready = true;
            }
          } else {
            if (t.y < initialT.y + 1) t.y += speed / 2;
            else {
              initialT.set(t.x, t.y);
              animation = 0;
              ready = true;
            }
          }
        }
        break;
      default :
        animation = 0;
        ready = true;
    }
    
    translate(t.x * SIZE, t.y * SIZE);
    rotate(r);
    line(a.x * SIZE , a.y * SIZE, b.x * SIZE, b.y * SIZE);
    
    popMatrix();
  }
  
  void replace(boolean horaire) {
    if (horaire) {
      if (b.x == 1) b.set(0,1);
      else if (b.x == -1) b.set(0,-1);
      else {
        if (b.y == 1) b.set(-1,0);
        else b.set(1,0);
      }
    } else {
      if (b.x == 1) b.set(0,-1);
      else if (b.x == -1) b.set(0,1);
      else {
        if (b.y == 1) b.set(1,0);
        else b.set(-1,0);
      } //<>//
    }
  }
  
  void setAnimation(int n) {
    if (ready) {
      ready = false;
      animation = n;
      if (n == 3 || n == 4) { // Inversion des deux points
        t.add(b);
        a.set(b.x * -1, b.y *-1);
        b.set(0,0);
      } else if (n == 5 || n == 6) {
        initialT.set(t.x, t.y);
      }
    }
  }
}