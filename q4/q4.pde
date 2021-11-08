//rotação de 180° em 4s
float w = PI/240;

float alpha = 0;

//coordenadas iniciais
float pontoInicialX = -20;
float pontoInicialY = 0;

//coordenadas do centro que são atualizadas quando passa no 0x
float centroX = 0;
float centroy = 0;
int i = 1;

void initialSetup() {
  translate(400, 400);
  strokeWeight(1);
  stroke(0);
  
  // cria o eixo x
  stroke(0, 0, 255);
  line(-400, 0, 400, 0);
  
  // cria o eixo y
  stroke(0, 255, 0);
  line(0, 400, 0, -400);
  
  scale(1, -1);
}

void setup() {
  size(800, 800);
  frameRate(60);
}

// cria o ponto
void ponto() {
  strokeWeight(10);
  stroke(200, 0, 0);
}

void draw() {
  initialSetup();
  // se alpha for maior que 180°, o centro vira o  ponto inicial x
  // e o ponto inicial x é alterado
  if (alpha >= PI) {
    alpha = 0;
    centroX = pontoInicialX;
    pontoInicialX += -20*pow(-2, i);
    i++;
  }

  // realiza a translação do centro para o lado,
  // aumentando o raio do semicirculo
  translate(centroX, centroy);
  // rotaciona o ponto
  rotate(alpha);
  translate(-centroX, -centroy);
  ponto();
  point(pontoInicialX, pontoInicialY);
  // ao incrementar permite a rotação
  alpha += w;
}
