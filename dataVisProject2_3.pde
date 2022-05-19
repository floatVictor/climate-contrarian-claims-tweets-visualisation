import controlP5.*;
import peasy.*;

PeasyCam cam;
ControlP5 cp5;

JSONArray dataSet;
String [] keywords;
String [] type;

ArrayList<Particule> listParticules = new ArrayList<Particule>();
String [] listKeywords;
String [] listTypes;
ArrayList<String> visibleWords = new ArrayList<String>();
ArrayList<Integer> listColors = new ArrayList<Integer>();

ArrayList<ArrayList<Particule>> listWordsMatch = new ArrayList<ArrayList<Particule>>();



//global var
int winSizeX, winSizeY;

float sizeX = 320;
float sizeY = 45;

float noiseRatio = 0.3;
float noiseSpeed = 0.001;
float noiseAmp = 100;

int particulesOpacity = 200;
int wordsOpacity = 45;

//filters
int wordsLengthFilterMin = 0;
int wordsLengthFilterMax = 300;

int nbWordsFilterMin = 0;
int nbWordsFilterMax= 10;

int typeMin = 1;
int typeMax= 5;

int addRay = 130;

//UI
int sliderLength = 300;
Textlabel globalTxt;
Textlabel type1, type2, type3, type4, type5, fps;
Textlabel wordsCount, wordsList;
Textlabel title, sub;

//cpt
int globalCpt = 0;
int [] typeCpt = new int[5];

void setup() {
  
  fullScreen(P3D);
  colorMode(HSB, 255);
  
  listColors.add(color(random(50, 255), random(60, 200), random(100, 200)));
  listColors.add(color(random(50, 255), random(60, 200), random(100, 200)));
  listColors.add(color(random(50, 255), random(60, 200), random(100, 200)));
  listColors.add(color(random(50, 255), random(60, 200), random(100, 200)));
  listColors.add(color(random(50, 255), random(60, 200), random(100, 200)));
  
  dataSet = loadJSONArray("assets/dataSet.json");
  keywords = loadStrings("assets/keywords.txt");
  type = loadStrings("assets/type.txt");
  listKeywords = split(keywords[0], ',');
  listTypes = split(type[0], ',');
  
  
  cam = new PeasyCam(this, 0, 0, 175, 700);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(5000);
  cam.setSuppressRollRotationMode();
  
  setUI();
  setText();
  
  //init List
  createListParticules();
  createListWordsMatch();
}

void draw() {
  
  background(210);
  resetCpt();
  visibleWords.clear();
  //displayAxis(350);
  displayZLabel(sizeY * 10, 170);
  
  for(int i = 0; i < listParticules.size(); i++) {

    if(listParticules.get(i).words.length >= nbWordsFilterMin && 
       listParticules.get(i).words.length < nbWordsFilterMax &&
       listParticules.get(i).type >= typeMin &&
       listParticules.get(i).type <= typeMax) {
         
      listParticules.get(i).update();
      if(particulesOpacity > 0) {
        
        listParticules.get(i).display();
        updateCpt(listParticules.get(i).type);
      }
    }
  }
  
  if(wordsOpacity > 8) displayListWordsMatch();
 
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  updateText();
   
  displayTypeLabel(710, 170);
  displayCircle(170);
}

//init listParticules
  
void createListParticules() {
  
  int id = 0;
  
  for(int i = 0; i < dataSet.size(); i++) {
    
    JSONObject item = dataSet.getJSONObject(i);
    
    if(item.size() >= 6 && int(item.getString("category").substring(0, 1)) != 0) {
      
      String [] words = setWords(item.getString("text"));
      
      Particule p = new Particule(
        id,
        int(item.getString("category").substring(0, 1)),
        setAngle(item.getString("category")),
        setR(String.format("%d",item.getLong("date"))),
        float(words.length),
        1,
        words
        );
        
        id++;
        
      listParticules.add(p);
    }
  }
}

float setAngle(String category) {

  String sub = category.substring(0, 1);
  float angle = (2*PI) / 5 * int(sub);
  return angle;
}

float setR(String date) {

  String sub = date.substring(4, 6);
  String sub2 = date.substring(6, 8);
  
  float nbDays = (int(sub)-11)*30 + int(sub2);
  return nbDays;
}

String [] setWords(String text) {

  String [] words = {};

  for(int i = 0; i < listKeywords.length; i++) {
    
    if(text.contains(listKeywords[i])) {
      words = append(words, listKeywords[i]);
    }
  }
  
  return words;
}

//listWordsMatch

void createListWordsMatch() {
  
  for(int i = 0; i < listKeywords.length; i++) {
    
    //println(listKeywords[i]);
    listWordsMatch.add(new ArrayList<Particule>());
    for(int j = 0; j < listParticules.size(); j++) {
      
      if(listParticules.get(j).words.length > 0 && listParticules.get(j).wordMatch(listKeywords[i])){
        
        listWordsMatch.get(i).add(listParticules.get(j));
        //println(listParticules.get(j).id);
      }
    }
  }
}

