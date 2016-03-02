//based on the
//thomas Sanchez Lengeling library
//found on http://codigogenerativo.com/
//KinectPV2, Kinect for Windows v2 library for processing
//3D Skeleton

//import libraries to work with
import KinectPV2.KJoint;
import KinectPV2.*;

//declare variable kinect, from class KinectPV2
KinectPV2 kinect;

float zVal = 300;
float roatX = PI;

int kinectScaling = 500;

//counter of how many joints are being tracked
int counterSkeletons = 0;

//declare variable 
KJoint[] joints;
int trailingJointIndex;
ArrayList<PVector>trail = new ArrayList<PVector>();
ArrayList<PVector>currentJoints = new ArrayList<PVector>();
PVector vel;
PVector acc;


ArrayList<KSkeleton> skeletonArray = new ArrayList<KSkeleton>();

ArrayList<PVector> trailingJointPositions = new ArrayList<PVector>();

//PVector trailingJointPosition_1 = new PVector(0, 0, 0);
//PVector trailingJointPosition_2 = new PVector(0, 0, 0);
//PVector trailingJointPosition_3 = new PVector(0, 0, 0);
//PVector trailingJointPosition_4 = new PVector(0, 0, 0);
//PVector trailingJointPosition_5 = new PVector(0, 0, 0);
//ArrayList<PVector> circlesInfoCopy = new ArrayList<PVector>();
//circlesInfoCopy = circlesInfo;

void setupKinect() {

  kinect = new KinectPV2(this);

  kinect.enableSkeleton3DMap(true);

  kinect.init();
}

void updateKinectSkeletons() {
  pushMatrix();
  translate(width/2, height/2, 0);
  scale(kinectScaling, kinectScaling, 1);
  rotateX(PI);
  //flip the x positions, so we can perform in between the Kinect and the wall
  rotateY(PI);
  skeletonArray =  kinect.getSkeleton3d();
  //individual JOINTS

  //update count of skeletons being tracked
  counterSkeletons = skeletonArray.size();

  for (int i = 0; i <  skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      joints = skeleton.getJoints();

      //Set which joint is drawing
      // Get the index number for the joint
      for (int j = 0; j < 5; j++) {
        trailingJointPositions.add(joints[getTrailingJointIndex(j)].getPosition().copy());
        currentJoints.add(trailingJointPositions.get(j));
      }

      //keep just the last ones
      while (trailingJointPositions.size() > 5* counterSkeletons) {
        trailingJointPositions.remove(0);
      }


      //KJoint trailingJoint_1 = joints[getTrailingJointIndex(0)];
      //KJoint trailingJoint_2 = joints[getTrailingJointIndex(1)];
      //KJoint trailingJoint_3 = joints[getTrailingJointIndex(2)];
      //KJoint trailingJoint_4 = joints[getTrailingJointIndex(3)];
      //KJoint trailingJoint_5 = joints[getTrailingJointIndex(4)];

      //trailingJointPosition_1 = trailingJoint_1.getPosition().copy();
      //trailingJointPosition_2 = trailingJoint_2.getPosition().copy();
      //trailingJointPosition_3 = trailingJoint_3.getPosition().copy();
      //trailingJointPosition_4 = trailingJoint_4.getPosition().copy();
      //trailingJointPosition_5 = trailingJoint_5.getPosition().copy();

      //currentJoints.add(trailingJointPosition_1);
      //currentJoints.add(trailingJointPosition_2);
      //currentJoints.add(trailingJointPosition_3);
      //currentJoints.add(trailingJointPosition_4);
      //currentJoints.add(trailingJointPosition_5);


      //trail.add(trailingJointPosition_1);
      //trail.add(trailingJointPosition_2);
      //trail.add(trailingJointPosition_3);
      //trail.add(trailingJointPosition_4);
      //trail.add(trailingJointPosition_5);

      //int trailingJointIndex = getTrailingJointIndex();
      // Retrieve the joint using the index number
      //KJoint trailingJoint = joints[trailingJointIndex];
      // Get the PVector containing the xyz position of the joint
      //trailingJointPosition = trailingJoint.getPosition().copy();

      // Add to trail array
      //trail.add(trailingJointPosition);

      //Draw joints
      stroke(255);
      strokeWeight(5);
      drawJoints();
    }
  }
  // Draw trail
  stroke(255);
  noFill();

  for (PVector t : trail) {
    stroke(255, 0, 0);
    strokeWeight(10);
    point(t.x, t.y, t.z);
  }

  stroke(255);
  noFill();


  //constrain to 50 elements the size of the trail
  while (trail.size() > 50) {
    trail.remove(0);
  }


  while (currentJoints.size() > 5*skeletonArray.size()) {
    currentJoints.remove(0);
  }
  //println("current size of joints array " + currentJoints.size());

  popMatrix();
}



