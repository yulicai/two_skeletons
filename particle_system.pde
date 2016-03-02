//particle system class
//it consists of an Arraylist of Particle objects
//and a PVector named origin

//definition of particle system
class Particle_system {

  //internal variables of the particle system
  //ArrayList containing Particle objects
  ArrayList<Particle> particles;
  //PVector called origin
  PVector origin;


  //constructor for the particle system
  //it takes one PVector as an argument, to set the origin
  Particle_system(PVector loc) {
    //asign to the PVector origin variable, the info in the argument loc
    origin = loc.get();
    //initialize the ArrayList of Particles 
    particles = new ArrayList<Particle>();
  }

  //method to add particles to the particle system
  //type is void, so it returns nothing
  //its arguments are two PVectors, ploc and acc
  //for particle locatoin and acceleration
  void addParticle(PVector ploc, PVector acc, int _type) {
    //append a new particle object to the end of the particlesArrayList
    particles.add(new Particle(ploc, acc, 0.001,_type));
  }


  //method to run the part
  //type is void, so it returns nothing
  //its argument is index
  void run() {
    
    //walk through every particle
    //initialize auxiliar variable i to the size of 
    //the particles ArrayList - 1, so that its initial value
    //is the last index able to access the ArrayList
    //every time the for loop runs, we decrease by 1 the i variable
    //and this goes until i is 0, and then we exit this for loop
    for (int i = particles.size()-1; i>=0; i--) {
      
      //get the information for the ith Particle
      //on the particles ArrayList and assign it to 
      //the auxiliar p Particle object
      Particle p = particles.get(i);
      
      //
      p.run();
      
      //check if the current particle is dead
      //if it is dead, remove it from the
      //particles Arraylist
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}