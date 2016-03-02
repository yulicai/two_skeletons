//variable for storing the last position where the mouse clicked
PVector lastClick = new PVector(mouseX, mouseY);
boolean mouseDragging;

//variables for drawing the ellipses
int lastRadius;
int strokeSize;
float ellipseRatio;
int maxRadius;

//array that stores the center position and radius of circles
ArrayList<PVector> circlesInfo= new ArrayList<PVector>();
//maximum number of circles drawn at the same time
int maxNumberCircles;

void setupCircles() {
  //set the initial state of the mouse
  mouseDragging = false;
  //set initial variables for drawing circle
  lastRadius = 0;

  //set the stroke for drawing the circles
  strokeSize = 2;

  //set the number of maximum number of circles on screen
  maxNumberCircles = 5;
  
  //define ellipse ratio
  ellipseRatio = 6.0;
  
  maxRadius = 41;
  
}

//function for updating circles on the canvas
//it reacts to the mouse position and clicks
// the click sets the center of the circle
//and the dragging sets the radius
void updateCircles() {

  if (mousePressed == true && mouseDragging == false) {
    //update the vector to hold the last position of mouse clicked
    lastClick = new PVector(mouseX, mouseY);
    mouseDragging = true;
    
    //println(lastClick.x, lastClick.y);
  }

  if (mouseDragging == true) {
    fill(255);
    int draggingRadius = constrain(floor(dist(mouseX, mouseY, lastClick.x, lastClick.y)), 0, maxRadius);
    ellipse(lastClick.x, lastClick.y, 2*draggingRadius*ellipseRatio, 2*draggingRadius);
  }
}

//function for drawing the circles
void drawCircles() {

  //for every element in the circlesInfo array, draw the circle
  //set the stroke color to white
  stroke(255);

  //set the fill to void
  noFill();

  //set the stroke weight
  strokeWeight(strokeSize);

  for (PVector c : circlesInfo) {  
    //we stored the center position in the x and y position
    //the z position we used it for storing the radius
    //the factor of 2 is for getting the diameter
    ellipse(c.x, c.y, 2*c.z*ellipseRatio, 2*c.z);
  }
}

//function for appending new circles to the array
void appendNewCircle() {

  mouseDragging = false;
  //calculate the radius, with the distance between lastClick and current mouse position
  lastRadius = constrain(floor(dist(mouseX, mouseY, lastClick.x, lastClick.y)), 0, maxRadius);

  //store and format info of latest circle to be appended to array
  PVector latestCircle = new PVector(lastClick.x, lastClick.y, lastRadius);

  //append this PVector to the array
  circlesInfo.add(latestCircle);

  //constrain the array, so that there is just a certain number of PVector on it
  while (circlesInfo.size () > maxNumberCircles) {

    //remove the oldest circle info from the array
    circlesInfo.remove(0);
  }

  //reset the radius
  lastRadius = 0;
}