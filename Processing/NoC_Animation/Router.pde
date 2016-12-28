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