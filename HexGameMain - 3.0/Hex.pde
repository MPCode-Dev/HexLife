public class Hex {
  boolean[] beaches = {false, false, false, false, false, false};
  int age = 0;
  int q;
  int r;
  int s;
  public Hex(int q, int r, int s) {
    this.q = q;
    this.r = r;
    this.s = s;
  }

  @Override
    public int hashCode() {
    return Objects.hash(q, r, s);
  }
  @Override
    public boolean equals(Object o) {
    if (o == null) return false;
    if (o instanceof Hex) {
      Hex h = (Hex) o;
      return this.q == h.q && this.r == h.r && this.s == h.s;
    }
    return false;
  }

  PVector cubicToPixel() {
    float x = sqrt(3) * q  +  sqrt(3)/2 * r;
    float y = 3./2 * r;
    x = x * tileDistance * screenZoom + centerX;
    y = y * tileDistance * screenZoom + centerY;
    return new PVector(x, y);
  }

  void drawHex() {
    PVector loc = cubicToPixel();
    //circle(loc.x + screenScrollX, loc.y + screenScrollY, 64);
    for (int i = 0; i < 6; i++) {


      if (beaches[i] && beaches[(i - 1) == -1 ? 5 : i - 1]) {
        push();
        translate(loc.x, loc.y);
        rotate(radians(i*60));
        image(beachCenterLeft, 0, 0, 113 * screenZoom, 130 * screenZoom);
        pop();
      } if (beaches[i] && !beaches[i == 0 ? 5 : i -1]) {
        push();
        translate(loc.x, loc.y);
        rotate(radians(i * 60));
        image(beachEdgeRight, 0, 0, 113 * screenZoom, 130 * screenZoom);
        pop();
      }
      if (beaches[i] && beaches[(i+1)%6]) {
        push();
        translate(loc.x, loc.y);
        rotate(radians(i*60));
        image(beachCenterRight, 0, 0, 113 * screenZoom, 130 * screenZoom);
        pop();
      } if (beaches[i] && !beaches[(i+1)%6]) {
        push();
        translate(loc.x, loc.y);
        rotate(radians( i * 60  ));
        image(beachEdgeLeft, 0, 0, 113 * screenZoom, 130 * screenZoom);
        pop();
      }
    }
  }//fhebgeuingrerhakjgaeg ian more like I am ooooh! I could work on code or I could be writing this right now it looks like I'm coding because I am writing on the keyboard
  String toString() {
    return q + " " + r + " " + s + " ";
  }

  public HexType getType() {
    return HexType.NONE;
  }

  void onTick() {
    age++;
  }

  public void seaNeigbors(GameBoard board) {
    //println(this);
    for (int i = 0; i < 6; i++) {
      if (board.get(board.neighbor(this, neighborDirections[i])) instanceof SeaHex || board.get(board.neighbor(this, neighborDirections[i])) == null)
        beaches[i] = true;
      else
        beaches[i] = false;
    }



    //if (board.get(board.neighbor(this, new PVector(1, 0, -1))) instanceof SeaHex || board.get(board.neighbor(this, new PVector(1, 0, -1))) == null)
    //  beaches[1] = true;


    //if (board.get(board.neighbor(this, new PVector(0, 1, -1))) instanceof SeaHex || board.get(board.neighbor(this, new PVector(0, 1, -1))) == null)
    //  beaches[2] = true;

    //if (board.get(board.neighbor(this, new PVector(-1, +1, 0))) instanceof SeaHex || board.get(board.neighbor(this, new PVector(-1, +1, 0))) == null)
    //  beaches[3] = true;

    //if (board.get(board.neighbor(this, new PVector(-1, 0, +1))) instanceof SeaHex || board.get(board.neighbor(this, new PVector(-1, 0, +1))) == null)
    //  beaches[4] = true;

    //if (board.get(board.neighbor(this, new PVector(0, -1, +1))) instanceof SeaHex || board.get(board.neighbor(this, new PVector(0, -1, +1))) == null)
    //  beaches[5] = true;

    //for (int i = 0; i < beaches.length; i++) {
    //  print (beaches[i] + " ");
    //}
  }

  void onRemove() {
  }
}

public class GrassHex extends Hex {

  public GrassHex(int q, int r, int s) {
    super(q, r, s);
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(grassHex, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.GRASS;
  }

  void onRemove() {
  }
}
public class MountainHex extends Hex {

  public MountainHex(int q, int r, int s) {
    super(q, r, s);
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(mountainHex, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
  }
  @Override
    public HexType getType() {
    return HexType.MOUNTAIN;
  }

  void onRemove() {
  }
}

public class LakeHex extends Hex {

