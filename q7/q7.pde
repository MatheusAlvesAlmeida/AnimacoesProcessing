final float r = 20;

final PVector[] pts = {
  new PVector(100.0, 400.0, 0.0),       // A
  new PVector(50.0/3.0, -100.0, 500.0), // B
  new PVector(0.0, 0.0, 600.0),         // C
  new PVector(-50.0/3.0, 100.0, 500.0), // D
  new PVector(-100.0, -400.0, 0.0)      // E
};

public class Helix {
  private float r, ω, φ0, vx;
  private PVector c;
  public Helix (float ω, float r, float φ0, float vx, float cx, float cy, float cz) {
    this.ω = ω;   // velocidade angular, em radianos por segundo
    this.r = r;   // raio
    this.φ0 = φ0; // fase inicial (ângulo em que o movimento inicia)
    this.vx = vx; // velocidade constante no eixo x
    
    // cx: posição inicial no eixo x
    // (cy, cz): centro do círculo no plano yz
    this.c = new PVector(cx, cy, cz);
  }
  
  // ângulo no instante t
  public float φ (float t) {
    return ω*t + φ0;
  }
  
  // vetor posição no instante t
  public PVector s (float t) {
    float aux = φ(t);
    return PVector.add(c, new PVector(vx*t, r*cos(aux), r*sin(aux)));
  }
}

// de A até B
final Helix a = new Helix(-PI/6.0, 500, -HALF_PI, -250.0/9.0, pts[0].x, pts[0].y, pts[1].z);

// de B até D, passando por C
final Helix b = new Helix(-HALF_PI, 100, -PI, -50.0/3.0, pts[1].x, 0, 500);

// de D até E
final Helix c = new Helix(-PI/6.0, 500, 0, -250.0/9.0, pts[3].x, pts[4].y, pts[3].z);

// quais as coordenadas do centro da esfera após t segundos?
PVector position (float t) {
  if (t > 8) {
    return pts[4];  // o ponto final E
  } else {
    Helix h;
    if (t < 3) {  // de A até B
      h = a;
    } else if (t < 5) {  // de B até D, passando por C
      t -= 3;
      h = b;
    } else {  // de D até E
      t -= 5;
      h = c;
    }
    return h.s(t);
  }
}

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

// cubos brancos vazados nos checkpoints por onde a esfera passa
// para facilitar a visualização do movimento
void checkpoints () {
  noFill();
  stroke(255);
  for (PVector pt : pts) {
    pushMatrix();
    translate(pt.x, pt.y, pt.z);
    box(2*r, 2*r, 2*r);
    popMatrix();
  }
}

void setup() {
  size(1500, 1000, P3D);
}

void draw() {
  lights();
  background(0);  // fundo preto
  
  // posiciona a câmera
  camera(1000, 50, 800, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 0.0, -1.0); // upX, upY, upZ
         
  // mostra os eixos em cores diferentes para nos situarmos melhor
  showAxis(600);
  
  // desenha os checkpoints
  checkpoints();
  
  // t segundos transcorridos desde o início da execução do programa
  float t = millis()/1000.0;
  
  // equações paramétricas das curvas
  // retornam o vetor posição da esfera no instante t
  PVector pos = position(t);
  translate(pos.x, pos.y, pos.z);
  
  noStroke();
  fill(128);  // cinza
  sphere(r);
}
