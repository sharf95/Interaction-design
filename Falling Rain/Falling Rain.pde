ArrayList particles = new ArrayList();
float box = 150, num;
 
void setup() {
  size(720, 480, P3D);
  frameRate(60);
  noFill();
  noiseSeed(0);
}
 
void draw() {
  background(0);
  for (int i = 0; i < 150; i++) {
    particles.add(new Particle(new PVector(random(-box, box), -box, random(-box, box)), new PVector(random(-1, 1), random(-1, 1), random(-1, 1))));
  }
   
  translate(width/2, height/2);
  rotateX(radians(num));
  for (int i = 0; i < particles.size (); i++) {
    Particle p = (Particle) particles.get(i);
    p.draw();
    p.move();
    p.applyForce(new PVector(0, 10, 0)); 
    float b = noise(+map(p.loc.x, -box, box, 0, 5))*noise(561+map(p.loc.y, -box, box, 0, 5))*noise(278+map(p.loc.z, -box, box, 0, 5))*box*2;
    p.boundary(b);
  }
  num+=358;
}
 
class Particle {
  PVector loc, vel, acc;
  float bounce = 5;
 
  float life = box*5;
  float maxLife = life;
 
  Particle(PVector loc, PVector acc) {
    this.loc = loc;
    vel = new PVector();
    this.acc = acc;
  }
 
  void draw() {
    strokeWeight(map(life, 0, maxLife, 15, 3));
    stroke(#A00303, map(life, 0, maxLife, 0, 255));
    point(loc.y, loc.x, loc.z);
    life--;
  }
 
  void move() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
  }
 
 
  void applyForce(PVector force) {
    acc.add(PVector.div(force, 20));
  }
 
  void boundary(float b) {
    if (loc.x < -box) {
      vel.x *= bounce;
      loc.x = -box;
    }
    if (loc.x > box) {
      vel.x *= bounce;
      loc.x = box;
    }
 
    if (loc.y < -box) {
      vel.y *= bounce;
      loc.y = -box;
    }
    if (loc.y > box-b) {
      vel.mult(0);
      loc.y = box-b;
    }
 
    if (loc.z < -box) {
      vel.z *= bounce;
      loc.z = -box;
    }
    if (loc.z > box) {
      vel.z *= bounce;
      loc.z = box;
    }
 
    if (life < 0) {
      particles.remove(this);
    }
  }
}
