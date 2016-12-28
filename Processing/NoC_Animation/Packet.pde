// A Packet object
class Packet {
  // A Tile object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  int index;
  boolean run;
  PVector Pos;
  PVector current;   // x,y location
  PVector Source, Destination;
  PVector Acce;
  int Speed = 4;
  float zsize = random(0.5,1);
  color rand_color;
  Packet(PVector S, PVector D, int i){
    index = i;
    Source = new PVector(S.x, S.y);
    Destination = new PVector(D.x, D.y);
    Acce = new PVector(0,0);
    current = new PVector(Source.x,Source.x);
    Pos = new PVector(Source.x*tile_size, Source.y*tile_size);
    rand_color = color(int(random(150,255)),int(random(150,255)),int(random(150,255)));
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
    if (Pos.x >= 0 && Pos.x <= width && Pos.y>=0 && Pos.y<=height){
    Pos.x = Pos.x+Acce.x;
    Pos.y = Pos.y+Acce.y;
    }
  }
  void ResetRoute(){
    if (ceil(Pos.x/tile_size) == Destination.x && ceil(Pos.y/tile_size) == Destination.y){
    Pos.x = Source.x*tile_size;
    Pos.y = Source.y*tile_size;
    }
  }
  boolean CheckFinish(){
    if (ceil(Pos.x/tile_size) == Destination.x && ceil(Pos.y/tile_size) == Destination.y){
      return true;
    } else {
      return false;
    }
    
  }
  void DrawFlit(){
    pushMatrix();

    translate(Pos.x+tile_size/2-flit_size/2, Pos.y+tile_size/2-flit_size/2);
    stroke(0);
    strokeWeight(1);
    fill(rand_color);
    rect(0,0,flit_size,flit_size);
    
    fill(0);
    textFont(f, Text_size);
    textAlign(CENTER, CENTER);
    text(str(index),flit_size/2, flit_size/2);
    
    popMatrix();

  }
  void dbg(){
    print("Source: "+str(Source.x)+ "--"+str(Source.y)+"\n");
    print("Acce: "+str(Acce.x)+ "--"+str(Acce.y)+"\n");
  }
}