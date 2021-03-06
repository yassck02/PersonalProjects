int SIZE = 25; //length of circle trail
int f = 1; // 'draw every f cirlce in the trail' ( see drawTrail() )

int[] Xpositions = new int[SIZE];
int[] Ypositions = new int[SIZE];

int posX;
int posY;

int prevPosX;
int prevPosY;

float speedX = random(3, 5);
float speedY = random(3, 5);
float radius = 50;
color backgroundColor;

float t = 255.0;

boolean shouldDraw = true;


void setup() {
  colorMode(HSB);

  backgroundColor = color(random(255), 255, 255);

  speedX = random(2, 4);
  speedY = random(2, 4);

  posX = width/2;
  posY = height/2;

  size(600, 300);
  strokeWeight(1);
  stroke(0, 0, 255);

  ellipseMode(CENTER);

  //frameRate(5);
}

void draw() {
  background(backgroundColor);
  
  posX += speedX; 
  posY += speedY;

  if ((posX > width-(radius/2)) || (posX < 0+(radius/2))) { //left and right walls
    speedX *= -1;
    backgroundColor = color(random(255), 255, 255); //set random background color
  }
  if ((posY > height-(radius/2)) || (posY < 0+(radius/2))) { //top and bottom walls
    speedY *= -1;
    backgroundColor = color(random(255), 255, 255);//set random background color
  }

  drawTrail(); //draw the circle trail
  fill(0, 0, 255, 255);//white
  stroke(0, 0, 0, 255);//black
  ellipse(posX, posY, radius, radius); // draw first ellipse (is drawn second to be displayed on top of the trail)
}

void drawTrail() {
  noStroke();

  if (frameCount % f == 0) { //draw every f circle in the trail
    for (int i = Xpositions.length-1; i > 0; i = i - 1) { //shif x positions in array to the right
      Xpositions[i] = Xpositions[i-1];
    }
    for (int i = Ypositions.length-1; i > 0; i = i - 1) { //shif x positions in array to the right
      Ypositions[i] = Ypositions[i-1];
    }
    Xpositions[0] = posX; //set the first value of the x positions array to the current xposition
    Ypositions[0] = posY; //set the first value of the y positions array to the current y position
  }

  for (int n = 1; n < SIZE; n++) { //loop through each circle in the trail
    t = int(255.0*(1-(float(n)/SIZE))); //determine transparency of each circle based on dircle location in the trail f
    //println(Xpositions[n] + "," + Ypositions[n] + " (" + t + ")"); //print coordinates and transparency of each circle in the trail
    fill(0, 0, 255, t); //set color
    ellipse(Xpositions[n], Ypositions[n], radius, radius); //draw circle
  }
}


void mousePressed() { //press the mouse to pause/resume the program
  shouldDraw = !shouldDraw;
  if (shouldDraw == false) {
    noLoop(); //pause
  } else {
    loop(); //unpause
  }
}
