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

// A Router object
class Router {
  // A Tile object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  int x, y;   // x,y location
  PVector offset, router_size;
  PVector IO_North, IO_West, IO_South, IO_East, IO_Up, IO_Down;
  Router(int tempX, int tempY) {
    x = tempX;
    y = tempY;
    offset = new PVector((x+tile_size*offset_ratio), (y+tile_size*offset_ratio));
    router_size = new PVector((tile_size*(1-2*offset_ratio)), (tile_size*(1-2*offset_ratio)));
    IO_West = new PVector((x+tile_size*offset_ratio), (y+tile_size/2));
    IO_North = new PVector((x+tile_size/2), (y+tile_size*offset_ratio));
    IO_East = new PVector((x+tile_size-tile_size*offset_ratio), (y+tile_size/2));
    IO_South = new PVector((x+tile_size/2), (y+tile_size-tile_size*offset_ratio));
  } 

  void DrawARouter() {
    // offset and sizes

    // connection points

    noStroke();
    fill(207);
    rect(x, y, tile_size, tile_size);
    
    fill(RouterColor);
    
    stroke(0);
    strokeWeight(1);

    rect(offset.x, offset.y, router_size.x, router_size.y); 
    // Display the router's index
    fill(0);
    textFont(f, Text_size);
    textAlign(CENTER, CENTER);
    text("R("+str(int(x/tile_size))+","+str(int(y/tile_size))+")", x+tile_size/2, y+tile_size/2);
    strokeWeight(1);
   


  }
}

// A Packet object
class Packet {
  // A Tile object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  PVector Pos;
  PVector current;   // x,y location
  PVector Source, Destination;
  PVector Acce;
  int Speed = 5;
  Packet(PVector S, PVector D){
    Source = S;
    Destination = D;
    Acce = new PVector(0,0);
    current = new PVector(0,0);
    Pos = new PVector(S.x, S.y);
  }
  void Route() {
    current.x = ceil(Pos.x/tile_size);
    current.y = ceil(Pos.y/tile_size);
    if (current.x < Destination.x) {
      Acce.x = Speed;
      Acce.y = 0;
    } else if(current.x > Destination.x) {
      Acce.x = -Speed;
      Acce.y = 0;
    } else if(current.y < Destination.y) {
      Acce.x = 0;
      Acce.y = Speed;
    } else if(current.y > Destination.y) {
      Acce.x = 0;
      Acce.y = -Speed;
    } else {
      Acce.x = 0;
      Acce.y = 0;
      
    }
  }
  void UpdatePos(){
    Pos.x = Pos.x+Acce.x;
    Pos.y = Pos.y+Acce.y;
  }
  void ResetRoute(){
    if (ceil(Pos.x/tile_size) == Destination.x && ceil(Pos.y/tile_size) == Destination.y){
    Pos.x = Source.x;
    Pos.y = Source.y;
    }
  }
  void DrawFlit(){
    translate(Pos.x+tile_size/2-flit_size/2, Pos.y+tile_size/2-flit_size/2);
    //print(str(Pos.x)+ "--"+str(Pos.x)+"\n");
    stroke(0);
    strokeWeight(1);
    fill(255,0,0);
    rect(0,0,flit_size,flit_size);

  }
}