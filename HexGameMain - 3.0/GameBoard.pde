import java.util.HashMap; //<>//
import java.util.Objects;
int landSize = 50;

public class GameBoard { // Gameboard class
  HashMap <Hex, Hex> board;
  int boardSize;
  public void drawBoard() {

// This loops through all tiles and draws them
    for (int q = -boardSize; q <= boardSize; q++) {
      for (int r = -boardSize; r <= boardSize; r++) {
        for (int s = -boardSize; s <= boardSize; s++) {
          if (q+r+s == 0) {
            //This is the access value
            Hex key = new Hex(q, r, s);
            //This is the game tile stored
            Hex val = board.get(key);
            val.drawHex();
          }
        }
      }
    }
  }

  public Hex getHex(int q, int r, int s) { // Returns hex with these coordinates
    return board.get(new Hex(q, r, s));
  }
  public void setHex(Hex h) { // Sets a new hex (not for replacing hexes)
    board.put(h, h);
  }


  public GameBoard(int boardSize) { // Gameboard constructor
    this.boardSize = boardSize;
    board = new HashMap();

    for (int q = -boardSize; q <= boardSize; q++) {
      for (int r = -boardSize; r <= boardSize; r++) {
        for (int s = -boardSize; s <= boardSize; s++) { // Loops through all possible tiles and fills them with sea
          if (q+r+s == 0 ) {
            Hex key = new Hex(q, r, s);
            Hex val;

            val = new SeaHex(q, r, s);
            //}
            board.put(key, val);
          }
        }
      }
    }

    float scaleX = 0.5;
    float scaleY = 0.1;
    noiseDetail(15, 0.01);
    
    for (int q = -landSize; q <= landSize; q++) {
      for (int r = -landSize; r <= landSize; r++) {
        for (int s = -landSize; s <= landSize; s++) {
          if (q + r + s == 0) {
            PVector loc = (new Hex(q, r, s)).cubicToPixel();
            float noise = 2* noise(loc.x * scaleX, loc.y * scaleY);
            Hex v;
            if (noise <= 0.7) {
              v = new SeaHex(q, r, s);
            } else if (noise <= 0.9) {
              v = new GrassHex(q, r, s);
            } else {
              v = new MountainHex(q, r, s);
            }

            board.put(v, v);

          }
        }
      }
    }

    for (int q = -landSize; q <= landSize; q++) {
      for (int r = -landSize; r <= landSize; r++) {
        for (int s = -landSize; s <= landSize; s++) {
          if (q + r + s == 0) {
            int landNeighbors = 0;
            Hex v = new GrassHex(q, r, s);
            if (abs(q) < boardSize - 1 && abs(r) < boardSize - 1 &&  abs(s) < boardSize - 1) {
              for (int i = 0; i < 6; i++) {
                if (neighbor(v, neighborDirections[i]).getType() != HexType.SEA)
                  landNeighbors++;
              }
              if (landNeighbors > 3) {
                replaceHex(v, v);
              }
            }
          }
        }
      }
    }
    replaceSeaEdges();
    replaceLandEdges();
    replaceLandEdges();
    replaceSeaEdges();
    replaceSeaEdges();
    //mountainChains();
    for (int q = -landSize; q <= landSize; q++) {
      for (int r = -landSize; r <= landSize; r++) {
        for (int s = -landSize; s <= landSize; s++) {
          if (q+r+s == 0) {
            if (board.get(new Hex(q, r, s)).getType() == HexType.GRASS) {
              Hex key = new Hex(q, r, s);
              Hex val;
              if (Math.random() > 1 - lakeChance) {
                val = new LakeHex(q, r, s);
              } else {
                val = new GrassHex(q, r, s);
              }
              if (Math.random() > 1- forestChance) {
                val = new ForestHex(q, r, s);
              }
              board.put(key, val);
            }
          }
        }
      }
    }
    replaceForestEdges();
    for (Hex k : board.keySet()) {
      if (board.get(k) != null)
        board.get(k).seaNeigbors(this);
    }
    replaceHex(new Hex(0, 0, 0), new HouseHex(0, 0, 0));
  }
  public void replaceHex(Hex k, Hex v) {

    board.get(k).onRemove();
    v.seaNeigbors(this);
    //for (int i = 0; i < 6; i++)
    //  print(v.beaches[i] + " ");
    //println();
    setHex(v);
    for (int i = 0; i < 6; i++) {
      PVector neighbor = (new PVector(board.get(k).q, board.get(k).r, board.get(k).s)).add(neighborDirections[i]);
      Hex h = new NewFarmHex((int) neighbor.x, (int) neighbor.y, (int) neighbor.z);
      board.get(h).seaNeigbors(this);
    }
  }
  public Hex neighbor(Hex hex, PVector direction) {
    return board.get(new Hex (hex.q + (int) direction.x, hex.r + (int) direction.y, hex.s + (int) direction.z));
  }
  public Hex get(Hex hex) {
    return board.get(hex);
  }
  void replaceSeaEdges() {
    ArrayList<GrassHex> edges = new ArrayList<>();
    for (int q = -landSize; q <= landSize; q++) {
      for (int r = -landSize; r <= landSize; r++) {
        for (int s = -landSize; s <= landSize; s++) {
          if (q + r + s == 0 && board.get(new Hex(q, r, s)).getType() != HexType.SEA) {
            Hex v = new GrassHex(q, r, s);
            if (abs(q) < boardSize - 1 && abs(r) < boardSize - 1 &&  abs(s) < boardSize - 1) {
              for (int i = 0; i < 6; i++) {
                if (neighbor(v, neighborDirections[i]).getType() == HexType.SEA)
                  edges.add(new GrassHex( q + (int) neighborDirections[i].x, r + (int) neighborDirections[i].y, s + (int) neighborDirections[i].z));
              }
            }
          }
        }
      }
    }
    for (int i = 0; i < edges.size(); i++) {
      replaceHex(edges.get(i), edges.get(i));
    }
  }