  public LakeHex(int q, int r, int s) {
    super(q, r, s);
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(lakeHex, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  public HexType getType() {
    return HexType.LAKE;
  }
  void onRemove() {
  }
}
public class NewFarmHex extends Hex {
  int grownAge = (int) random(6, 10);
  public NewFarmHex(int q, int r, int s) {
    super(q, r, s);
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(newFarm, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.NEWFARM;
  }
  void onTick() {
    super.onTick();
    if (age > grownAge*30)
      gameBoard.replaceHex(this, new GrownFarmHex(q, r, s));
  }
  void onRemove() {
  }
}

public class GrownFarmHex extends Hex {

  public GrownFarmHex(int q, int r, int s) {
    super(q, r, s);
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(grownFarm, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.GROWNFARM;
  }
  void onRemove() {
    for (int i = 0; i < 6; i++) {
      particles.add(new Particle( cubicToPixel().x, cubicToPixel().y, HexType.NEWFARM));
    }
    wheat += 10;
  }
}
public class NewTomatoHex extends Hex {
  int grownAge = (int) random(4, 7);
  public NewTomatoHex(int q, int r, int s) {
    super(q, r, s);
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(newTomato, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.NEWTOMATO;
  }
  void onTick() {
    super.onTick();
    if (age > grownAge*30)
      gameBoard.replaceHex(this, new GrownTomatoHex(q, r, s));
  }
  void onRemove() {
  }
}

public class GrownTomatoHex extends Hex {

  public GrownTomatoHex(int q, int r, int s) {
    super(q, r, s);
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(grownTomato, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.GROWNTOMATO;
  }
  void onRemove() {
    for (int i = 0; i < 6; i++) {
      particles.add(new Particle( cubicToPixel().x, cubicToPixel().y, HexType.NEWFARM));
    }
    wheat += 20;
  }
}
public class NewCabbageHex extends Hex {
  int grownAge = (int) random(5, 8);
  public NewCabbageHex(int q, int r, int s) {
    super(q, r, s);
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(newCabbage, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.NEWCABBAGE;
  }
  void onTick() {
    super.onTick();
    if (age > grownAge*30)
      gameBoard.replaceHex(this, new GrownCabbageHex(q, r, s));
  }
  void onRemove() {
  }
}

public class GrownCabbageHex extends Hex {

  public GrownCabbageHex(int q, int r, int s) {
    super(q, r, s);
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(grownCabbage, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.GROWNCABBAGE;
  }
  void onRemove() {
    for (int i = 0; i < 6; i++) {
      particles.add(new Particle( cubicToPixel().x, cubicToPixel().y, HexType.NEWFARM));
    }
    wheat += 50;
  }
}
public class BarnHex extends Hex {

  public BarnHex(int q, int r, int s) {
    super(q, r, s);
    power -= 2;
    wood -= 10;
    stone -= 5;
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(barn, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.BARN;
  }
  void onTick() {
    super.onTick();
    for (int i = 0; i < 6; i++) {
      if (gameBoard.neighbor(this, neighborDirections[i]).getType() == HexType.GROWNFARM && power >= 0) {
        PVector neighbor = (new PVector(q, r, s)).add(neighborDirections[i]);
        Hex h =new NewFarmHex((int) neighbor.x, (int) neighbor.y, (int) neighbor.z);
        gameBoard.replaceHex(h, h);
      }
      if (gameBoard.neighbor(this, neighborDirections[i]).getType() == HexType.GROWNTOMATO && power >= 0) {
        PVector neighbor = (new PVector(q, r, s)).add(neighborDirections[i]);
        Hex h =new NewTomatoHex((int) neighbor.x, (int) neighbor.y, (int) neighbor.z);
        gameBoard.replaceHex(h, h);
      }
      if (gameBoard.neighbor(this, neighborDirections[i]).getType() == HexType.GROWNCABBAGE && power >= 0) {
        PVector neighbor = (new PVector(q, r, s)).add(neighborDirections[i]);
        Hex h =new NewCabbageHex((int) neighbor.x, (int) neighbor.y, (int) neighbor.z);
        gameBoard.replaceHex(h, h);
      }
    }
  }
  void onRemove() {
    power += 2;
  }
}
public class WindmillHex extends Hex {

  public WindmillHex(int q, int r, int s) {
    super(q, r, s);
    power += 30;
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(windmillBase, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
    drawWindmillAnimation(loc);
  }
  @Override
    public HexType getType() {
    return HexType.WINDMILL;
  }
  void onRemove() {
    power -= 30;
  }
}
public class OldMillHex extends Hex {

  public OldMillHex(int q, int r, int s) {
    super(q, r, s);
    power += 15;
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(oldMillBackground, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
    drawOldMillAnimation(loc);
  }
  @Override
    public HexType getType() {
    return HexType.OLDMILL;
  }
  void onRemove() {
    power -= 15;
  }
}

public class SeaHex extends Hex {
  public SeaHex(int q, int r, int s) {
    super(q, r, s);
  }
  void drawHex() {
  }
  @Override
    public HexType getType() {
    return HexType.SEA;
  }
  void onRemove() {
  }
}
public class BakeryHex extends Hex {
  public BakeryHex(int q, int r, int s) {
    super(q, r, s);
    power -= 2;
    wood -= 5;
    stone -= 10;
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(bakery, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.BAKERY;
  }
  void onTick() {
    super.onTick();
    if (wheat >= 5 && age % 10 == 0 && power >= 0) {
      wheat -= 5;
      samwhich += 2;
      particles.add(new Particle( cubicToPixel().x, cubicToPixel().y, HexType.BAKERY));
    }
  }
  void onRemove() {
    power += 2;
  }
}
public class SmelterHex extends Hex {
  public SmelterHex(int q, int r, int s) {
    super(q, r, s);
    power -= 20;
    wood -= 5;
    stone -= 20;
    ironOre -= 10;
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(smelter, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.SMELTER;
  }
  void onTick() {
    super.onTick();
    if (coal >= 1 && ironOre >= 4 && age % 10 == 0 && power >= 0) {
      ironOre -= 4;
      coal--;
      iron += 2;
    }
  }
  void onRemove() {
    power += 10;
  }
}
public class ForestHex extends Hex {
  public ForestHex(int q, int r, int s) {
    super (q, r, s);
  }
  void drawHex() {
    PVector loc = cubicToPixel();
    image(grassHex, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
    image(forest, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
  }
  @Override
    public HexType getType() {
    return HexType.FOREST;
  }
  void onRemove() {
  }
}
public class RoadHex extends Hex {
  int roadNeighbors = 0;
  int roadDirection = 0;
  public RoadHex(int q, int r, int s) {
    super (q, r, s);
    checkNeighbors();
  }
  void checkNeighbors(){
  for(int i = 0; i < 6; i++){
      if (gameBoard.neighbor(this, neighborDirections[i]).getType() == HexType.ROAD){
        roadNeighbors++;
      }
    }
  }
  void drawHex() {
    PVector loc = cubicToPixel();
    image(straightRoad, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.ROAD;
  }
  void onRemove() {
  }
}
//public class RiverHex extends Hex {
//  public RiverHex(int q, int r, int s) {
//    super (q, r, s);
//  }
//  void drawHex() {
//    PVector loc = cubicToPixel();
//    image(grassHex, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
//    super.drawHex();
//    image(forest, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
//  }
//  @Override
//    public HexType getType() {
//    return HexType.FOREST;
//  }
//  void onRemove() {
//  }
//}
public class LumbermillHex extends Hex {
  public LumbermillHex(int q, int r, int s) {
    super (q, r, s);
    power -= 2;
  }
  void drawHex() {
    PVector loc = cubicToPixel();
    image(lumbermill, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.LUMBERMILL;
  }
  void onRemove() {
    power += 2;
  }
  void onTick() {
    super.onTick();
    if (age % 20 == 0 && power >= 0){
      wood++;
    }  
  }
}
public class MineHex extends Hex {
  public MineHex(int q, int r, int s) {
    super (q, r, s);
    power -= 2;
  }
  void drawHex() {
    PVector loc = cubicToPixel();
    image(mine, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.MINE;
  }
  void onRemove() {
    power += 2;
  }
    void onTick() {
    super.onTick();
    if (age % 20 == 0 && power >= 0){
      stone++;
      ironOre++;
      coal++;
    }
  
  }
}
public class HouseHex extends Hex {
  int age = 0;
  public HouseHex(int q, int r, int s) {
    super(q, r, s);
    power -= 10;
  }
  void drawHex() {
    PVector loc = cubicToPixel();

    image(house, loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    super.drawHex();
  }
  @Override
    public HexType getType() {
    return HexType.HOUSE;
  }
  void onTick() {
    super.onTick();
    if (age%10 == 0 && samwhich >= 5 && power >= 0) {
      samwhich -= 5;
      gold += 5;
    }
    if (power >= 0 || samwhich >= 5) {
      //angryParticles
    }
  }

  void onRemove() {
    power += 10;
  }
}
