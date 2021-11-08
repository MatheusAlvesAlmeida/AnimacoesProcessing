float ponto1X;
float ponto1Y;
float ponto2X;
float ponto2Y;
float alfa = 0;
/*
O movimento do braço deve ser alfa enquanto o do antebraço deve ser 2alfa.
 Sabendo que o movimento de alfa deve ser 30 graus, que dá aproximadamente 0.523599 rads
 Temos que: O braço deve rotacionar 0.523599 em 2 segundos, que resulta em 0.2617995 por segundo e o fps é de 60.
 Logo o valor da velocidade angular será 0.004363325 por frame.
 */
float velocidadeAngular = -0.004363325;

//raio das bolinhas que foram colocadas para ilustrar o ombro, cotovelo e mao
float r = 10;
float segundoAtual = second();

void setup() {
  size(800, 600);
  ponto1X = width/2;
  ponto1Y = height/2;
  ponto2X = ponto1X;
  ponto2Y = ponto1Y + 100;
  frameRate(60);
}

//O movimento 2 depende do movimento 1, se não os resultados são diferentes. Rotações não são comutativas

void draw() {
  background(255, 170, 0);
  /*
    Quando alfa chega ao valor de 30 graus, ele zera a velocidade angular, ou seja, a partir daí o movimento irá parar.
   Caso contrário, ele continua com o movimento somando a velocidade angular ao valor de alfa.
   */
  if (alfa <= -0.523599) {
    velocidadeAngular = 0;
  }
  alfa += velocidadeAngular;
  stroke(0);
  circle(ponto1X, ponto1Y, r);
  /*
    O ponto 1 está no centro da tela, mas o ponto de origem não, por isso é necessário transladar
   o ponto de origem pra o ponto onde se encontra o ponto 1, o centro da tela. Esse primeiro translade garante que ele faça a translação em torno dele msm.
   */
  translate(ponto1X, ponto1Y);
  rotate(alfa);
  line(0, 0, 0, 100);
  circle(0, 100, r);
  /*
    Translada a origem do sistema para o ponto inicial pra poder transladar novamente para o ponto 2.
    Isso é feito pra facilitar o cálculo, se botasse direto pra transladar pra o ponto 2 teríamos um problema. 
   */
  translate(-ponto1X, -ponto1Y);
  translate(ponto2X, ponto2Y);
  rotate(2 * alfa);
  line(0, 0, 0, 150);
  circle(0, 150, r);
}