  void replaceLandEdges() {
    ArrayList<SeaHex> edges = new ArrayList<>();
    for (int q = -landSize; q <= landSize; q++) {
      for (int r = -landSize; r <= landSize; r++) {
        for (int s = -landSize; s <= landSize; s++) {
          if (q + r + s == 0 && board.get(new Hex(q, r, s)).getType() != HexType.GRASS) {
            Hex v = new SeaHex(q, r, s);
            if (abs(q) < boardSize - 1 && abs(r) < boardSize - 1 &&  abs(s) < boardSize - 1) {
              for (int i = 0; i < 6; i++) {
                if (neighbor(v, neighborDirections[i]).getType() == HexType.GRASS)
                  edges.add(new SeaHex( q + (int) neighborDirections[i].x, r + (int) neighborDirections[i].y, s + (int) neighborDirections[i].z));
              }
            }
          }
        }
      }
    }
    for (int i = 0; i < edges.size(); i++) {
      replaceHex(edges.get(i), edges.get(i));
    }
  }
  void replaceForestEdges() {
    ArrayList<ForestHex> edges = new ArrayList<>();
    for (int q = -landSize; q <= landSize; q++) {
      for (int r = -landSize; r <= landSize; r++) {
        for (int s = -landSize; s <= landSize; s++) {
          if (q + r + s == 0 && board.get(new Hex(q, r, s)).getType() == HexType.FOREST) {
            Hex v = new ForestHex(q, r, s);
            if (abs(q) < boardSize - 1 && abs(r) < boardSize - 1 &&  abs(s) < boardSize - 1) {
              for (int i = 0; i < 6; i++) {
                if (neighbor(v, neighborDirections[i]).getType() == HexType.GRASS && Math.random() > 0.5){
                  edges.add(new ForestHex( q + (int) neighborDirections[i].x, r + (int) neighborDirections[i].y, s + (int) neighborDirections[i].z));
                }
              }
            }
          }
        }
      }
    }
    for (int i = 0; i < edges.size(); i++) {
      replaceHex(edges.get(i), edges.get(i));
    }
  }  
  //void mountainChains() {
  //  ArrayList<MountainHex> mountains = new ArrayList<>();
  //  for (int q = -landSize; q <= landSize; q++) {
  //    for (int r = -landSize; r <= landSize; r++) {
  //      for (int s = -landSize; s <= landSize; s++) {
  //        if (q + r + s == 0 && board.get(new Hex(q, r, s)).getType() == HexType.MOUNTAIN) {
  //          Hex v = new MountainHex(q, r, s);
  //          if (abs(q) < boardSize - 1 && abs(r) < boardSize - 1 &&  abs(s) < boardSize - 1) {
  //            for (int i = 0; i < 6; i++) {
  //              if (neighbor(v, neighborDirections[i]).getType() == HexType.GRASS && Math.random() > 0.5 && tilesInArea(neighbor(v, neighborDirections[i]), 2) <= 3){
  //                boolean placing = true;
  //                MountainHex mainNeighbor = new MountainHex( q + (int) neighborDirections[i].x, r + (int) neighborDirections[i].y, s + (int) neighborDirections[i].z);
  //                for (int j = 0; j < 6; j++) {
  //                  Hex n = new MountainHex( mainNeighbor.q + (int) neighborDirections[j].x, mainNeighbor.r + (int) neighborDirections[j].y, mainNeighbor.s + (int) neighborDirections[j].z);
  //                  if (tilesInArea(neighbor(n, neighborDirections[i]), 2) <= 3)
  //                    placing = false;
  //                }
  //                if (placing) {
  //                mountains.add(mainNeighbor);
  //                }
  //              }
  //            }
  //          }
  //        }
  //      }
  //    }
  //  }
  //  for (int i = 0; i < mountains.size(); i++) {
  //    replaceHex(mountains.get(i), mountains.get(i));
  //  }  
  //}  
  public int tilesInArea(Hex type, int range) {
    int count = 0;
    for (int q = type.q-range; q < type.q + range; q++) {
      for (int r = type.r-range; r < type.r + range; r++) {
        for (int s = type.s-range; s < type.s + range; s++) {
          if (q + r + s == 0) {
          if (gameBoard.get(new Hex(q, r, s)).getType().equals(type.getType())) {
            count++;
            }
          }
        }
      }
    }
    return count;
  }
}
  
