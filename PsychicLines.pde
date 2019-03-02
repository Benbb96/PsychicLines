/* Animation réalisé par Benbb96 */

final int NB = 300;  // Nombre de Moving Lines
MovingLine[] lines = new MovingLine[NB];

MyColor myColor = new MyColor();

float speed = 0.01;  // ==> Jouer sur la vitesse
float rotation = 0;
float rotationSpeed = 0;
float rotationStop = 0;
boolean rotateRight = true;
final int FREQUENCY = 100;  // ==> Jouer sur la fréquence des animations
final int SIZE = 50;  // ==> Jouer sur la taille

void setup() {
  size(1280, 720);  // HD
  //fullScreen();
  
  // Initialisation de toutes les Moving Lines
  for (int i = 0; i < NB; i++) {
    //lines[i] = new MovingLine(new PVector((width/MovingLine.SIZE) /2, (height/MovingLine.SIZE) /2 +0.5), new PVector(1, 0));
    lines[i] = new MovingLine(new PVector(-0.5,0), new PVector(1, 0));
  }
  
}

void draw() {
  myColor.update();
  background(color(255 - myColor.R, 255 - myColor.G, 255 - myColor.B));  // Le background est l'inverse de la couleur des batonnets
  
  translate(width/2, height/2);  // Fixe le plan au milieu
  
  if (rotateRight) {
    rotate(rotation += rotationSpeed);
  } else {
    rotate(rotation -= rotationSpeed);
  }
  
  // Lancer la rotation progressivement au fil du temps
  //if (frameCount > 1996) rotate(rotation += 0.003);
  //else if (frameCount > 1789) rotate(rotation += 0.0016);
  //else if (frameCount > 1444) rotate(rotation += 0.0004);
  
  // Affichage des Moving Lines
  for (int i = 0; i < NB; i++) {
    lines[i].show();
  }
  
  // Lancer une animation aléatoire à intervalle régulier.
  if (frameCount % FREQUENCY == 0) {
    for (int i = 0; i < NB; i++) {
      lines[i].setAnimation(int(random(0,10)));
    }
  }
  
  // Sauvegarde des frames
  //saveFrame("output/#####.jpg");
}

// Fonctions à l'appui sur des touches du clavier
void keyPressed() {
  switch(key) {
    //case CODED:
    //println(keyCode);
    //  switch (keyCode) {
    //    case ENTER: myColor.init(); break;
    //  } break;
    case ENTER : myColor.init(); break;
    case ' ':
      if (rotationStop == 0) {
        rotationStop = rotationSpeed;
        rotationSpeed = 0;
      } else {
        rotationSpeed = rotationStop;
        rotationStop = 0;
      } break;
    case 'r': rotateRight = rotateRight ? false : true; break;
    case '+': rotationSpeed += 0.004; break;
    case '-': rotationSpeed -= 0.004; break;
    case '1': speed = 0.004; break;
    case '2': speed = 0.006; break;
    case '3': speed = 0.008; break;
    case '4': speed = 0.01; break;
    case '5': speed = 0.03; break;
    case '6': speed = 0.04; break;
    case '7': speed = 0.05; break;
    case '8': speed = 0.07; break;
    case '9': speed = 0.1; break;
  }
}

// Fonctions au clic sur la souris
void mousePressed()
{
   if (mouseButton == LEFT) {
     myColor.init();  // Réinitialise les couleurs
  } else if (mouseButton == RIGHT) {
    rotateRight = rotateRight ? false : true;  // Inverse la rotation
  }
}

// Scroll de la souris
void mouseWheel(MouseEvent event) {
  rotationSpeed += event.getCount() * 0.002;  // Augmente ou diminue la vitesse de rotation
} //<>//
