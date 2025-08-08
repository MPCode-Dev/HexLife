boolean building = false;
boolean buildMenu = false;
boolean buildCounters = false;
boolean foodCounters = false;
float menuScroll = 0;
void drawUI(){
  imageMode(CORNER);
  image(goldCounter, 10, 10);
  fill(255);
  textSize(18); 
  text(gold, 70, 32);
  image(powerCounter, 150, 10);
  if (power < 0) {fill(255, 0, 0);}
  text(power, 210, 32);
  image(wheatCounter, 290, 10);
  fill(255);
  text(wheat, 350, 32);
  image(samwhichCounter, 430, 10);
  text(samwhich, 490, 32);
  image(woodCounter, 570, 10);
  text(wood, 630, 32);
  image(stoneCounter, 710, 10);
  text(stone, 770, 32);
  image(ironOreCounter, 850, 10);
  text(ironOre, 910, 32);
  image(ironCounter, 850, 60);
  text(iron, 910, 82);
  image(coalCounter, 710, 60);
  text(coal, 770, 82); 
  //image(counterMenu, 5, 10);
  fill (75, 75, 75);
  if (buildMenu){
  rect(100, 600, 900, 100);
  imageMode(CENTER);
  image(grassHex, 149 + menuScroll, 649, 64, 64);
  image(newFarm, 249 + menuScroll, 649, 64, 64);
  image(bakery, 349 + menuScroll, 649, 64, 64);
  image(barn, 449 + menuScroll, 649, 64, 64);
  image(house, 549 + menuScroll, 649, 64, 64);
  image(windmillBase, 649 + menuScroll, 649, 64, 64);
  image(windmillFrames.get(0), 649 + menuScroll, 649, 64, 64);
  image(oldMillBackground, 649 + menuScroll, 649, 64, 64);
  image(oldMillFrames.get(0), 649 + menuScroll, 649, 64, 64);
  image(windmillBase, 749 + menuScroll, 649, 64, 64);
  image(windmillFrames.get(1), 749 + menuScroll, 649, 64, 64); 
  image(lumbermill, 849 + menuScroll, 649, 64, 64);
  image(mine, 949 + menuScroll, 649, 64, 64);
  image(newTomato, 1049 + menuScroll, 649, 64, 64);
  image(newCabbage, 1149 + menuScroll, 649, 64, 64);
  image(smelter, 1249 + menuScroll, 649, 64, 64);

   imageMode(CORNER);
  } else {
  rect(500, 600, 100, 100);
  }
  imageMode(CENTER);
  drawSelectedTile();
}
void drawSelectedTile() {
  if (tileSelected == 1) {
    image(grassHex, mouseX, mouseY, 64, 64);
  }
  if (tileSelected == 2) {
    image(lakeHex, mouseX, mouseY, 64, 64);
  }
  if (tileSelected == 3) {
    image(newFarm, mouseX, mouseY, 64, 64);
  }
  if (tileSelected == 4) {
    image(bakery, mouseX, mouseY, 64, 64);
  }
  if (tileSelected == 5) {
    image(barn, mouseX, mouseY, 64, 64);
  }
  if (tileSelected == 6) {
    image(windmillBase, mouseX, mouseY, 64, 64);
    image(windmillFrames.get(0), mouseX, mouseY, 64, 64);
  }
  if (tileSelected == 7) {
    image(house, mouseX, mouseY, 64, 64);
  }
    if (tileSelected == 8) {
    image(grassHex, mouseX, mouseY, 64, 64);
    image(oldMillFrames.get(0), mouseX, mouseY, 64, 64);
  }
  if (tileSelected == 9) {
    image(lumbermill, mouseX, mouseY, 64, 64);
  }
  if (tileSelected == 10) {
    image(mine, mouseX, mouseY, 64, 64);
  }
    if (tileSelected == 11) {
    image(newTomato, mouseX, mouseY, 64, 64);
  }
    if (tileSelected == 12) {
    image(newCabbage, mouseX, mouseY, 64, 64);
  }
    if (tileSelected == 13) {
    image(smelter, mouseX, mouseY, 64, 64);
  }
}
