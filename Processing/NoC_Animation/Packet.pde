// A Packet object
class Packet {
  // A Tile object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  PVector Pos;
  PVector current;   // x,y location
  PVector Source, Destination;
  PVector Acce;
  int Speed = 10;
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
    if (Pos == Destination){
    Pos.x = Source.x;
    Pos.y = Source.y;
    }
  }
  void DrawFlit(){
    translate(Pos.x+tile_size/2-flit_size/2, Pos.y+tile_size/2-flit_size/2);
    print(str(Source.x)+ "--"+str(Source.x)+"\n");
    stroke(0);
    strokeWeight(1);
    fill(255,0,0);
    rect(0,0,flit_size,flit_size);

  }
}