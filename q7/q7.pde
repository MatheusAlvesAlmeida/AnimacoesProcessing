final PVector[] pts = {
  new PVector(100.0, 400.0, 0.0),
  new PVector(50.0/3.0, -100.0, 500.0),
  new PVector(0.0, 0.0, 600.0),
  new PVector(-50.0/3.0, 100.0, 500.0),
  new PVector(-100.0, -400.0, 0.0)
};

void setup() {
  size(1000, 1000, P3D);
}

void draw() {
  lights();
  background(0);
  
  // posiciona a câmera
  camera(800, 800, 800, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 0.0, -1.0); // upX, upY, upZ
         
  // mostra os eixos em cores diferentes para nos situarmos melhor
  showAxis(600);

  noStroke();
  fill(128);
  PVector pos = position(millis()/1000.0);
  translate(pos.x, pos.y, pos.z);
  sphere(20.0);
  
}

// cor brilhante: sentido positivo
// cor escurecida: sentido negativo
void showAxis (float len) {
  
  // eixo x - vermelho
  stroke(128, 0, 0);
  line(-len, 0, 0, 0, 0, 0);
  stroke(255, 0, 0);
  line(0, 0, 0, len, 0, 0);
  
  // eixo y - verde
  stroke(0, 128, 0);
  line(0, -len, 0, 0, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, len, 0);
  
  // eixo z - azul
  stroke(0, 0, 128);
  line(0, 0, -len, 0, 0, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, len);
  
}

// quais as coordenadas do centro da esfera após t segundos?
PVector position (float t) {
  if (t > 8.0) {
    return pts[4];
  } else {
    PVector s0;
    float omega, phi, vx, a;
    if (t < 3.0) {
      s0 = new PVector(pts[0].x, pts[0].y, pts[1].z);
      vx = -250.0/9.0;
      a = 500.0;
      omega = -PI/6.0;
      phi = -HALF_PI;
    } else if (t < 5.0) {
      s0 = new PVector(pts[1].x, 0.0, 500.0);
      vx = -50.0/3.0;
      t -= 3.0;
      a = 100.0;
      omega = -HALF_PI;
      phi = -PI;
    } else {
      s0 = new PVector(pts[3].x, pts[4].y, pts[3].z);
      vx = -250.0/9.0;
      t -= 5.0;
      a = 500.0;
      omega = -PI/6.0;
      phi = 0.0;
    }
    float theta = omega*t + phi;
    return s0.add(new PVector(vx*t, a*cos(theta), a*sin(theta)));
  }
}