void displayListWordsMatch() {
  
  noFill();
  for(int i = 0; i < listWordsMatch.size(); i++) {
    
    strokeWeight(1);
    //stroke(map(listWordsMatch.get(i).size(), 0, 300, 150, 255), 230, 200 ,wordsOpacity);
    stroke(0, wordsOpacity);
    beginShape();
    if(listWordsMatch.get(i).size() > wordsLengthFilterMin && 
       listWordsMatch.get(i).size() < wordsLengthFilterMax) {
      
      for(int j = 0; j < listWordsMatch.get(i).size(); j++){
        
        if(listWordsMatch.get(i).get(j).words.length >= nbWordsFilterMin && 
           listWordsMatch.get(i).get(j).words.length < nbWordsFilterMax &&
           listWordsMatch.get(i).get(j).type >= typeMin &&
           listWordsMatch.get(i).get(j).type <= typeMax) {
             
           //stroke(map(listWordsMatch.get(i).size(), 0, 300, 150, 255), 230, 200 ,wordsOpacity * listWordsMatch.get(i).get(j).words.length * .3 + wordsOpacity * .2);
           stroke(0 ,wordsOpacity * listWordsMatch.get(i).get(j).words.length * .2 + wordsOpacity * .2);
           listWordsMatch.get(i).get(j).addVisibleWords();
           vertex(listWordsMatch.get(i).get(j).pos.x, listWordsMatch.get(i).get(j).pos.y, listWordsMatch.get(i).get(j).pos.z + 10);
        }
      }
    endShape();
    }
  }
}

//UI event
void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("wordsLengthFilter")) {
    
    wordsLengthFilterMin = int(theControlEvent.getController().getArrayValue(0));
    wordsLengthFilterMax = int(theControlEvent.getController().getArrayValue(1));
  }
  
  if(theControlEvent.isFrom("nbWordsFilter")) {
    
    nbWordsFilterMin = int(theControlEvent.getController().getArrayValue(0));
    nbWordsFilterMax = int(theControlEvent.getController().getArrayValue(1));
  }
  
  if(theControlEvent.isFrom("type")) {
    
    typeMin = int(theControlEvent.getController().getArrayValue(0));
    typeMax = int(theControlEvent.getController().getArrayValue(1));
  }
  
}

//additional 3d shape display

void displayAxis(int len) {
  
  colorMode(RGB, 255);
  stroke(255, 0, 0);
  line(0, 0, 0, len/2, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, len/2, 0);
  push();
  rotateX(radians(90));
  stroke(0, 0, 255);
  line(0, 0, 0, 0, len, 0);
  pop();
  colorMode(HSB, 255);
}

void displayTypeLabel(float len, float opa) {
  
  strokeWeight(3);
  //stroke(30, opa);
  textMode(MODEL);
  textSize(25);
  push();
  rotateZ(-2 * PI/5);
  for(int i = 0; i < 5; i ++) {
    
    rotateZ(2 * PI/5);
    fill(listColors.get(i),20);
    noStroke();
    beginShape();
    vertex(0, 0, -1);
    vertex(len * cos(10 * PI/5), len * sin(10 * PI/5), -1);
    vertex(len * cos(12 * PI/5), len * sin(12 * PI/5), -1);
    endShape();
    fill(listColors.get(i));
    stroke(listColors.get(i), opa);
    text(listTypes[i], addRay/2, -5, 0);
    line(0, 0, 0, len, 0, 0);
  }
  pop();
}

void displayZLabel(float len, float opa) {
  
  textMode(SHAPE);
  strokeWeight(3);
  textSize(16);
  fill(40, opa);
  stroke(40, opa);
  
  line(0, 0, 0, 0,0,len);
  
  push();
  translate(0, 0, - sizeY);
  
  for(int i = 0; i < 10; i ++) {
    
    translate(0, 0, sizeY);
    push();
    rotateX(- PI/2);
    push();
    translate(3,- 3, 0);
    text(i, 0, 0, 0);
    pop();
    strokeWeight(1);
    line(0, 0, 0, 20, 0, 0);
    pop();
  }
  pop();
}

void displayBox(int size, int opa) {
  
  noFill();
  strokeWeight(1);
  stroke(15, opa);
  push();
  translate(0,0,size/2);
  box(size);
  pop();
}

void displayCircle(int opa) {
  
  noFill();
  strokeWeight(2);
  stroke(0, opa);
  
  circle(0, 0, 2 * addRay);
  circle(0, 0, 2 * (sizeX + addRay));
  fill(0,opa);
  circleText(addRay, "november 16th 2021",320 * .0005);
  circleText(sizeX + addRay, "december 29th 2021",90 * .0005);
}

void circleText(float r, String text, float t) {
  
  textMode(SHAPE);
  float x,y;
  String [] textData = text.split("");
  for(int i = 0; i< textData.length; i++){
    
        for(int j = 0; j<textData[i].length(); j++){
          
          char letter = textData[i].charAt(j); 
          rotate(t);          
          x = r*(cos(t));
          y = r*(sin(t));
          
          text(letter, x + 3, y);
        }    
  }
}

//cptFunctions

void resetCpt() {
  
  globalCpt = 0;
  typeCpt = new int[5];
}

void updateCpt(int index) {
  
  globalCpt ++;
  typeCpt[index - 1] ++;
}

//
void printVW() {
  for(int i = 0; i < visibleWords.size(); i++) 
    print(visibleWords.get(i) + " ; ");
  println(frameCount);
}