int getTrailingJointIndex(int index) {

  if (index == 0) {
    return KinectPV2.JointType_HandLeft;
  } else if (index == 1) {
    return KinectPV2.JointType_HandRight;
  } else if (index == 2) {
    return KinectPV2.JointType_FootLeft;
  } else if (index == 3) {
    return KinectPV2.JointType_FootRight;
  } else if (index == 4) {
    return KinectPV2.JointType_Head;
  } else {
    return 5;
  }
}



void drawConnectionLine() {

  for (int i = 0; i < currentJoints.size(); i++) {

    //check if we are on the head joint
    if (i%5 == 4) {
      strokeWeight(2);
      stroke(255);
      float headY = height-(currentJoints.get(i).y*kinectScaling+height/2);
      float headX = width -( currentJoints.get(i).x*kinectScaling+width/2);
      line(headX, headY, headX+30, headY-30);


      //connect it to the i-4
      float handleftY = height-(currentJoints.get(i-4).y*kinectScaling+height/2);
      float handleftX = width -(currentJoints.get(i-4).x*kinectScaling+width/2);
      line(headX, headY, handleftX, handleftY);
      //connect it to the i-3
      float handrightY = height-(currentJoints.get(i-3).y*kinectScaling+height/2);
      float handrightX = width-(currentJoints.get(i-3).x*kinectScaling+width/2);
      line(headX, headY, handrightX, handrightY);
      //connect it to the i-2
      float footleftY = height-(currentJoints.get(i-2).y*kinectScaling+height/2);
      float footleftX = width-(currentJoints.get(i-2).x*kinectScaling+width/2);
      line(headX, headY, footleftX, footleftY);
      //connect it to the i-1
      float footrightY = height-(currentJoints.get(i-1).y*kinectScaling+height/2);
      float footrightX = width-(currentJoints.get(i-1).x*kinectScaling+width/2);
      line(headX, headY, footrightX, footrightY);
    }
  }
}


void drawJoint(int jointType) {
  KJoint joint = joints[jointType];
  PVector jointPosition = joint.getPosition();
  point(jointPosition.x, jointPosition.y, jointPosition.z);
}

void drawJoints() {
  //Bust

  drawJoint(KinectPV2.JointType_Head);

  //Torso
  // drawJoint(KinectPV2.JointType_SpineMid);

  // Right Arm    
  drawJoint(KinectPV2.JointType_HandRight);
  //drawJoint(KinectPV2.JointType_ElbowRight);

  // Left Arm
  drawJoint(KinectPV2.JointType_HandLeft);
  //drawJoint(KinectPV2.JointType_ElbowLeft);

  // Right Leg
  //drawJoint(KinectPV2.JointType_KneeRight);
  drawJoint(KinectPV2.JointType_FootRight);

  // Left Leg
  //drawJoint(KinectPV2.JointType_KneeLeft);
  drawJoint(KinectPV2.JointType_FootLeft);
}