// Class pour gérer les lignes mouvantes

class MovingLine {
  
  PVector a, b, t, initialT;
  float r = 0;
  float initialR = 0;
  float speed = 0.1;  // ==> Jouer sur la vitesse
  
  int animation = 0;
  boolean ready = true;
  
  int weight = int(random(SIZE/8,SIZE/5));
  
  MovingLine(PVector a, PVector b) {
    t = a;
    initialT = new PVector();
    this.a = new PVector(0,0);
    this.b = b;
  }
  
  void show() {
    stroke(color(myColor.R, myColor.G, myColor.B, 100));
    strokeWeight(weight);
    
    switch (animation) {
      
      // Rotations dans le sens horaire
      case 1 :
      case 3 :
        if (r < initialR + HALF_PI) r += speed / 0.65;
        else endAnimation(true);
        break;
        
      // Rotations dans le sens anti-horaire
      case 2 :
      case 4 :
        if (r > initialR - HALF_PI) r -= speed / 0.65;
        else endAnimation(true);
        break;
        
      // Translations
      case 5 :
        if ( (b.x + b.y) * (t.x + t.y) < (b.x + b.y) * ( (initialT.x + initialT.y) + (b.x + b.y) ) ) {
          t.set(t.x + b.x * speed, t.y + b.y * speed);
        }
        else endAnimation(false);
        break;
      case 6 :
        if ( (b.x + b.y) * (t.x + t.y) > (b.x + b.y) * ( (initialT.x + initialT.y) - (b.x + b.y) ) ) {
          t.set(t.x - b.x * speed, t.y - b.y * speed);
        }
        else endAnimation(false);
        break;
        
      // Pour tout autre nombre : aucun mouvement et près à recevoir une nouvelle animation
      default :
        animation = 0;
        ready = true;
    }
    pushMatrix();
    translate(t.x * SIZE, t.y * SIZE);
    rotate(r);
    line(a.x * SIZE , a.y * SIZE, b.x * SIZE, b.y * SIZE);
    popMatrix();
  }
  
  
  // Prépare et lance l'animation passée en paramètre
  void setAnimation(int n) {
    if (ready) {
      ready = false;
      animation = n;
      if (n == 3 || n == 4) { // Permutation sur la translation pour faire la rotation sur l'autre point
        t.add(b);
        a.set(-b.x, -b.y);
        b.set(0,0);  // b devient le point de pivot
      } else if (n == 5 || n == 6) {
        initialT.set(t.x, t.y);
      }
    }
  }
  
  // Restaure les paramètres comme il faut et en fonction de si c'est une rotation ou une translation
  void endAnimation(boolean rotation) {
    initialR = 0;
    initialT.set(t.x, t.y);
    r = 0;
    if (rotation) replace();
    animation = 0;
    ready = true;
  }
  
  // Permet de replacer les points correctement en fonction de la rotation qui a eu lieu
  void replace() {
    if (animation == 1 || animation == 3) {  // Rotation horaire
      if (a.x == 0 && a.y == 0) {  // Le point de pivot est a
        b.set(-b.y,b.x);
      } else {  // Le point de pivot est b
        t.set(t.x - a.y, t.y + a.x);
        b.set(a.y, -a.x);
        a.set(0,0);
      }
    } else {  // Rotation anti-horaire
      if (a.x == 0 && a.y == 0) {
        b.set(b.y,-b.x);
      } else {
        t.set(t.x + a.y, t.y - a.x);
        b.set(-a.y, a.x);
        a.set(0,0);
      }
    }
  }
}
