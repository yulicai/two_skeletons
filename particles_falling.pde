boolean falling = false;

//function for checking if dancer is under every circle
void checkUnderCircle() {


  //loop through every joint
  for (int i = 0; i < currentJoints.size(); i++) {

    //loop through every ellipse
    for (int j = 0; j < circlesInfo.size(); j++) {

      // circleInfo(lastClick.x, lastClick.y, lastRadius);
      //we convert(scale, rotate) the original location in to the normal one
      float currentJointLoc_Y = height-(currentJoints.get(i).y*kinectScaling+height/2);
      float currentJointLoc_X = width-(currentJoints.get(i).x*kinectScaling+width/2);
      //check if joint is under the ellipse
      //check first in the y axis
      if (currentJointLoc_Y > circlesInfo.get(j).y) {

        //check if it is in the x axis
        if ((currentJointLoc_X>=(circlesInfo.get(j).x-ellipseRatio*circlesInfo.get(j).z)) && 
          (currentJointLoc_X<=(circlesInfo.get(j).x+ellipseRatio*circlesInfo.get(j).z) )) {

          //println("im under");
          addParticles(trailingJointPositions.get(i), 0.00002, i%5);
        } else {
          println("im not under");
        }
      }
    }
  }
}



//index will be the direction of which pattern to be drew, eg. index=1, draw ellipse
//float gravity will be around 0.00003
//void drawParticles(PVector trailingJointPosition, int index, float gravity) {
void addParticles(PVector trailingJointPosition, float gravity, int _type) {
  //set where the particles are going to fall
  int type = _type;
  ps.origin.set(trailingJointPosition.x, trailingJointPosition.y, 0);
  PVector addOri = new PVector(trailingJointPosition.x, trailingJointPosition.y, 0);

  //assign gravity to different particle systems
  PVector g = new PVector(0, -gravity, 0);
  ps.addParticle(addOri, g, type);
  //ps.run(index);   

  //println(trail.size());
}

void displayParticles() {
  ps.particles.size();
  ps.run();
}