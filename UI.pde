void setUI() {
  
  int initX = 80;
  int initY = 60;
  
  //UI
  cp5 = new ControlP5(this);
  
  //envVar
  Group SIZE = cp5.addGroup("SIZE")
             .setPosition(initX, initY);
  
  cp5.addSlider("sizeX", 10, 800, sizeX, 5, 5, sliderLength, 15)
             .setColorCaptionLabel(0)
             .setGroup(SIZE);
  cp5.addSlider("sizeY", 10, 200, sizeY, 5, 25, sliderLength, 15)
             .setColorCaptionLabel(0)
             .setGroup(SIZE);
             
  cp5.addSlider("addRay", 100, 350, addRay, 5, 45, sliderLength, 15)
             .setColorCaptionLabel(0)
             .setGroup(SIZE);
          
  Group NOISE = cp5.addGroup("NOISE")
             .setPosition(initX, initY * 2 + 40);          
    
    
  //NOISE
  cp5.addSlider("noiseRatio", 0.1, 1, noiseRatio, 5, 5, sliderLength, 15)
             .setColorCaptionLabel(0)
             .setGroup(NOISE);
             
  cp5.addSlider("noiseSpeed", 0.001, 0.01, noiseSpeed, 5, 25, sliderLength, 15)
             .setColorCaptionLabel(0)
             .setGroup(NOISE);
             
  cp5.addSlider("noiseAmp", 50, 500, noiseAmp, 5, 45, sliderLength, 15)
             .setColorCaptionLabel(0)
             .setGroup(NOISE);
             
  Group DISPLAY = cp5.addGroup("DISPLAY")
             .setPosition(initX, initY * 3 + 80); 
  
  cp5.addSlider("wordsOpacity", 0, 155, wordsOpacity, 5, 5, sliderLength, 15)
             .setColorCaptionLabel(0)
             .setGroup(DISPLAY);
             
  cp5.addSlider("particulesOpacity", 0, 400, particulesOpacity, 5, 25, sliderLength, 15)
             .setColorCaptionLabel(0)
             .setGroup(DISPLAY);
             
  
  //filterVar
  Group FILTER = cp5.addGroup("FILTER")
             .setPosition(initX + 1.3 * sliderLength, initY); 
  
  cp5.addRange("wordsLengthFilter")
             // disable broadcasting since setRange and setRangeValues will trigger an event
             .setBroadcast(false) 
             .setPosition(5,5)
             .setSize(sliderLength,20)
             .setHandleSize(10)
             .setRange(0,300)
             .setColorCaptionLabel(0)
             .setColorTickMark(0)
             .setNumberOfTickMarks(10)
             .setRangeValues(wordsLengthFilterMin, wordsLengthFilterMax)
             // after the initialization we turn broadcast back on again
             .setBroadcast(true)
             .setGroup(FILTER);
             
  cp5.addRange("nbWordsFilter")
             // disable broadcasting since setRange and setRangeValues will trigger an event
             .setBroadcast(false) 
             .setPosition(5,35)
             .setSize(sliderLength,20)
             .setHandleSize(10)
             .setColorCaptionLabel(0)
             .setColorTickMark(0)
             .setRange(0,10)
             .setNumberOfTickMarks(10)
             .setRangeValues(nbWordsFilterMin, nbWordsFilterMax)
             // after the initialization we turn broadcast back on again
             .setBroadcast(true)
             .setGroup(FILTER);
             
  cp5.addRange("type")
             // disable broadcasting since setRange and setRangeValues will trigger an event
             .setBroadcast(false) 
             .setPosition(5,65)
             .setSize(sliderLength,20)
             .setHandleSize(10)
             .setColorCaptionLabel(0)
             .setColorTickMark(0)
             .setRange(1,5)
             .setNumberOfTickMarks(4)
             .setRangeValues(typeMin, typeMax)
             // after the initialization we turn broadcast back on again
             .setBroadcast(true)
             .setGroup(FILTER);
  
  cp5.setAutoDraw(false);
}
void setText() {
  
  int initX = width - 400;
  int initY = height - 500;
  
  int initX2 = width - 400;
  int initY2 = height - 380;
  
  int initX3 = 80;
  int initY3 = height - 150;
  
  Group TEXT = cp5.addGroup("TWEETS COUNT")
             .setPosition(initX, initY); 
             
  globalTxt = cp5.addTextlabel("globalTxt")
                    .setText("TOTAL : " + str(globalCpt))
                    .setPosition(0, 10)
                    .setColorValue(0)
                    .setGroup(TEXT)
                    ;
  type1 = cp5.addTextlabel("type1")
                    .setText("TYPE 1 (Global warning is not happening) : " + str(typeCpt[0]))
                    .setPosition(0, 22)
                    .setColorValue(0)
                    .setGroup(TEXT)
                    ;
  type2 = cp5.addTextlabel("type2")
                    .setText("TYPE 2 (Human GreenHouse Gases are not causing global warming) : " + str(typeCpt[1]))
                    .setPosition(0, 32)
                    .setColorValue(0)
                    .setGroup(TEXT)
                    ;
  type3 = cp5.addTextlabel("type3")
                    .setText("TYPE 3 (Climate impacts are not bad) : " + str(typeCpt[2]))
                    .setPosition(0, 42)
                    .setColorValue(0)
                    .setGroup(TEXT)
                    ;
  type4 = cp5.addTextlabel("type4")
                    .setText("TYPE 4 (Climate solutions won't work) : " + str(typeCpt[3]))
                    .setPosition(0, 52)
                    .setColorValue(0)
                    .setGroup(TEXT)
                    ;
  type5 = cp5.addTextlabel("type5")
                    .setText("TYPE 5 (Climate mouvement/science is unreliable) : " + str(typeCpt[4]))
                    .setPosition(0, 62)
                    .setColorValue(0)
                    .setGroup(TEXT)
                    ;
  
  fps = cp5.addTextlabel("fps")
                    .setText("fps : " + str(frameRate))
                    .setPosition(5, 5)
                    .setColorValue(0)
                    ;   
                    
  Group KEYWORDS = cp5.addGroup("KEYWORDS")
             .setPosition(initX2, initY2); 
             
  wordsCount = cp5.addTextlabel("wordsCount")
                    .setText("TOTAL : " + visibleWords.size())
                    .setPosition(0, 10)
                    .setColorValue(0)
                    .setGroup(KEYWORDS)
                    ;
  wordsList = cp5.addTextlabel("wordsList")
                    .setText("")
                    .setPosition(0, 22)
                    .setColorValue(0)
                    .setGroup(KEYWORDS)
                    ;
             
  String font = "Noto Mono";                  
  title = cp5.addTextlabel("title")
                    .setText("Critical Climate Machine Visualisation")
                    .setPosition(initX3, initY3)
                    .setColorValue(0)
                    .setFont(createFont(font,36))
                    ;
  sub = cp5.addTextlabel("sub")
                    .setText("Critical Climate Machine (Patterns of Heat) is a research based project that quantifies and reveals the mechanisms of online misinformation about global warming."
                    + "\n"
                    + "Dataset collected by Gaëtan Robillard and Jolan Goulin, as part of the project MediaFutures and 'The Intelligent Museum'."
                    + "\n"
                    + "This visualisation also relies on paper from Travis G. Coan, & al. : 'Computer-assisted classification of contrarian claims about climate change', Nature, 2021." )
                    .setPosition(initX3 + 3, initY3 + 50)
                    .setColorValue(0)
                    .setFont(createFont(font,14))
                    ;
}

void updateText() {
  
  globalTxt.setText("TOTAL : " + str(globalCpt));
  
  type1.setText("TYPE 1 (Global warning is not happening) : " + str(typeCpt[0]));
  type2.setText("TYPE 2 (Human GreenHouse Gases are not causing global warming) : " + str(typeCpt[1]));
  type3.setText("TYPE 3 (Climate impacts are not bad) : " + str(typeCpt[2]));
  type4.setText("TYPE 4 (Climate solutions won't work) : " + str(typeCpt[3]));
  type5.setText("TYPE 5 (Climate mouvement/science is unreliable) : " + str(typeCpt[4]));
  
  fps.setText("fps : " + str(frameRate));
  
  wordsCount.setText("TOTAL : " + visibleWords.size());
  
  String s = "";
  for(int i = 0; i < visibleWords.size(); i++){
    
    s += visibleWords.get(i) + ", ";
    if(i%7 == 0 && i >= 7) s+= "\n";
  }
  wordsList.setText(s);
}
