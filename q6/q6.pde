public class MCU {
  private float r, ω, φ0;
  
  public MCU (float f, float r, float φ0) {  // f: frequência em Hz (revoluções por segundo)
    this.r = r;   // raio
    this.φ0 = φ0; // fase inicial (ângulo em que o movimento inicia)
    ω = TWO_PI*f; // velocidade angular em radianos por segundo
  }
  
  // ângulo (em radianos) no instante t
  public float φ (float t) {
    return ω*t + φ0;
  }
  
  // vetor posição no instante t
  public PVector s (float t) {
    float aux = φ(t);
    return new PVector(r*cos(aux), r*sin(aux));
  }
}

final float Ra = 100, Rb = 25, Rc = 2;
final float Da = 2*Ra, Db = 2*Rb;

// trajetória circular do ponto de contato entre o anel e o plano de apoio
final MCU Ca = new MCU(0.25, Ra, 0);

// trajetória circular do ponto fixo no interior do anel
final MCU Cb = new MCU(1, Rb, 0);

// cor brilhante: sentido positivo
// cor escurecida: sentido negativo
void showAxis (float len) {
  
  // eixo x - verde
  stroke(0, 128, 0);
  line(-len, 0, 0, 0, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, len, 0, 0);
  
  // eixo y - vermelho
  stroke(128, 0, 0);
  line(0, -len, 0, 0, 0, 0);
  stroke(255, 0, 0);
  line(0, 0, 0, 0, len, 0);
  
  // eixo z - azul
  stroke(0, 0, 128);
  line(0, 0, -len, 0, 0, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, len);
  
}

void setup() {
  size(1500, 1000, P3D);
  rectMode(CENTER);
}

void draw() {
  lights();
  background(0);
  
  // posiciona a câmera
  camera(-200, 2*Ra, Ra, // eyeX, eyeY, eyeZ
         Ra, Ra, Ra, // centerX, centerY, centerZ
         0, 0, -1); // upX, upY, upZ
  
  // desenha em cores diferentes os eixos do sistema de coordenadas na posição original
  showAxis(600);
  
  // o plano de apoio encontra-se inclinado 60 graus em torno do eixo Y
  rotateY(-radians(60));
  
  // centro do sistema de coordenadas coincidindo com o centro do quadrado e do círculo
  translate(Ra, Ra, 0);
  
  stroke(255);           // branco
  noFill();              // sem preenchimento
  rect(0, 0, Da, Da);    // quadrado sobre o plano de apoio
  ellipse(0, 0, Da, Da); // círculo inscrito no quadrado
  
  // plano xy ortogonal ao plano de apoio
  rotateY(HALF_PI);
  
  // transcorridos t segundos desde o início da execução do programa
  float t = millis()/1000.0;
  
  // eixo z na direção radial do ponto de contato entre o anel e o plano de apoio
  rotateX(Ca.φ(t));
  
  // centro do sistema de coordenadas coincidindo com o centro do anel
  translate(-Rb, 0, Ra);

  stroke(255, 255, 0);   // amarelo
  ellipse(0, 0, Db, Db); // anel
  
  // posição do ponto fixo girando (dentro do anel)
  PVector s = Cb.s(t);
  
  // centro do sistema de coordenadas coincidindo com o ponto fixo no anel
  translate(s.x, s.y, 0);
  
  noStroke();
  fill(0, 255, 255);  // ciano
  sphere(Rc);
}
