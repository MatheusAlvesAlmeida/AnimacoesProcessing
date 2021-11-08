float a = 0;//variavel responsavel por armazenar a angulatura da rotacao por frame
float r = 100;//r eh reponsavel por conter a distancia entre o ponto a ser colocado e o centro 
//100->coord em x do ponto inicial 

float alpha;

void setup() {
  size(800, 600);
  frameRate(60);//taxa de frames
  translate (400, 300);//setando o centro
  line(0, height/2, 0, -height/2);//linha em y do plano cartesiano com centro em (400,300)
  line(width/2, 0, -width/2, 0);//linha em x do plano cartesiano com centro em (400,300)
  alpha=PI/240;//continuidade da linha
}

void draw() {
  //background(135, 206, 235);

  strokeWeight(1);
  translate(400, 300); //reseta o centro 

  //rotate(r);
  strokeWeight(5);

  rotate(-a); //rotaciona 
  point(r, 0);
  if(r<=200){// a coordenada em x e o angulo e atualizado até o momento que chega em (200,0)
    a = a + alpha;//adiciona alpha no angulo de rotacao por frame
    r = r + 100*(alpha/PI);//adiciona (ALPHA/PI) ao comprimento a' r
  }
}
