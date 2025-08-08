import processing.pdf.*;

import java.util.Iterator;

float centerX = 550;
float centerY = 350;
boolean startScreenState = true;
int tileSelected = 0;

PVector[] neighborDirections = new PVector[]{
  new PVector(1, -1, 0),
  new PVector (1, 0, -1),
  new PVector (0, 1, -1),
  new PVector (-1, +1, 0),
  new PVector (-1, 0, +1),
  new PVector (0, -1, +1)};

//Background
PImage background;
PImage startScreen;
PImage boat;
// Tiles
PImage grassHex;
PImage lakeHex;
PImage barn;
PImage windmillBase;
PImage bakery;
PImage forest;
PImage house;
PImage mountainHex;
PImage straightRiver;
PImage curvedRiver;
PImage lumbermill;
PImage mine;
PImage straightRoad;
PImage curvedRoad;
PImage road3;
PImage smelter;
// Farms
PImage newFarm;
PImage grownFarm;
PImage newCabbage;
PImage grownCabbage;
PImage newTomato;
PImage grownTomato;
//Resource Counters
PImage goldCounter;
PImage powerCounter;
PImage wheatCounter;
PImage samwhichCounter;
PImage stoneCounter;
PImage woodCounter;
PImage ironCounter;
PImage coalCounter;
PImage ironOreCounter;
PImage counterMenu;
//Beaches
PImage beachEdgeLeft;
PImage beachCenterLeft;
PImage beachEdgeRight;
PImage beachCenterRight;
//UI
PImage tileMenu;
PImage tileSelector;
PImage wheatImage;
PImage samwhichImage;
PImage oldMillBackground;
//Resources
int gold = 60000;
int power = 0;
int wheat = 0;
int samwhich = 0;
int wood = 50;
int stone = 50;
int iron = 0;
int ironOre = 0;
int coal = 0;
//Misc
float screenScrollX = 0;
float screenScrollY = 0;
float screenZoom = 1;
float tileDistance = 64;
float lastMouseX;
float lastMouseY;

int animationFrame = 0;
int currentRotation = 0;

float lakeChance = 0.1;
float forestChance = 0.1;
  
GameBoard gameBoard;

ArrayList <PImage> windmillFrames = new ArrayList<PImage>();
ArrayList <PImage> oldMillFrames = new ArrayList<PImage>();
ArrayList <Particle> particles = new ArrayList<>();
Container container = new Container(new Hex(1, 1, 1));

void setup() {
  noSmooth();
  size(1100, 700);
  gameBoard = new GameBoard(30);
  imageMode(CENTER);
  // Loading images
  forest = loadImage("forest.png");
  grassHex = loadImage("BaseTileHex.png");
  lakeHex = loadImage("LakeHex.png");
  barn = loadImage("barn.png");
  newFarm = loadImage("NewFarm.png");
  grownFarm = loadImage("GrownFarm.png");
  newTomato = loadImage("NewTomato.png");
  grownTomato = loadImage("GrownTomato.png");
  newCabbage = loadImage("NewCabbage.png");
  grownCabbage = loadImage("GrownCabbage.png");
  background = loadImage("SeaBackgroundCool.jpg");
  startScreen = loadImage("GameStart.png");
  windmillBase = loadImage("WindmillBase.png");
  bakery = loadImage("Bakery.png");
  smelter = loadImage("Smelter.png");
  house = loadImage("House.png");
  mountainHex = loadImage("Mountain.png");
  straightRiver = loadImage("StraightRiver.png");
  curvedRiver = loadImage("CurvedRiver.png");
  lumbermill = loadImage("LumberYard.png");
  mine = loadImage("Mine.png");
  straightRoad = loadImage("StraightRoad.png");
  curvedRoad = loadImage("CurvedRoad.png");
  road3 = loadImage("3Road.png");
 for (int i = 1; i < 9; i++){
    windmillFrames.add(loadImage("WindmillFrame" + i + ".png"));
  }
  for (int i = 1; i < 17; i++){
    oldMillFrames.add(loadImage("OldMill" + i + ".png"));
  }
  oldMillBackground = loadImage("OldMillBackground.png");
  beachEdgeLeft = loadImage("beachEdgeLeft.png");
  beachEdgeRight = loadImage("beachEdgeRight.png");
  beachCenterLeft = loadImage("beachCenterLeft.png");
  beachCenterRight = loadImage("beachCenterRight.png");
  goldCounter = loadImage("MoneyCounter.png");
  powerCounter = loadImage("PowerCounter.png");
  wheatCounter = loadImage("wheatCounter.png");
  counterMenu = loadImage("CounterMenu.png");
  tileMenu = loadImage("ContainerImageBetter.png");
  tileSelector = loadImage("TileSelector.png");
  wheatImage = loadImage("wheat.png");
  samwhichImage = loadImage("Samwhich.png");
  samwhichCounter = loadImage("SamwhichCounter.png");
  woodCounter = loadImage("WoodCounter.png");
  stoneCounter = loadImage("StoneCounter.png");
  ironOreCounter = loadImage("IronOreCounter.png");
  coalCounter = loadImage("CoalCounter.png");
  ironCounter = loadImage("IronCounter.png");
}
void draw() {
  if (startScreenState == true) { // Start Screen
    image(startScreen, 550, 350, 1100, 700);
  }
  if (startScreenState == false) { // Main Game Loop
    animationFrame++;
    mouseLocation();
    for (Hex k : gameBoard.board.keySet()) {
      gameBoard.board.get(k).onTick();
    }
    lastMouseX = mouseX;
    lastMouseY = mouseY;
    drawBackground();
    push();
   // scale(screenZoom);
    translate(screenScrollX, screenScrollY);
    
    gameBoard.drawBoard();
    if (container.hex.q == container.hex.r && container.hex.r == container.hex.s){
    container.drawContainer();
    }
    pop();
    particleAnimations();
    drawUI();
    //println(pixelToCubic(new PVector(mouseX - screenScrollX*2, mouseY - screenScrollY*2)));
  }
}
void drawBackground() {
  image(background, 550, 350, 1100, 700);
}

Hex pixelToCubic(PVector loc) { // Converts x y coordinates into cubic (q, r, s)
  float x = ( loc.x - centerX + screenScrollX) / (tileDistance * screenZoom);
  float y = (loc.y - centerY + screenScrollY)/ (tileDistance * screenZoom);

  float q =  (sqrt(3)/3 * x  -  1./3 * y);
  float r =  (                  2./3 * y);
  return cubicRound(q, r, -q-r);
}
Hex cubicRound(float fracQ, float fracR, float fracS) { // Rounds cubic coordinats from float inputs
    int q = round(fracQ);
    int r = round(fracR);
    int s = round(fracS);

    float q_diff = abs(q - fracQ);
    float r_diff = abs(r - fracR);
    float s_diff = abs(s - fracS);

    if (q_diff > r_diff && q_diff > s_diff) {
        q = -r-s;
    }  else if (r_diff > s_diff) {
        r = -q-s;
    } else {
        s = -q-r;
    }
    return new Hex(q, r, s);
}
