/* Animation réalisé par Benbb96 */

final int NB = 1000;  // Nombre de Moving Lines
MovingLine[] lines = new MovingLine[NB];

MyColor myColor = new MyColor();

float rotation = 0;

void setup() {
  size(1280, 720);  // HD
  
  // Initialisation de toutes les Moving Lines
  for (int i = 0; i < NB; i++) {
    //lines[i] = new MovingLine(new PVector((width/MovingLine.SIZE) /2, (height/MovingLine.SIZE) /2 +0.5), new PVector(1, 0));
    lines[i] = new MovingLine(new PVector(-0.5,0), new PVector(1, 0));
  }
  
}

void draw() {
  myColor.update();
  background(color(255 - myColor.R, 255 - myColor.G, 255 - myColor.B));
  
  translate(width/2, height/2);  // Fixe le plan au milieu
  
  if (frameCount > 1996) rotate(rotation += 0.003);
  else if (frameCount > 1789) rotate(rotation += 0.0016);
  else if (frameCount > 1444) rotate(rotation += 0.0004);
  
  // Affichage des Moving Lines
  for (int i = 0; i < NB; i++) {
    lines[i].show();
  }
  
  // Lancer une animation aléatoire à intervalle régulier.
  if (frameCount % 100 == 0) {
    for (int i = 0; i < NB; i++) {
      lines[i].setAnimation(int(random(0,10)));
    }
  }
}

void mousePressed()
{
   myColor.init();  // Réinitialise les couleurs
}

class MovingLine {
  
  PVector a, b, t, initialT;
  float r = 0;
  float initialR = 0;
  float speed = 0.004;  // ==> Jouer sur la vitesse
  
  int animation = 0;
  boolean ready = true;
  
  static final int SIZE = 100;  // ==> Jouer sur la taille
  int weight = int(random(4,10));
  
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
  } //<>//
}

class MyColor
{
  float R, G, B, Rspeed, Gspeed, Bspeed;
  final static float minSpeed = .7;
  final static float maxSpeed = 1.5;
  MyColor()
  {
    init();
  }
  
  public void init()
  {
    R = random(255);
    G = random(255);
    B = random(255);
    Rspeed = (random(1) > .5 ? 1 : -1) * random(minSpeed, maxSpeed);
    Gspeed = (random(1) > .5 ? 1 : -1) * random(minSpeed, maxSpeed);
    Bspeed = (random(1) > .5 ? 1 : -1) * random(minSpeed, maxSpeed);
  }
  
  public void update()
  {
    Rspeed = ((R += Rspeed) > 255 || (R < 0)) ? -Rspeed : Rspeed;
    Gspeed = ((G += Gspeed) > 255 || (G < 0)) ? -Gspeed : Gspeed;
    Bspeed = ((B += Bspeed) > 255 || (B < 0)) ? -Bspeed : Bspeed;
  }
}