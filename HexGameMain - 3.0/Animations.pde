void drawWindmillAnimation(PVector loc) { //Animations for modern windmill
  for (int i = 0; i < 8; i++) {
    if (animationFrame%8==i) {
      image(windmillFrames.get(i), loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    }
  }
}
void drawOldMillAnimation(PVector loc) { //Animations for old windmill
  for (int i = 0; i < 16; i++) {
    if (animationFrame%16==i) {
      image(oldMillFrames.get(i), loc.x, loc.y, 113 * screenZoom, 130 * screenZoom);
    } 
  }
}
void particleAnimations() { //Calls Particle and draws particles
  Iterator<Particle> iter = particles.iterator();
  while (iter.hasNext()) {
    Particle p = iter.next();
    if (p.lifeTime > 60)
      iter.remove();
    else {
      p.moveParticle();
      p.drawParticle();
    }
  }
//void 
}
