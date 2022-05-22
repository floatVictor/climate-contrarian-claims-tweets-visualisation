class Particule {
  
  int id;
  int type;
  float angle;
  float r, r2;
  PVector pos;
  int size;
  String [] words;
  color c;
  
  Particule(int id, int type, float angle, float r, float z, int size, String [] words) {
    
    this.id = id;
    this.type = type;
    //print("   " + r);
    this.r = map(r, 16, 59, 0, 1);
    this.r2 = r * sizeX;
    this.angle = angle - random(0, (2*PI) / 5);
    
    this.pos = new PVector(r2 * cos(angle), r2 * sin(angle), words.length * sizeY);
    
    this.size = size;
    this.words = words;
    this.c = listColors.get(type - 1);
  }
  
  void update() {
    
    this.pos.z = words.length * sizeY;
    this.pos.z += noise(pos.x * noiseRatio, pos.x * noiseRatio, frameCount * noiseSpeed) * noiseAmp - noiseAmp/2;
    this.r2 = r * sizeX + addRay;
    this.pos.x = r2 * cos(angle);
    this.pos.y = r2 * sin(angle);
  }
  
  void display() {
    
    stroke(this.c, particulesOpacity * (this.words.length + 1) * .23);
    strokeWeight(1);
    noFill();
    //curve(cos(this.id) * 10, 0, cos(pos.x) * 100, 0, 0, words.length * sizeY/2, pos.x, pos.y, pos.z + 10, sin(this.id) * 10, pos.y, 0); 
    curve(cos(radians(frameCount)) * 10, 0, sin(radians(frameCount)) * 100,
          addRay * cos(angle), addRay * sin(angle), words.length * sizeY/2, 
          pos.x, pos.y, pos.z + 10, 
          cos(radians(frameCount)) * 10, sin(radians(frameCount)) * 100, cos(radians(frameCount)) * 200 + 100); 
    
    /*textSize(2); 
    fill(255, 100); 
    float angle = atan2(pos.x - 0, pos.z - 0) * 180 / PI;
    push();
    rotateZ(angle);
    rotateX(-PI/2);
    translate(pos.x, pos.y, pos.z);
    text("Hey", 0, 0, 0); 
    pop();*/
    
    
    //line(0, 0, words.length * 3, pos.x, pos.y, pos.z + 10);
  }
  
  boolean wordMatch(String word) {
    
    for(String s : words) {
      
      if(s == word) return true;
    }
    return false;
  }
  
  void addVisibleWords() {
    
    for(int i = 0; i < this.words.length; i++) {
      
      boolean temp = false;
      for(int j = 0; j < visibleWords.size(); j++) {
        
        if(this.words[i] == visibleWords.get(j)) temp = true;
      }
      if(!temp) visibleWords.add(words[i]);
    }
  }
}
