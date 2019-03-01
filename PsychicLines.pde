/* Animation réalisé par Benbb96 */

final int NB = 500;  // Nombre de Moving Lines
MovingLine[] lines = new MovingLine[NB];

MyColor myColor = new MyColor();

float rotation = 0;
final int FREQUENCY = 30;  // ==> Jouer sur la fréquence des animations
final int SIZE = 50;  // ==> Jouer sur la taille

void setup() {
  //size(1280, 720);  // HD
  fullScreen();
  
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
  
  if (frameCount > 1996) rotate(rotation += 0.003);
  else if (frameCount > 1789) rotate(rotation += 0.0016);
  else if (frameCount > 1444) rotate(rotation += 0.0004);
  
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
}

// Fonctions au clic sur la souris
void mousePressed()
{
   myColor.init();  // Réinitialise les couleurs
} //<>//
