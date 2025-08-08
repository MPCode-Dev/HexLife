public class Particle{
float x;
float y;
float tileX;
float tileY;
HexType type;
int lifeTime = 0;
float vX = 1;
float vY = 1;
  public Particle(float tileX, float tileY, HexType type){
  this.x = random(-10, 10);
  this.y = random(-10, 10);
  this.tileX = tileX;
  this.tileY = tileY;
  this.type = type;
  vX *= random(-10, 10);
  vY *= random(-30, -50);
  }
  void moveParticle(){
    vY += 2;
    x += vX;
    y += vY;
    lifeTime++;
  }
  void drawParticle(){
     push();
     translate(tileX + screenScrollX, tileY + screenScrollY);
     circle(0,0,10);
   if (type == HexType.NEWFARM)
      image(wheatImage, x, y, 18 * screenZoom, 18 * screenZoom);   
   if (type == HexType.BAKERY)
      image(samwhichImage, x , y, 18 * screenZoom, 18 * screenZoom);   
      pop();
  }
}
