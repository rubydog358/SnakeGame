// adapted from Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// https://youtu.be/AaGK-fj-BAM

Snake s;
int scl = 20;
String status = "";
PVector food;
boolean gotFood;
boolean alive;
color bgcolor;

void setup() {
  bgcolor=  color(random(255), random(255), random(255));
  size(600, 600);
  s = new Snake();
  alive = true;
  frameRate(10);
  setFoodLocation();
}//makes background random color on startup

void draw() {
  background(bgcolor);
  if (keyPressed==true){
    if (key == 'w'){
      s.dir(0, -1);
    }
    if(key == 's'){
      s.dir(0, 1);
  }
  if(key == 'a'){
    s.dir(-1, 0);
  }
  if(key == 'd'){
    s.dir(1, 0);
  }
    //moves the snake in the right direction with WASD
  }

  
  s.checkForPulse();
  s.update();
  s.show();

  gotFood = s.eat(food);
   if(gotFood==true){
     setFoodLocation();
     bgcolor = color(random(255),random(255), random(255));
   }//when ya eat food, it changes the background color
 if (mousePressed==true){
   background(random(255), random(255), random(255));
 }//changes background to another if mouse is pressed
  
  fill(255, 0, 100);
  rect(food.x, food.y, scl, scl);
  
  status = "length: " + s.total;
  
  
      textSize(32);
text(status, 10, 30); 
fill(0, 102, 153);
    
       
    }//shows the text
    
  


  // TODO: Extensions...
  //       1. add a cheat. if mousePressed is true,
  //          increase "s.total" (without the quotes) by one.
  //       2. check if the snake is dead. If it is,
  //          tell the user that the game is over!
  //       3. after you do #2, give the user an option to
  //          restart the game (keyPress?)
  //       4. change any other parameters in the game (speed, size, colors, etc)
  //            - first tinker on your own
  //            - then ask a colleague if you need help or ideas
  //       Then replace this comment with one of your own. 
  



void setFoodLocation() {
  int cols = width/scl;
  int rows = height/scl;
  food = new PVector(floor(random(cols)), floor(random(rows)));
  food.mult(scl);
}


class Snake {
  float x = 0;
  float y = 0;
  float xspeed = 1;
  float yspeed = 0;
  int total = 0;
  ArrayList<PVector> tail = new ArrayList<PVector>();

  Snake() {
  }

  boolean eat(PVector pos) {
    float d = dist(x, y, pos.x, pos.y);
    if (d < 1) {
      total++;
      return true;
    } else {
      return false;
    }
  }

  void dir(float x, float y) {
    xspeed = x;
    yspeed = y;
  }

  void checkForPulse() {
    for (int i = 0; i < tail.size(); i++) {
      PVector pos = tail.get(i);
      float d = dist(x, y, pos.x, pos.y);
      if (d < 1) {
        total = 0;
        alive = false;
        tail.clear();
      }
    }
  }

  void update() {
    if (total > 0) {
      if (total == tail.size() && !tail.isEmpty()) {
        tail.remove(0);
      }
      tail.add(new PVector(x, y));
    }

    x = x + xspeed*scl;
    y = y + yspeed*scl;

    x = constrain(x, 0, width-scl);
    y = constrain(y, 0, height-scl);
  }

  void show() {
    fill(255);
    for (PVector v : tail) {
      rect(v.x, v.y, scl, scl);
    }
    rect(x, y, scl, scl);
  }
  
  int getTotal() {
    return total;
  }
}
