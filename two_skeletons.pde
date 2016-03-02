//two_skeletons //<>//
//by adam dyer, yuli cai, aaron montoya
//for the choreographic interventions class
//taught by mimi yin at nyu tisch
//february 2016
//Use PC and Kinect V2


//declaration of global variables
//variables for size of canvas
int widthCanvas;
int heightCanvas;

//declaration of particle system
Particle_system ps;

PShader blur;

//setup of the system
void setup () {

  //set the size of the canvas  
  widthCanvas = 1024;
  heightCanvas = 768;

  //define the canvas size and define a 3D space
  //set the projector resolution to Auto
   size (1024, 768, P3D);

  //change it to msi screen resolution
 // size (1920, 1080, P3D);
  blur = loadShader("blur.glsl");
  //black background
  background (0);

  //setup variables for circle drawing
  setupCircles();

  //setup kinect for tracking 2 skeletons
  setupKinect();

  //setup new particle system
  //arguments are original position (x,y,z)
  ps = new Particle_system(new PVector(0, 0, 0));
}

//draw loop
void draw () {

  //redraw background
  background(0);
  filter(blur);

  //update info of circles drawn by mouse
  updateCircles();

  //draw current circles
  drawCircles();




  //update skeleton position
  updateKinectSkeletons();

  drawConnectionLine();

  //draw the particles
  // drawParticles();
  if ( ps.particles.size()>0) {
    ps.run();
  }
  checkUnderCircle();
}

void mouseReleased() {
  appendNewCircle();
}