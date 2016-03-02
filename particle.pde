//definition of the Particle class
class Particle {

  //internal variables of the Particle object
  //PVector loc for storing the current location of the Particle
  PVector loc;
  //PVector for storing the current velocity of the Particle
  PVector vel;
  //PVector for storing the current acceleration of the Particle
  PVector acc;

  //float for storing the current value of the lifespan of the Particle
  //it will control the transparency of the display of the Particle
  //0 means transparent, 255 means opaque
  //based on the Daniel Shifmann's work on Particles
  //example on https://processing.org/examples/simpleparticlesystem.html
  float lifespan;

  int type;


  //constructor method of the Particle class
  //three arguments
  //PVector l stands for location
  //PVector a stands for acceleration
  //float velX stands for the maximum velocity that the particle 
  //can start with on the X axis, ranging between decimal tiny values
  //close to 0.001
  Particle( PVector l, PVector a, float velX, int _type) {
    //set the internal variables of the Particle
    //to the arguments provided by the callback to the method
    loc = l.get();
    acc = a.get();
    type = _type;

    //give a initial velocity to the Particle
    //that is 0 on the Y and Z axis
    //and random between -velX and velX
    vel = new PVector(random(-velX, velX), 0, 0);

    //start it with the maximum value for lifespan
    //so that it starts being totally opaque 
    //and ends when it is transparent and disappears
    lifespan = 255.0;
  }

  //method for drawing the Particle
  //one argument
  //int type decides what kind of particle is drawn
  //void type, so it returns nothing
  void run() {
    //call to the update method, to update its internal values
    //like position and velocity
    update();
    //call to method for actually drawing the Particle
    //on the screen
    display();
  }

  //method for updating the internal variables of Particle
  void update() {
    //add the current velocity value to the position of the Particle
    loc.add(vel);
    //add the current acceleration value to the velocity of the Particle
    vel.add(acc);
    //decrease the lifespan by a random number between 0.9 and 1.9
    lifespan -= 0.9+0.1*random(1);
  }

  //method for displaying the Particle on the screen
  //one argument
  //integer type chooses which type of Particle is 
  //going to be displayed, there are several geometric
  //forms to choose from
  //type void, so it returns nothing
  void display() {
    // stroke(0.001);
    //noStroke();

    //set the fill options, two arguments
    //first argument is grayscale, 255 for white
    //second argument is transparency, lifespan so that is variable
    fill(255, lifespan);

    //save the current frame of reference for 
    //displaying graphics on the screen
    //this allows to save the current state, make changes
    //in another frame of reference, and then return to 
    //the original state with the partner command popMatrix()
    pushMatrix();
    translate(width/2, height/2, 0);
    scale(kinectScaling, kinectScaling, 1);
    rotateX(PI);
    //flip the x positions, so we can perform in between the Kinect and the wall
    rotateY(PI);


    stroke(255);
    strokeWeight(0.01);


    if (type == 0) {
      // 0.01*1000 = 10;
      ellipse(loc.x, loc.y, 0.02, 0.02);
    } else if (type == 1) {
      line(loc.x, loc.y, loc.x, loc.y+0.05);
    } else if (type == 2) {
      ellipse(loc.x, loc.y, 0.08, 0.02);
    } else if (type == 3) {
      line(loc.x, loc.y, loc.x+0.05, loc.y);
    } else if (type == 4) {
      rect(loc.x, loc.y, 0.07, 0.07);
    }


    //point(loc.x,loc.y,loc.z);
    popMatrix();
  }


  //method for checking if the Particle is dead or not
  //type is boolen, so it returns a boolean value
  //it needs no arguments to be called
  boolean isDead() {

    //if the lifespan of the particle is lesser than or equal to 0
    //return true, thus the particle is dead
    //if the lifespan is a positive value
    //return false, thus the particle is not dead
    if (lifespan<=0.0) {
      return true;
    } else {
      return false;
    }
  }
}