int spotWidth = 25;
int predatorCount = 10;
int preyCount = 50;
boolean followingMouse = false;

Predator[] predatorPack = new Predator[predatorCount];
Prey[] preyColony = new Prey[preyCount];

void setup()
{
  size(750, 750);
  frameRate(120);
  for (int i = 0; i < predatorPack.length; i++)
  {
    predatorPack[i] = new Predator((int)(Math.random() * width), (int)(Math.random() * height));
  }
    for (int i = 0; i < preyColony.length; i++)
  {
    preyColony[i] = new Prey((int)(Math.random() * width), (int)(Math.random() * height));
  }
}

void draw()
{
  fill(75, 200, 75, 255);
  rect(0, 0, width, height);
  for (int i = 0; i < predatorPack.length; i++)
  {
    predatorPack[i].walk();
    predatorPack[i].show();

  }
    for (int i = 0; i < preyColony.length; i++)
  {
    preyColony[i].walk();
    preyColony[i].show();
    if (followingMouse)
      preyColony[i].updateBias();

  }
}

void mousePressed()
{
  if (followingMouse)
  {
    followingMouse = false;
    setup();
  }
  else
  {
    followingMouse = true;
  }
}

class Prey
{
  int preyX, preyY; 
  color preyColor; 
  double preyXBias, preyYBias; 
  Prey(int x, int y)
  {
    preyX = x; 
    preyY = y; 
    preyColor = color((int)((Math.random() * 100)), 
      (int)(Math.random() * 100), 
      (int)((Math.random() * 100)+ 200), 255);
  }

  void walk()
  {
    preyX += (int)(Math.random() * 7) - 3 + preyXBias; 
    preyY += (int)(Math.random() * 7) - 3 + preyYBias;
  }

 void updateBias()
  {
    int horDistFromMouse = mouseX - preyX; 
    int vertDistFromMouse = mouseY - preyY; 
    double distFromMouse = (double)(Math.sqrt(sq(horDistFromMouse) + sq(vertDistFromMouse))); 
    double angleFromMouse; 
    if (horDistFromMouse == 0) {
      if (vertDistFromMouse > 0)
        angleFromMouse = PI / 2; 
      else 
      angleFromMouse = - PI / 2;
    } else {
      angleFromMouse = Math.atan2(vertDistFromMouse, horDistFromMouse);
    }

    preyXBias = (distFromMouse * Math.cos(angleFromMouse) / (spotWidth * 1)); 
    preyYBias = (distFromMouse * Math.sin(angleFromMouse) / (spotWidth * 1));
  }

  void show()
  {
    noStroke(); 
    fill(preyColor); 
    ellipse(preyX, preyY, spotWidth, spotWidth);
  }
  
  void reproduce()
  {
    double chance = Math.random();
    if(preyCount > 2 && chance > .9) {
      preyCount++;
    }
  }
}

class Predator
{
    int predatorX, predatorY; 
  color predatorColor; 
  double predatorXBias, predatorYBias; 
  Predator(int x, int y)
  {
    predatorX = x; 
    predatorY = y; 
    predatorColor = color((int)((Math.random() * 100)+ 200), 
      (int)(Math.random() * 100), 
      (int)((Math.random() * 50)), 255);
  }

  void walk()
  {
    predatorX += (int)(Math.random() * 7) - 3 + predatorXBias; 
    predatorY += (int)(Math.random() * 7) - 3 + predatorYBias;
  }

void updateBias()
  {
    int horDistFromMouse = mouseX - predatorX; 
    int vertDistFromMouse = mouseY - predatorY; 
    double distFromMouse = (double)(Math.sqrt(sq(horDistFromMouse) + sq(vertDistFromMouse))); 
    double angleFromMouse; 
    if (horDistFromMouse == 0) {
      if (vertDistFromMouse > 0)
        angleFromMouse = PI / 2; 
      else 
      angleFromMouse = - PI / 2;
    } else {
      angleFromMouse = Math.atan2(vertDistFromMouse, horDistFromMouse);
    }

    predatorXBias = (distFromMouse * Math.cos(angleFromMouse) / (spotWidth * 1)); 
    predatorYBias = (distFromMouse * Math.sin(angleFromMouse) / (spotWidth * 1));
  }

  void show()
  {
    noStroke(); 
    fill(predatorColor); 
    ellipse(predatorX, predatorY, spotWidth, spotWidth);
  }
  
  void attack()
  {
    double chance = Math.random();
    if(chance > .9) {
      preyCount--;
    }
  }
}


