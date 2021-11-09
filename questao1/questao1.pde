float x, y;
float vX, vY;

void setup(){
  size(800, 800);
  x = 15;
  y = 300;
  vX = 5;
  vY = 10;
}

void draw(){
  background(255, 255, 255);
  fill(255, 0, 0);
  rect(0, 315, width, height);
  fill(0, 0, 255);
  circle(x, y, 30);
  
  /*
    A variável X representa a posição e está sendo atualizada de acordo com 
    a variável vX, velocidade de X que tem como unidade UC/frame. Por exemplo, 
    se X for 10 e a velocidade de X for 5, a cada frame X = X + 5. 
    Já a variável Y tem o diferencial da gravidade (que atua só na vertical no lançamento obliquo)
    que é de 0.5 UC/frame^2. 
  */
  x = x + vX;
  y = y + vY;
  vY = vY + 0.5f;
  
  /*
    O primeiro IF checa se passou do comprimento da tela.
    Caso tenha passado, ele irá inverter a velocidade do X.
    O segundo faz a mesma coisa, só que em relação à vertical,
    ele inverte a velocidade do Y.
    Como a colisão é elástica, uma simples inversão de sinal funciona
    aqui. 
  */
  if(x >= width-15){
    vX = -vX;
  }else if(x <= 0+15){
    vX = -vX;
  }
  if(y >= 300){
    vY = -vY + 0.5f;
    y = 300;
  }else if(y <= 0){
    vY = -vY;
  }
}
