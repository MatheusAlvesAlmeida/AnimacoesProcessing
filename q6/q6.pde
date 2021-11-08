public class MCU {
  private float r, ω, φ0;
  public MCU (float f, float r, float φ0) {
    this.r = r;
    this.φ0 = φ0;
    ω = TWO_PI*f;
  }
  public float φ (float t) {
    return ω*t + φ0;
  }
  public PVector s (float t) {
    float aux = φ(t);
    return new PVector(r*cos(aux), r*sin(aux));
  }
}

float Ra, Da, Rb, Db, Rc;
MCU Ca, Cb;

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
  noFill();
  Ra = 100.0;
  Rb = 25.0;
  Rc = 2.0;
  Da = 2*Ra;
  Db = 2*Rb;
  Ca = new MCU(0.25, Ra, 0);
  Cb = new MCU(1, Rb, 0);
}

void draw() {
  lights();
  background(0);
  
  // posiciona a câmera
  camera(-200, Ra, Ra, // eyeX, eyeY, eyeZ
         Ra, Ra, Ra, // centerX, centerY, centerZ
         0, 0, -1); // upX, upY, upZ
  showAxis(600);
  /*stroke(64);
  ellipse(Ra, Ra, Da, Da);
  rect(Ra, Ra, Da, Da);*/
  
  rotateY(-radians(60));
  translate(Ra, Ra, 0);
  
  
  stroke(255);
  rect(0, 0, Da, Da);
  ellipse(0, 0, Da, Da);
  
  rotateY(HALF_PI);
  
  float t = millis()/1000.0;
  rotateX(Ca.φ(t));
  
  translate(-Rb, 0, Ra);
  
  stroke(255);
  ellipse(0, 0, Db, Db);
  
  PVector s = Cb.s(t);
  translate(s.x, s.y);
  noStroke();
  fill(255, 255, 0);
  sphere(Rc);
  noFill();
  
}
