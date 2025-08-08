public class Container{ // Not used
  float x;
  float y;
  Hex hex;
  public Container(Hex hex){
    if (hex.q != hex.r && hex.r != hex.s){
      x = hex.cubicToPixel().x;
      y = hex.cubicToPixel().y;
    }
    this.hex = hex;
    }
  void drawContainer(){
    if (hex.q != hex.r && hex.r != hex.s) {
      imageMode(CENTER);
      image(tileMenu, x, y, 170, 262);
      textSize(20);
      fill(255);
      text(hex.getType().toString(), x - 50 + screenScrollX, y - 80 + screenScrollY);    
      circle(x, y, 10);
      circle(x - 55, y + 103, 50);
    }
  }
  void reset(Hex hex) {
    if (hex.q != hex.r && hex.r != hex.s){
      x = hex.cubicToPixel().x;
      y = hex.cubicToPixel().y;
    }
    this.hex = hex;
  }
  void remove(){
    hex = new Hex(2, 2, 2);
  }
}
public class Content{
  
  public Content(){
  
  }
}
