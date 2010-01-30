void drawRoute(RouteData route) {

  String[] route_ID_data = split(route.route_ID, ' ');

  StopLocation start_stop = stops.getStop(route.path[0]);
  StopLocation end_stop = stops.getStop(route.path[route.path.length - 1]);

  float offset_x = end_stop.latitude - start_stop.latitude;
  float offset_y = end_stop.longitude - start_stop.longitude;
  float norm_offset_x = (offset_x) / pow( (pow(offset_x,2) + pow(offset_y,2)), 0.5);
  float norm_offset_y = (offset_y) / pow( (pow(offset_x,2) + pow(offset_y,2)), 0.5);

  //println("Offsets: " + offset_x + "," + offset_y + " " + norm_offset_x + "," + norm_offset_y);
  
  int total_traffic = 0;
  // add traffic for all days covered
  for (int i = 0; i < highlighted_days.length; i++) {
    // add for all hours in each day
    for (int j = highlighted_times[0]; j <= highlighted_times[highlighted_times.length - 1]; j++) {
      if (highlighted_days[i].equals("Sunday")) {
        total_traffic = total_traffic + route.traffic_sunday[j];
      } else if (highlighted_days[i].equals("Monday")) {
        total_traffic = total_traffic + route.traffic_monday[j];
      } else if (highlighted_days[i].equals("Tuesday")) {
        total_traffic = total_traffic + route.traffic_tuesday[j];
      }
    }
  }
  //println("total traffic for " + route.route_ID + " is " + total_traffic);
  float weight = total_traffic/(20.0 * highlighted_days.length * highlighted_times.length);
  //println("Weight is " + weight);
  strokeWeight(weight);
  
  if (route_ID_data[1].equals("I")) {
    stroke(255,0,0);
  } else if (route_ID_data[1].equals("O")) {
    stroke(0,0,255);
  }
  
  for (int i=0; i < route.path.length - 1; i++) {
    
    StopLocation this_stop = stops.getStop(route.path[i]);
    StopLocation next_stop = stops.getStop(route.path[i+1]);
    
    StopLocation this_stop_slope_start = this_stop;
    StopLocation this_stop_slope_end = next_stop;
    StopLocation next_stop_slope_start = this_stop;
    StopLocation next_stop_slope_end = next_stop;
    
    if (i > 0) {
      this_stop_slope_start = stops.getStop(route.path[i-1]);
    }
    if (i + 2 < route.path.length) {
      next_stop_slope_end = stops.getStop(route.path[i+2]);
    }

/*
    float offset_this_x = this_stop_slope_end.latitude - this_stop_slope_start.latitude;
    float offset_this_y = this_stop_slope_end.longitude - this_stop_slope_start.longitude;
    float offset_next_x = next_stop_slope_end.latitude - next_stop_slope_start.latitude;
    float offset_next_y = next_stop_slope_end.longitude - next_stop_slope_start.longitude;
    float norm_offset_this_x = (offset_this_x) / pow( (pow(offset_this_x,2) + pow(offset_this_y,2)), 0.5);
    float norm_offset_this_y = (offset_this_y) / pow( (pow(offset_this_x,2) + pow(offset_this_y,2)), 0.5);    
    //println("For first point " + this_stop_slope_start.latitude + "," + this_stop_slope_start.longitude + " going to " + this_stop_slope_end.latitude + "," + this_stop_slope_end.longitude + " the direction of perpendinucalr is found to be " + norm_offset_this_x + "," + norm_offset_this_y);
    float norm_offset_next_x = (offset_next_x) / pow( (pow(offset_next_x,2) + pow(offset_next_y,2)), 0.5);
    float norm_offset_next_y = (offset_next_y) / pow( (pow(offset_next_x,2) + pow(offset_next_y,2)), 0.5);
*/

    float x1 = map(this_stop.longitude, lon_left, lon_right, plotX1, plotX2) + (weight / 2.0) * norm_offset_x;
    float x2 = map(next_stop.longitude, lon_left, lon_right, plotX1, plotX2) + (weight / 2.0) * norm_offset_x;
    float y1 = map(this_stop.latitude, lat_bot, lat_top, plotY1, plotY2) - (weight / 2.0) * norm_offset_y;
    float y2 = map(next_stop.latitude, lat_bot, lat_top, plotY1, plotY2) - (weight / 2.0) * norm_offset_y;
    line(x1, y1, x2, y2);
    
    /*
    if (i - 5 * int(i/5) == 0) {
      strokeWeight(weight * 2);
      point(x1,y1);
      point(x2,y2);
      //float arrow_x = x2 + (weight * 5) * norm_offset_next_y;
      //float arrow_y = y2 - (weight * 5) * norm_offset_next_y;
      //line(x2, y2, arrow_x, arrow_y);
      strokeWeight(weight);
    }
    */
  }
}
