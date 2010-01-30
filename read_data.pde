StopLocations ReadStopsFile(String filename) {
  StopLocations stop_locations = new StopLocations();
  
  // Load csv file as an array of strings. First line contains labels for columns.
  String[] lines = loadStrings(filename);
  String[] data_labels = split(lines[0], TAB);
  
  // Initialize columns
  int col_stop_ID = -1, col_stop_name = -1, col_stop_lat = -1, col_stop_lon = -1;
  for (int i = 0; i < data_labels.length; i++) {
    if (match(data_labels[i],"stop_id") != null) {
      col_stop_ID = i;
    } else if (match(data_labels[i],"stop_name") != null) {
      col_stop_name = i;
    } else if (match(data_labels[i],"stop_lat") != null) {
      col_stop_lat = i;
    } else if (match(data_labels[i],"stop_lon") != null) {
      col_stop_lon = i;
    }
  }
  
  // Abort if no columns read "stop_ID" and "stop_lat" and "stop_lon"
  if (col_stop_ID == -1 || col_stop_lat == -1 || col_stop_lon == -1) {
    println ( "Error reading stops file in ReadStopsFile!");
    exit();
  }
  
  // Read in all the stops data
  for (int i = 1; i < lines.length; i++) {
    String[] stop_data = split(lines[i], TAB);
    String stop_ID = stop_data[col_stop_ID];
    String stop_name = stop_data[col_stop_name];
    String stop_lat_string = stop_data[col_stop_lat];
    String stop_lon_string = stop_data[col_stop_lon];
    float stop_lat = parseFloat(stop_lat_string);
    float stop_lon = parseFloat(stop_lon_string);
    stop_locations.addStop(stop_ID,stop_name,stop_lat,stop_lon);
  }
  
  return(stop_locations);
}

Routes ReadRoutesDataFile(String filename) {
  Routes routes = new Routes();
  
  // Load csv file as an array of strings. First line contains labels for columns.
  String[] lines = loadStrings(filename);
  String[] data_labels = split(lines[0], ' ');
  
  // Initialize columns
  int col_line = -1, col_dir = -1, col_path = -1, col_sun = -1, col_mon = -1, col_tue = -1, col_wed = -1, col_thu = -1, col_fri = -1, col_sat = -1;
  for (int i = 0; i < data_labels.length; i++) {
    if (match(data_labels[i],"Line") != null) {
      col_line = i;
    } else if (match(data_labels[i],"Direction") != null) {
      col_dir = i;
    } else if (match(data_labels[i],"Path") != null) {
      col_path = i;
    } else if (match(data_labels[i],"Sunday") != null) {
      col_sun = i;
    } else if (match(data_labels[i],"Monday") != null) {
      col_mon = i;
    } else if (match(data_labels[i],"Tuesday") != null) {
      col_tue = i;
    } else if (match(data_labels[i],"Wednesday") != null) {
      col_wed = i;
    } else if (match(data_labels[i],"Thursday") != null) {
      col_thu = i;
    } else if (match(data_labels[i],"Friday") != null) {
      col_fri = i;
    } else if (match(data_labels[i],"Saturday") != null) {
      col_sat = i;
    }
  }
  
  // Abort if no columns read "stop_ID" and "stop_lat" and "stop_lon"
  if (col_line == -1 || col_dir == -1 || col_path == -1 || col_sun == -1 || col_mon == -1 || col_tue == -1 || col_wed == -1 || col_thu == -1 || col_fri == -1 || col_sat == -1) {
    println ( "Error reading stops file in ReadStopsFile!");
    exit();
  }
  
  // Read in all the stops data
  for (int i = 1; i < lines.length; i++) {
    String[] route_data = split(lines[i], ' ');
    
    String route_ID = route_data[col_line] + " " + route_data[col_dir];
    String[] route_path = split(route_data[col_path], ',');
    
    String[] traf_sun_strings = split(route_data[col_sun], ',');
    int[] traf_sun = new int[day_divisions];
    for (int j = 0; j < day_divisions; j++) {
      traf_sun[j] = parseInt(traf_sun_strings[j]);
    }
    
    String[] traf_mon_strings = split(route_data[col_mon], ',');
    int[] traf_mon = new int[day_divisions];
    for (int j = 0; j < day_divisions; j++) {
      traf_mon[j] = parseInt(traf_mon_strings[j]);
    }
    
    String[] traf_tue_strings = split(route_data[col_tue], ',');
    int[] traf_tue = new int[day_divisions];
    for (int j = 0; j < day_divisions; j++) {
      traf_tue[j] = parseInt(traf_tue_strings[j]);
    }
    
    String[] traf_wed_strings = split(route_data[col_wed], ',');
    int[] traf_wed = new int[day_divisions];
    for (int j = 0; j < day_divisions; j++) {
      traf_wed[j] = parseInt(traf_wed_strings[j]);
    }
    
    String[] traf_thu_strings = split(route_data[col_thu], ',');
    int[] traf_thu = new int[day_divisions];
    for (int j = 0; j < day_divisions; j++) {
      traf_thu[j] = parseInt(traf_thu_strings[j]);
    }
    
    String[] traf_fri_strings = split(route_data[col_fri], ',');
    int[] traf_fri = new int[day_divisions];
    for (int j = 0; j < day_divisions; j++) {
      traf_fri[j] = parseInt(traf_fri_strings[j]);
    }
    
    String[] traf_sat_strings = split(route_data[col_sat], ',');
    int[] traf_sat = new int[day_divisions];
    for (int j = 0; j < day_divisions; j++) {
      traf_sat[j] = parseInt(traf_sat_strings[j]);
    }
    
    routes.addRoute(route_ID, route_path, traf_sun, traf_mon, traf_tue, traf_wed, traf_thu, traf_fri, traf_sat);
    
  }
  
  return(routes);
}

