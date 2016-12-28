// Define 
color RouterColor = color(220);
float offset_ratio = 0.25;
PFont f;  
float Text_size = 20;
int tile_size = 200;
int flit_size = 50;
int cols = 7;
int rows = 5;
Router[][] layer;
int packet_num = 60000;
//Packet[] p1;
ArrayList p1;
PVector S, D;
int completed_num = 0;
PVector p0addr;

void setup() {

  size(1400, 1000);
  //fullScreen();
  f = createFont("Arial", Text_size, true);

  layer = new Router[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      layer[i][j] = new Router(int(i*tile_size), int(j*tile_size));
    }
  }
  //p1 =  new Packet[packet_num];
  p1 =  new ArrayList();
  //S = new PVector(int(random(7)), int(random(5)));
  //D = new PVector(int(random(7)), int(random(5)));
  for (int i = 0; i<packet_num; i++) {
    S = new PVector(int(random(cols)), int(random(rows)));
    D = new PVector(int(random(cols)), int(random(rows)));
    p1.add( new Packet(S, D, i));
  }

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
  boolean finish = false;
  int r_indx = 0;
  for (int i=0; i < p1.size();i++){
    Packet p = (Packet) p1.get(i);
    if (i==r_indx) {
      p.run = true;
    }

    if ((p.current.x >= p.Source.x+1 || p.current.x <= p.Source.x-1)) {
      r_indx++;
    //} else if (p.current.y >= p.Source.y+1 || p.current.y <= p.Source.y-1) {
    //  r_indx++;
    }
  }
  for (int i = p1.size()-1; i>=0; i--){
    Packet p = (Packet) p1.get(i);
    

    if (p.run){
      p.DrawFlit();
      p.Route();
      p.UpdatePos();
      //p.ResetRoute();
      finish = p.CheckFinish();
      if (finish) {
        p1.remove(i);
        //packet_num--;
        completed_num++;
       //print("\nDONE: "+str(completed_num));
       //if (completed_num == packet_num) print("\nDONE ALL !!!!!!!!!!");
  
      }
    }
  }
  
  //p1[1].dbg();
}

void ConnectRouter() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows-1; j++) {
      stroke(0);
      strokeWeight(10);
      line(layer[i][j].IO_South.x, layer[i][j].IO_South.y, layer[i][j+1].IO_North.x, layer[i][j+1].IO_North.y);
    }
  }
  for (int i = 0; i < cols-1; i++) {
    for (int j = 0; j < rows; j++) {
      stroke(0);
      strokeWeight(10);
      line(layer[i][j].IO_East.x, layer[i][j].IO_East.y, layer[i+1][j].IO_West.x, layer[i+1][j].IO_West.y);
    }
  }
}