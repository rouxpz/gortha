/*
- bugs: dragging sometimes fail
- if everything is conencted to everything, you can treak the code - make sure the number of connection are the real number one organ has






*/

boolean running = false;

int canvasX = 1000;
int canvasY = 700;
ArrayList OrganArray = new ArrayList();

//scanner parameters
int scanX= canvasX-100;
int scanY= 100;
int scanR = 170;

//dragging parameters
int dragX = 0;
int dragY = 0;
int draggedOrgan = 1000;

boolean showResult = false;
boolean result = false;

//init buttons
Button checkButton = new Button("check connections", 30, 50, 10);
Button reset = new Button("reset", 30, 75, 10);


void setup() {
  size(canvasX, canvasY);
  background(255);
  smooth();
  rectMode(CENTER);
  noStroke();
  loadOrgans();
}

void draw() {
  background(220);
  drawOrgans();
  drawConnections();
  scanOrgan();
  checkButton.display();
  reset.display();
  
  if(showResult){
    if (result){
      text("GoodJob",width/2, height/2);
    }
    else{
      text("Try it again!",width/2, height/2);
    }
  }
}

void scanOrgan(){
  pushMatrix();
  translate(scanX, scanY);
    fill(200,0,120);
    text("SCANNER",-scanR/4,-scanR/2-5);
    noFill();
    stroke(200,0,120);
    ellipse(0,0,scanR,scanR);
  popMatrix();
}

void drawConnections() {
  for (int i = 0; i < OrganArray.size(); i++) {
  Organ org = (Organ) OrganArray.get(i); 
  for (int j = 0; j < org.neighbours.length; j++) { //get the neighbour names
    for (int k = 0; k < OrganArray.size(); k++) {
       Organ tmp = (Organ) OrganArray.get(k);
       if ( abs(org.x-tmp.x) < (org.boundaryW+tmp.boundaryW)/2 && abs(org.y-tmp.y) < (org.boundaryH+tmp.boundaryH)/2) { //if the organs touching each other they connect
          if (!org.currNeighbours.contains(tmp.name)){
            org.currNeighbours.add(tmp.name);
          }
          stroke(255, 0, 0);
          line(org.x, org.y, tmp.x, tmp.y); 
        }
        else {
          if (org.currNeighbours.contains(tmp.name)){
            org.currNeighbours.remove(tmp.name);
          }
          org.selected = false; 
        }
      }
    }
  }
}



void mousePressed() {
   if (checkButton.clicked()) {
      showResult = true;
      int correctInPlace = 0;
      for (int i = 0; i < OrganArray.size(); i++) {
        Organ org = (Organ) OrganArray.get(i);
        if (org.correctPosition()){
          correctInPlace ++;
        }
      }
      fill(0);
      println("correctInplace: " + correctInPlace);
      if(correctInPlace == OrganArray.size()){
       result = true;
      }
      correctInPlace = 0;
    }
    else if (reset.clicked()) {
      OrganArray.clear();
      loadOrgans();
      showResult = false;
      result = false;
    }
}

void mouseDragged() {
  showResult = false; //init results
  result = false;
  
  if (draggedOrgan == 1000) {
    for (int i = 0; i < OrganArray.size(); i++) {
      Organ org = (Organ) OrganArray.get(i);
      if (org.mouseOver()) {
        draggedOrgan = i;
      }
    }
  }
  else {
    cursor(HAND);
    Organ org = (Organ) OrganArray.get(draggedOrgan);
    org.selected = true;
    if (org.locked) {
      org.x = mouseX-dragX;
      org.y = mouseY-dragY;
    }
    dragX = mouseX - org.x;
    dragY = mouseY - org.y;
    org.locked = true;
  }
}
void mouseReleased() {
  for (int i = 0; i < OrganArray.size(); i++) {
    Organ org = (Organ) OrganArray.get(i);
    if (org.mouseOver()) {
      org.locked = true;
      org.selected = false;
      draggedOrgan = 1000;
    }
  }
  cursor(ARROW);
}

void keyPressed() {
  if ( key == 'r') {
    //reset
    OrganArray.clear();
    loadOrgans();
  }
}

void drawOrgans() {
  for (int i = 0; i < OrganArray.size(); i++) {
    Organ o = (Organ) OrganArray.get(i);
    o.display();
  }
}

void loadOrgans() {

  String[] mouthNeighbour = {"esophagus"};
  Organ mouth = new Organ("mouth", int(random(width)), int(random(height)), mouthNeighbour);

  String[] esoNeighbour = {"mouth", "stomach"}; 
  Organ esophagus = new Organ("esophagus", int(random(width)), int(random(height)), esoNeighbour);  

  String[] stomNeighbour = {"esophagus", "small intestine"}; 
  Organ stomach = new Organ("stomach", int(random(width)), int(random(height)), stomNeighbour);

  String[] smallIntNeighbour = {"stomach", "large intestine"};
  Organ smallInt = new Organ("small intestine", int(random(width)), int(random(height)), smallIntNeighbour);

  String[] largeIntNeighbour = {"small intestine"};
  Organ largeInt = new Organ("large intestine", int(random(width)), int(random(height)), largeIntNeighbour);

  OrganArray.add(mouth);
  OrganArray.add(esophagus);
  OrganArray.add(stomach);
  OrganArray.add(smallInt);
  OrganArray.add(largeInt);
}




