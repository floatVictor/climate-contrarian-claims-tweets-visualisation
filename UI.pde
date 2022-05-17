void setUI() {
  
  int initX = 80;
  int initY = 60;
  
  //UI
  cp5 = new ControlP5(this);
  
  //envVar
  Group SIZE = cp5.addGroup("SIZE")
             .setPosition(initX, initY);
  
  cp5.addSlider("sizeX", 10, 400, sizeX, 5, 5, sliderLength, 15)
             .setColorCaptionLabel(0)
             .setGroup(SIZE);
  cp5.addSlider("sizeY", 10, 200, sizeY, 5, 25, sliderLength, 15)
             .setColorCaptionLabel(0)
             .setGroup(SIZE);
             
  cp5.addSlider("addRay", 0, 500, addRay, 5, 45, sliderLength, 15)
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
             
  cp5.addSlider("particulesOpacity", 0, 320, particulesOpacity, 5, 25, sliderLength, 15)
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
             .setRange(0,5)
             .setNumberOfTickMarks(5)
             .setRangeValues(typeMin, typeMax)
             // after the initialization we turn broadcast back on again
             .setBroadcast(true)
             .setGroup(FILTER);
  
  cp5.setAutoDraw(false);
}
void setText() {
  
  int initX = width - 400;
  int initY = height - 600;
  
  Group TEXT = cp5.addGroup("TEXT")
             .setPosition(initX, initY); 
             
  globalTxt = cp5.addTextlabel("globalTxt")
                    .setText("VISIBLE TWEETS : " + str(globalCpt))
                    .setPosition(0, 10)
                    .setColorValue(0)
                    .setGroup(TEXT)
                    ;
  type1 = cp5.addTextlabel("type1")
                    .setText("TYPE 1 NB (Global warning is not happening) : " + str(typeCpt[0]))
                    .setPosition(0, 30)
                    .setColorValue(0)
                    .setGroup(TEXT)
                    ;
  type2 = cp5.addTextlabel("type2")
                    .setText("TYPE 2 NB (Human GreenHouse Gases are not causing global warming) : " + str(typeCpt[1]))
                    .setPosition(0, 40)
                    .setColorValue(0)
                    .setGroup(TEXT)
                    ;
  type3 = cp5.addTextlabel("type3")
                    .setText("TYPE 3 NB (Climate impacts are not bad) : " + str(typeCpt[2]))
                    .setPosition(0, 50)
                    .setColorValue(0)
                    .setGroup(TEXT)
                    ;
  type4 = cp5.addTextlabel("type4")
                    .setText("TYPE 4 NB (Climate solutions won't work) : " + str(typeCpt[3]))
                    .setPosition(0, 60)
                    .setColorValue(0)
                    .setGroup(TEXT)
                    ;
  type5 = cp5.addTextlabel("type5")
                    .setText("TYPE 5 NB (Climate mouvement/science is unreliable) : " + str(typeCpt[4]))
                    .setPosition(0, 70)
                    .setColorValue(0)
                    .setGroup(TEXT)
                    ;
                   
}

void updateText() {
  
  globalTxt.setText("VISIBLE TWEETS : " + str(globalCpt));
  
  type1.setText("TYPE 1 NB (Global warning is not happening) : " + str(typeCpt[0]));
  type2.setText("TYPE 2 NB (Human GreenHouse Gases are not causing global warming) : " + str(typeCpt[1]));
  type3.setText("TYPE 3 NB (Climate impacts are not bad) : " + str(typeCpt[2]));
  type4.setText("TYPE 4 NB (Climate solutions won't work) : " + str(typeCpt[3]));
  type5.setText("TYPE 5 NB (Climate mouvement/science is unreliable) : " + str(typeCpt[4]));
}
