void drawSlider() {
  PFont plot_font = createFont(plot_font_type,12);
  
  fill(255,200);
  noStroke();
  rect(0,plotHeight - 1.5 * (plotHeight - slider_y),plotWidth,slider_y * 2);
  
  fill(0);
  textAlign(RIGHT, CENTER);
  textFont(plot_font);
  text("Hours:", slider_start_x - 10, slider_y - 3);
  
  plot_font = createFont(plot_font_type,8);
  textFont(plot_font);
  textAlign(CENTER, TOP);
  text("0", slider_start_x, slider_y + ( (slider_height / 2.0) + 5));
  for (int i = 2; i <= day_divisions; i += 2) {
    int notch_hour = i / 2;
    float notch_x = slider_start_x + (slider_end_x - slider_start_x) * ( i * 1.0 / day_divisions);
    text(notch_hour, notch_x, slider_y + ( (slider_height / 2.0) + 5));
  }
  
  stroke(200);
  strokeWeight(4);
  line(slider_start_x,slider_y,slider_end_x,slider_y);
  
  line(slider_start_x,slider_y - (slider_height / 4.0), slider_start_x, slider_y + (slider_height / 4.0));
  for (int i = 2; i <= day_divisions; i += 2) {
    float notch_x = slider_start_x + (slider_end_x - slider_start_x) * ( i * 1.0 / day_divisions);
    line(notch_x, slider_y - (slider_height / 4.0), notch_x, slider_y + (slider_height / 4.0));
  }
  
  stroke(100);
  fill(200);
  int highlighted_start = highlighted_times[0];
  int highlighted_end = highlighted_times[highlighted_times.length - 1];
  float highlight_start_x = slider_start_x + (slider_end_x - slider_start_x) * ( highlighted_start * 1.0 / day_divisions);
  float highlight_end_x = slider_start_x + (slider_end_x - slider_start_x) * ( (highlighted_end + 1.0) / day_divisions);
  rect(highlight_start_x,slider_y - (slider_height / 2.0), highlight_end_x - highlight_start_x, slider_height);
}

void mousePressed() {
  if ( (abs(mouseX - curr_slider_left) < 5) && (abs(mouseY - slider_y) < (slider_height + 5)) ) {
    currently_updating = "left";
  } else if ( (abs(mouseX - curr_slider_right) < 5) && (abs(mouseY - slider_y) < (slider_height + 5)) ) {
    currently_updating = "right";
  } else if ( (mouseX < curr_slider_right) && (mouseX > curr_slider_left) ) {
    currently_updating = "center";
  }
}

void mouseReleased() {
  currently_updating = "none";
}


