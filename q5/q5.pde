// centro da circunferência maior
float x = 400;
float y = 400;

//referência que é atualizada a cada iteração
//para mostrar uma nova posição dos elementos em movimento
float position = 0.1;

// recebe o raio do círculo menor e a velocidade
// a qual a posição é atualizada (negativo para ir no sentido anti-horário)
void animation(float radius, float step) {
  // x1 e y1 atualizados com base nas seguintes fórmulas
  float x1 = x + cos(position) * radius;
  float y1 = y + sin(position) * radius;

  // cria a ellipse menor
  ellipse(x1, y1, 50, 50);

  stroke(0, 0, 255);

  // cria o ponto
  strokeCap(ROUND);
  stroke(255, 0, 0);

  // atualiza x1 e y1, invertido sin e cos pois a bolinha
  // vermelha vai no sentido contrário ao movimento da ellipse
  x1 = x1 + sin(position*4) * 75/2;
  y1 = y1 + cos(position*4) * 75/2;
  fill(255, 0, 0);

  // cria um círculo de raio 5
  circle(x1, y1, 5);

  position+=step;
}

void setup () {
  size(800, 600);
  // valor necessário para que cada volta
  // completa no círculo maior dure 4 segundos
  frameRate(15);
}

void draw () {
  background(200);
  fill(200);
  stroke(0, 0, 255);
  // cria ellipse maior no ponto x, y
  ellipse(x, y, 250, 250);
  // método onde ocorre animação
  animation(100, -0.1);
}
