class Organ{

  String name;  
  int boundaryW = 100;
  int boundaryH = 100;
  int x, y;
  String[] neighbours;
  ArrayList currNeighbours = new ArrayList();
  boolean exists = true;
  boolean selected = false;
  boolean locked = false; //for the dragging
  
  Organ(String name, int x, int y, String[] neighbours){
    this.name = name;
    this.x = x;
    this.y = y;
    this.neighbours = neighbours;
  }
  
  void display(){
    pushMatrix();
    translate(x,y);
      if (selected){
        stroke(255,0,0,120);
      } 
      if (overScanbar()){
         fill(200,0,120);        
         text(name +" is the favorite organ of Gorta. It is resposible for..", 0,+22,70,140);
         noFill();
         stroke(200,0,120);
      }
      else{
        fill(0);
        ellipse(0,0,10,10);
        stroke(0,0,200,120);
        text(name, 0,0);
        noFill();
      } 
      rect(0,0,boundaryW,boundaryH);
    popMatrix();  
  }
  
  //returns true if all their connections are found 
  boolean correctPosition(){
    int corPosNo = 0;
    for (int i = 0; i < neighbours.length; i++){
      if (currNeighbours.contains(neighbours[i])){
        corPosNo++;
      }
    }
    if (corPosNo == neighbours.length){// && neighbours.length == currNeighbours.size()){
      return true;
    }
    else{
      return false;
    }
  }
  
  boolean mouseOver(){
    return(mouseX< x + boundaryW/2 && mouseX > x-boundaryW/2 && mouseY < y +boundaryH/2 && mouseY> y-boundaryH/2);
  }
  
  boolean overScanbar(){
    float disX = scanX - x;
    float disY = scanY - y;
    return(sqrt(sq(disX) + sq(disY)) < scanR/4);
  }
  
}
