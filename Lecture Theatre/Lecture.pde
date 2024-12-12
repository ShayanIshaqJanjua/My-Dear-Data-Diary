PGraphics c;
PGraphics d;
String[] lc;
void setup() {
  background(0);
  size(1920, 1080, P3D);
  c = createGraphics(1920, 1080, P2D);
  d = createGraphics(1920, 1080, P2D);
  stamp = loadImage("stamp.png");
  lc = loadStrings("lectureConds.csv");
}
boolean rend = false;
float mouseBuffX= 0 ;
float mouseBuffY = 0;
float xRot = PI + mouseX/float(width)*PI;
float yRot = PI + mouseY/float(height)*PI;
boolean mRelease = false;
float zed = 3.0;
boolean stair = false;
boolean stage = false;
boolean aud = false;
boolean screen = true;
color stair_off = color(0, 30, 100);
color stair_on = #FBFF29;
color stage_On = #FEFFC6;
color stage_Off = #9FA074;
color aud_On = #FEFFC6;
color aud_Off = #9FA074;
String day = "Monday";
PImage stamp;
int count = 0;
void draw() {
  if (rend) {
    String currDay = lc[count];
    String[] vars = split(currDay, ",");
    day = vars[0];
    if (vars[3].equals("on")) {
      aud = true;
    } else {
      aud=false;
    }
    if (vars[2].equals("on")) {
      stage = true;
    } else {
      stage=false;
    }
    if (vars[1].equals("on")) {
      stair = true;
    } else {
      stair=false;
    }

    background(0);
    ambientLight(70, 70, 50);
    float fov = PI/zed;
    float cameraZ = (height/2.0)/tan(fov/2.0);
    colorMode(HSB);
    translate(0, 0, -500);                                                                                    //-500z
    directionalLight(20, 255, 60, 1, 0.5, 0);
    colorMode(RGB);
    spotLight(255, 255, 255, 1200, 400, 0, -1, 0, 0, PI/2, 100);
    background(0);
    translate(1000, 500, -200);
    noStroke();
    if (mousePressed) {
      if (!mRelease) {
        mouseBuffX = pmouseX;
        mouseBuffY = pmouseY;
        xRot += (mouseX - mouseBuffX)/200;
        yRot += (mouseY - mouseBuffY)/200;
      }
      mRelease = false;
    }
    PVector[] vEctors = new PVector[6];

    rotateY(xRot);
    rotateZ(yRot);
    emissive(stair?stair_on:stair_off);
    beginShape();
    vertex(250, 00, 400);      //                   250, 0, 400
    vertex(250, -200, 400);
    vertex(250, -200, -100);
    endShape();
    beginShape();
    vertex(-250, 00, 400);           //same as above but -250x
    vertex(-250, -200, 400);
    vertex(-250, -200, -100);
    endShape();
    beginShape();
    vertex(250, 00, 400);
    vertex(250, -200, 400);
    vertex(-250, -200, 400);
    vertex(-250, 00, 400);
    endShape();
    beginShape();
    vertex(250, -200, 400);
    vertex(250, -200, -100);
    vertex(-250, -200, -100);
    vertex(-250, -200, 400);
    endShape();
    beginShape();
    vertex(250, -200, -100);
    vertex(250, 00, 400);
    vertex(-250, 00, 400);
    vertex(-250, -200, -100);
    endShape();
    fill(0, 0, 0);
    emissive(aud?aud_On:aud_Off);
    translate(250, 200, 200); 
    sphere(50);
    //colorMode(HSB);
    //pointLight(100,255,10,0,0,10);
    //colorMode(RGB);
    translate(-500, 0, 0);                                                    //-500,0,0
    sphere(50);
    fill(0, 0, 0);
    emissive(stage?stage_On:stage_Off);
    translate(0, 0, -500);                                                          //0,0,-500
    sphere(30);
    translate(500, 0, 0);                                                                //500,0,0
    sphere(30);
    emissive(0);
    fill(0, 0, 0);
    beginShape();
    vertex(20, -130, -302);
    vertex(20, 230, -302);
    vertex(-530, 230, -302);
    vertex(-530, -130, -302);
    endShape();
    emissive(0);

    PImage scr = loadImage("Screen.png");
    scr.resize(500, 300);
    beginShape();
    textureMode(IMAGE);
    emissive(200, 200, 200);
    texture(scr);
    vertex(00, -100, -300, 00, 300);
    vertex(00, 200, -300, 00, 00);
    vertex(-500, 200, -300, 500, 00);
    vertex(-500, -100, -300, 500, 300);
    endShape();
    emissive(0);
    fill(255, 255, 230);
    translate(-250, 00, -405);                                        //-250, 0, -405
    box(1500, 700, -200);
    emissive(255);
    textSize(300);
    rotateX(PI);
    rotateY(PI);
    text(day, -800, -450);
    perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*100.0 );
  } else {
    c.beginDraw();
    c.background(#FAF6D1, 10);
    c.fill(0);
    c.rect(900, 50, 7, 900);
    c.textSize(30);
    c.text("If the stairs are yellow, charging is on, otherwise off.", 50, 200);
    c.text("If the screen show text, the screen is on, otherwise off.", 50, 300);
    c.text("If the lights above the stairs are on, audience lights are on.", 50, 400);
    c.text("If the lights above the stage are on, the stage lights are on.", 50, 500);
    c.text("Press a or d to switch between days.", 50, 700);
    c.text("Press f to flip between the key and visualisation", 50, 800);
    c.textSize(45);
    c.text("Shayan Janjua", 980, 489);
    c.rect(970, 490, 500, 2);
    c.text("Northampton Square", 980, 549);
    c.rect(970, 550, 500, 2);
    c.text("EC1V 0HB", 980, 619);
    c.rect(970, 620, 500, 2);
    c.text("London", 980, 689);
    c.rect(970, 690, 500, 2);
    c.text("United Kingdom", 980, 759);
    c.rect(970, 760, 500, 2);
    stamp.resize(400, 400);
    c.image(stamp, 1350, 0);
    c.endDraw();

    //Help taken from chatgpt
    hint(DISABLE_DEPTH_TEST); // Disable depth testing to ensure the 2D graphics appear on top
    image(c, 0, 0); // Draw the 2D graphics
    hint(ENABLE_DEPTH_TEST); // Re-enable depth testing
  }
}
void mouseReleased() {
  mRelease = true;
}

void mouseWheel(MouseEvent e) {
  if (e.getCount() >0) {
    zed-=0.2;
  } else {
    zed+=0.2;
  }
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
    if (!(count == 0)) {
      count--;
    }
  }
  if (key == 'd' || key == 'D') {
    if (!(count == 7)) {
      count++;
    }
  }
  if (key == 'f' || key == 'F') {
    rend = !rend;
  }
}
