boolean mouseOnUI = false;
public void mouseLocation(){
  if (mouseCollides(100, 600, 900, 100) && buildMenu == true) {
    mouseOnUI = true;
  } else if (mouseCollides(500, 600, 100, 100) && buildMenu == false) {
    mouseOnUI = true;
  //} else if (mouseCollides(Container.x - 85, Container.y - 131, 170, 262)) {
  } else {mouseOnUI = false;}
}
void mouseClicked(){
  //println(mouseX + " " + mouseY);
  if (mouseCollides(260, 370, 600, 160) && startScreenState == true) {startScreenState = false;}
  if (mouseButton == RIGHT) {
    container.reset(gameBoard.board.get(pixelToCubic(new PVector(mouseX + 2*-screenScrollX, mouseY + 2*-screenScrollY))));
  }
  if (mouseButton == LEFT) {
    if (mouseCollides(100, 600, 900, 100) && buildMenu == false) {
      buildMenu = true;
    }
    if (mouseCollides(100 + menuScroll, 600, 100, 100)) {
      tileSelected = 1;
    } else if (mouseCollides(200 + menuScroll, 600, 100, 100)) {
      tileSelected = 3;
    } else if (mouseCollides(300 + menuScroll, 600, 100, 100)) {
      tileSelected = 4;
    } else if (mouseCollides(400 + menuScroll, 600, 100, 100)) {
      tileSelected = 5;
    } else if (mouseCollides(500 + menuScroll, 600, 100, 100)) {
      tileSelected = 7;
    } else if (mouseCollides(600 + menuScroll, 600, 100, 100)) {
      tileSelected = 8;
    } else if (mouseCollides(700 + menuScroll, 600, 100, 100)) {
      tileSelected = 6;
    } else if (mouseCollides(800 + menuScroll, 600, 100, 100)) {
      tileSelected = 9;
    } else if (mouseCollides(900 + menuScroll, 600, 100, 100)) {
      tileSelected = 10;
    } else if (mouseCollides(1000 + menuScroll, 600, 100, 100)) {
      tileSelected = 11;
    } else if (mouseCollides(1100 + menuScroll, 600, 100, 100)) {
      tileSelected = 12;
    } else if (mouseCollides(1200 + menuScroll, 600, 100, 100)) {
      tileSelected = 13;
    }
      for (Hex k : gameBoard.board.keySet()) {
        PVector mouseLoc = new PVector(mouseX - screenScrollX*2, mouseY - screenScrollY*2);
        //println(pixelToCubic(mouseLoc ) + " and " + k);
        Hex current = new Hex(pixelToCubic(mouseLoc).q, pixelToCubic(mouseLoc).r, pixelToCubic(mouseLoc).s);
        
        if (!mouseOnUI && current.equals(k) && !(gameBoard.get(current).getType() == (HexType.MOUNTAIN))) {
          
          if (gameBoard.get(current).getType() == HexType.SEA && gold >= 100){
            gold -= 100;
            if (tileSelected == 1) {
            gameBoard.replaceHex(k, new GrassHex(k.q, k.r, k.s));
          } else if (tileSelected == 2) {
            gameBoard.replaceHex(k, new LakeHex(k.q, k.r, k.s));
          } else if (tileSelected == 3 && gold >= 10 && gameBoard.tilesInArea(new LakeHex(current.q, current.r, current.s), 2) > 0) {
            gameBoard.replaceHex(k, new NewFarmHex(k.q, k.r, k.s));
            gold -= 10;
          } else if (tileSelected == 4 && gold >= 20 && stone >= 10 && wood >= 5) {
            gameBoard.replaceHex(k, new BakeryHex(k.q, k.r, k.s));
            gold -= 20;
          } else if (tileSelected == 5 && gold >= 20) {
            gameBoard.replaceHex(k, new BarnHex(k.q, k.r, k.s));
            gold -= 20;
          } else if (tileSelected == 6 && gold >= 30) {
            gameBoard.replaceHex(k, new WindmillHex(k.q, k.r, k.s));
            gold -= 30;
          } else if (tileSelected == 7) {
            gameBoard.replaceHex(k, new HouseHex(k.q, k.r, k.s));
          } else if (tileSelected == 8 && gold >= 20) {
            gameBoard.replaceHex(k, new OldMillHex(k.q, k.r, k.s));
            gold -= 20;
          }  else if (tileSelected == 9 && gold >= 20 && current.getType() == HexType.FOREST ) {
            gameBoard.replaceHex(k, new LumbermillHex(k.q, k.r, k.s));
            gold -= 20;
          } else if (tileSelected == 10 && gold >= 20 && gameBoard.tilesInArea(new MountainHex(current.q, current.r, current.s), 2) > 0) {
            gameBoard.replaceHex(k, new MineHex(k.q, k.r, k.s));
            gold -= 20;
          } else if (tileSelected == 11 && gold >= 10 && gameBoard.tilesInArea(new LakeHex(current.q, current.r, current.s), 2) > 0) {
            gameBoard.replaceHex(k, new NewTomatoHex(k.q, k.r, k.s));
            gold -= 10;     
          }  else if (tileSelected == 12 && gold >= 10 && gameBoard.tilesInArea(new LakeHex(current.q, current.r, current.s), 2) > 0) {
            gameBoard.replaceHex(k, new NewCabbageHex(k.q, k.r, k.s));
            gold -= 10;
          }  else if (tileSelected == 13 && gold >= 20 && stone >= 20 && wood >= 5 && ironOre >= 10) {
            gameBoard.replaceHex(k, new SmelterHex(k.q, k.r, k.s));
            gold -= 20;
          } 
          }  else if (!mouseOnUI && !(gameBoard.get(current).getType().equals(HexType.SEA))){
          if (tileSelected == 1) {
            gameBoard.replaceHex(k, new GrassHex(k.q, k.r, k.s));
          } else if (tileSelected == 2) {
            gameBoard.replaceHex(k, new LakeHex(k.q, k.r, k.s));
          } else if (tileSelected == 3 && gold >= 10 && gameBoard.tilesInArea(new LakeHex(current.q, current.r, current.s), 3) > 0) {
            gameBoard.replaceHex(k, new NewFarmHex(k.q, k.r, k.s));
            gold -= 10;
          } else if (tileSelected == 4 && gold >= 20 && stone >= 10 && wood >= 5) {
            gameBoard.replaceHex(k, new BakeryHex(k.q, k.r, k.s));
            gold -= 20;
          } else if (tileSelected == 5 && gold >= 20 && stone >= 5 && wood >= 10) {
            gameBoard.replaceHex(k, new BarnHex(k.q, k.r, k.s));
            gold -= 20;
          } else if (tileSelected == 6 && gold >= 30) {
            gameBoard.replaceHex(k, new WindmillHex(k.q, k.r, k.s));
            gold -= 30;
          } else if (tileSelected == 7) {
            gameBoard.replaceHex(k, new HouseHex(k.q, k.r, k.s));
          } else if (tileSelected == 8 && gold >= 20) {
            gameBoard.replaceHex(k, new OldMillHex(k.q, k.r, k.s));
            gold -= 20;
          }  else if (tileSelected == 9 && gold >= 20 && gameBoard.board.get(current).getType() == HexType.FOREST ) {
            gameBoard.replaceHex(k, new LumbermillHex(k.q, k.r, k.s));
            gold -= 20;
          } else if (tileSelected == 10 && gold >= 20 && gameBoard.tilesInArea(new MountainHex(current.q, current.r, current.s), 2) > 0) {
            gameBoard.replaceHex(k, new MineHex(k.q, k.r, k.s));
            gold -= 20;
          } else if (tileSelected == 11 && gold >= 10 && gameBoard.tilesInArea(new LakeHex(current.q, current.r, current.s), 2) > 0) {
            gameBoard.replaceHex(k, new NewTomatoHex(k.q, k.r, k.s));
            gold -= 10;     
          }  else if (tileSelected == 12 && gold >= 10 && gameBoard.tilesInArea(new LakeHex(current.q, current.r, current.s), 2) > 0) {
            gameBoard.replaceHex(k, new NewCabbageHex(k.q, k.r, k.s));
            gold -= 10;
          }  else if (tileSelected == 13 && gold >= 20 && stone >= 20 && wood >= 5 && ironOre >= 10) {
            gameBoard.replaceHex(k, new SmelterHex(k.q, k.r, k.s));
            gold -= 20;
          }        
          if (tileSelected == 0 && gameBoard.board.get(k).getType() == HexType.GROWNFARM) {
            gameBoard.replaceHex(k, new NewFarmHex(k.q, k.r, k.s));
          }
          if (tileSelected == 0 && gameBoard.board.get(k).getType() == HexType.GROWNTOMATO) {
            gameBoard.replaceHex(k, new NewTomatoHex(k.q, k.r, k.s));
          }
          if (tileSelected == 0 && gameBoard.board.get(k).getType() == HexType.GROWNCABBAGE) {
            gameBoard.replaceHex(k, new NewCabbageHex(k.q, k.r, k.s));
          }
        }
      }
    }
  }
}
void mouseDragged(){
  if (mouseButton == LEFT && startScreenState == false) {
  screenScrollX += (mouseX - lastMouseX)/3;
  screenScrollY += (mouseY - lastMouseY)/3;
  }
}
void keyPressed(){
  
  if (key == '0') {tileSelected = 0; buildMenu = false;}
  if (key == '1') {tileSelected = 1;}
  if (key == '2') {tileSelected = 2;}
  if (key == '3') {tileSelected = 3;}
  if (key == '4') {tileSelected = 4;}
  if (key == '5') {tileSelected = 5;}
  if (key == '6') {tileSelected = 6;}
  if (key == '7') {tileSelected = 7;}
  if (key == '8') {tileSelected = 8;}
  if (key == '9') {tileSelected = 9;}
}
void keyReleased(){}

void mouseWheel(MouseEvent event) {
  if (!mouseOnUI)
  screenZoom *= (event.getCount() > 0 ? 1.2 : 0.8);
  //tileDistance += (screenZoom) ;
  if (mouseOnUI)
  menuScroll += (event.getCount() > 0 ? 1 : -1) * 20;
  
  //screenScrollX += mouseX - lastMouseX;
  //screenScrollY += mouseY - lastMouseY;
  if (screenZoom < 0.2) {
    screenZoom = 0.2;
  }
  if (screenZoom > 4) {
    screenZoom = 4;
  }
}
boolean mouseCollides(float x, float y, float width, float height){
  return (mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height);
}
