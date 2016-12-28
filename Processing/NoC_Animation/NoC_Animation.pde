// Define 
color RouterColor = color(250, 150, 50);
float offset_ratio = 0.25;
PFont f;  
float Text_size = 20;
int tile_size = 200;
int flit_size = 50;
int cols = 7;
int rows = 5;
Router[][] layer;
Packet p1;
PVector S, D;

void setup() {

  size(1400,1000);
  //fullScreen();
  f = createFont("Arial",Text_size,true);
  
  layer = new Router[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
       layer[i][j] = new Router(int(i*tile_size), int(j*tile_size));
    }
  }
  S = new PVector(0,0);
  D = new PVector(5,5);
  p1 = new Packet(S,D);
}

void draw() {
  background(177);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      layer[i][j].DrawARouter();
      
    }
  }
  ConnectRouter();
  p1.DrawFlit();
  p1.Route();
  p1.UpdatePos();
  p1.ResetRoute();
}

void ConnectRouter(){
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows-1; j++) {
      stroke(255,205,0);
      strokeWeight(10);
      line(layer[i][j].IO_South.x,layer[i][j].IO_South.y,layer[i][j+1].IO_North.x,layer[i][j+1].IO_North.y);
    }
  }
  for (int i = 0; i < cols-1; i++) {
    for (int j = 0; j < rows; j++) {
      stroke(255,205,0);
      strokeWeight(10);
      line(layer[i][j].IO_East.x,layer[i][j].IO_East.y,layer[i+1][j].IO_West.x,layer[i+1][j].IO_West.y);
    }
  }
}