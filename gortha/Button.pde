class Button {
  Ellipse ellipse1;
  Ellipse ellipse2;
  String name;
  boolean pressed = false;

  Button(String nam, int posx, int posy, int rad) {
    this.ellipse1 = new Ellipse(posx, posy, rad);
    this.ellipse2 = new Ellipse(posx, posy, 3);
    this.name = nam;
  }

  void display() {
    ellipse1.display(this.pressed);
    ellipse2.display(this.pressed);
    fill(150);
    text(name, ellipse1.x + 20, ellipse1.y + 5);
  }

  boolean clicked() {
    float disX = ellipse1.x - mouseX;
    float disY = ellipse1.y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < ellipse1.radius) {
      return true;
    } 
    else {
      return false;
    }
  }
}

class Ellipse {
  int x;
  int y;
  int radius;
  color c;
  color str;


  Ellipse(int posx, int posy, int rad) {
    x = posx;
    y = posy;
    radius = rad;
  }

  void display(boolean pressed) {
    noFill();
    strokeWeight(1);
    stroke(255, 0, 0);
    ellipse(x, y, radius * 2, radius * 2);
    if (pressed) {
      fill(255, 0, 0);
      ellipse(x, y, radius* 0.8, radius* 0.8 );
    }
  }
}
