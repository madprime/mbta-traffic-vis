StopLocations stops;
Routes routes;
String[] route_IDs;

// initialized, hope to allow to change later
String[] highlighted_days = { "Sunday" };
int[] highlighted_times = { 12, 13, 14, 15, 16, 17, 18, 19 };
  
int day_divisions = 48;
float lat_top = 42.47;
float lat_bot = 42.2;
float lon_left = -71.43;
float lon_right = -70.93;

int plotWidth = 800;
int plotHeight = 500;

float plotX1 = 0;
float plotX2 = plotWidth;
float plotY1 = plotHeight;
float plotY2 = 0;


PImage bg_image;

float slider_start_x = plotWidth * 0.1;
float slider_end_x = plotWidth * 0.9;
float slider_y = plotHeight * 0.9;
float slider_height = plotHeight / 30.0;
float curr_slider_left = slider_start_x + (slider_end_x - slider_start_x) * ( highlighted_times[0] * 1.0 / day_divisions);
float curr_slider_right = slider_start_x + (slider_end_x - slider_start_x) * ( (highlighted_times[highlighted_times.length - 1] + 1.0) / day_divisions);
String currently_updating = "none";

String plot_font_type = "Arial";
   
void setup() {
  bg_image = loadImage("newmap.png");

  stops = ReadStopsFile("stops_tsv.txt");
  routes = ReadRoutesDataFile("route_data");
  route_IDs = routes.getRouteIDs();
 
  size(plotWidth,plotHeight);
  
  smooth();
  
}

void draw() {
  background(255);
  image(bg_image, 0, 0, plotWidth, plotHeight);
  if (! currently_updating.equals("none")) {
    if (currently_updating.equals("left")) {
      int new_hour = round( map(mouseX,slider_start_x, slider_end_x, 0, day_divisions - 1) );
      if (new_hour > highlighted_times[highlighted_times.length - 1]) {
        new_hour = highlighted_times[highlighted_times.length - 1];
      }
      if (new_hour < 0) {
        new_hour = 0;
      }
      int[] new_times = new int[0];
      for (int i = new_hour; i <= highlighted_times[highlighted_times.length - 1]; i++) {
        new_times = append(new_times, i);
      }
      highlighted_times = new_times;
      curr_slider_left = slider_start_x + (slider_end_x - slider_start_x) * ( highlighted_times[0] * 1.0 / day_divisions);
    } else if (currently_updating.equals("right")) {
      int new_hour = round( map(mouseX,slider_start_x, slider_end_x, 0, day_divisions - 1) - 1 );
      if (new_hour < highlighted_times[0]) {
        new_hour = highlighted_times[0];
      }
      if (new_hour > day_divisions - 1) {
        new_hour = day_divisions - 1;
      }
      int[] new_times = new int[0];
      for (int i = highlighted_times[0]; i <= new_hour; i++) {
        new_times = append(new_times, i);
      }
      highlighted_times = new_times;
      curr_slider_right = slider_start_x + (slider_end_x - slider_start_x) * ( (highlighted_times[highlighted_times.length - 1] + 1.0) / day_divisions);
    } else if (currently_updating.equals("center")) {
      float current_center = (curr_slider_left + curr_slider_right) / 2.0;
      int difference = round( map(mouseX - current_center, 0, (slider_end_x - slider_start_x), 0, day_divisions - 1));
      println(current_center + " " + mouseX + " " + difference);
      int new_start = highlighted_times[0] + difference;
      if (new_start < 0) {
        new_start = 0;
      }
      if (new_start + (highlighted_times[highlighted_times.length - 1] - highlighted_times[0]) > day_divisions - 1) {
        new_start = (day_divisions - 1) - (highlighted_times[highlighted_times.length - 1] - highlighted_times[0]);
      }
      int[] new_times = new int[0];
      for (int i = new_start; i <= new_start + (highlighted_times[highlighted_times.length - 1] - highlighted_times[0]); i++) {
        new_times = append(new_times, i);
      }
      highlighted_times = new_times;
      curr_slider_left = slider_start_x + (slider_end_x - slider_start_x) * ( highlighted_times[0] * 1.0 / day_divisions);
      curr_slider_right = slider_start_x + (slider_end_x - slider_start_x) * ( (highlighted_times[highlighted_times.length - 1] + 1.0) / day_divisions);
    }
  }  
  
  for (int i = route_IDs.length - 1; i >= 0; i--) {
    RouteData route = routes.getRoute(route_IDs[i]);
    drawRoute(route);
  }
  
  drawSlider();
}
