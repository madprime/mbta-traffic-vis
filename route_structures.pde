class StopLocation {
  String stop_ID;
  String stop_name;
  float latitude;
  float longitude;
  
  StopLocation(String passed_stop_ID, String passed_stop_name, float passed_latitude, float passed_longitude) {
    stop_ID = passed_stop_ID;
    stop_name = passed_stop_name;
    latitude = passed_latitude;
    longitude = passed_longitude;
  }
}

class StopLocations {
  HashMap stop_locations;
  
  StopLocations() {
    stop_locations = new HashMap();
  }
  
  void addStop(String passed_stop_ID, String passed_stop_name, float passed_latitude, float passed_longitude) {
    StopLocation new_stop = new StopLocation(passed_stop_ID, passed_stop_name, passed_latitude, passed_longitude);
    stop_locations.put(passed_stop_ID, new_stop);
  }
  
  StopLocation getStop(String stop_ID) {
    StopLocation stop = (StopLocation) stop_locations.get(stop_ID);
    return(stop);
  }
}
  
class RouteData {
  String route_ID;
  String[] path;
  int[] traffic_sunday;
  int[] traffic_monday;
  int[] traffic_tuesday;
  int[] traffic_wednesday;
  int[] traffic_thursday;
  int[] traffic_friday;
  int[] traffic_saturday;
  
  RouteData(String passed_route_ID, String[] passed_path, int[] passed_traf_sun, int[] passed_traf_mon, int[] passed_traf_tue, int[] passed_traf_wed, int[] passed_traf_thu, int[] passed_traf_fri, int[] passed_traf_sat) {
    route_ID = passed_route_ID;
    path = passed_path;
    traffic_sunday = passed_traf_sun;
    traffic_monday = passed_traf_mon;
    traffic_tuesday = passed_traf_tue;
    traffic_wednesday = passed_traf_wed;
    traffic_thursday = passed_traf_thu;
    traffic_friday = passed_traf_fri;
    traffic_saturday = passed_traf_sat;
  }
  
}

class Routes {
  HashMap routes;
  String[] route_IDs;
  
  Routes() {
    routes = new HashMap();
    route_IDs = new String[0];
  }
  
  void addRoute(String passed_route_ID, String[] passed_path, int[] passed_traf_sun, int[] passed_traf_mon, int[] passed_traf_tue, int[] passed_traf_wed, int[] passed_traf_thu, int[] passed_traf_fri, int[] passed_traf_sat) {
    RouteData new_route = new RouteData(passed_route_ID, passed_path, passed_traf_sun, passed_traf_mon, passed_traf_tue, passed_traf_wed, passed_traf_thu, passed_traf_fri, passed_traf_sat);
    routes.put(passed_route_ID, new_route);
    route_IDs = append(route_IDs, passed_route_ID);
  }
  
  RouteData getRoute(String route_ID) {
    RouteData route = (RouteData) routes.get(route_ID);
    return(route);
  }
  
  String[] getRouteIDs() {
    return(route_IDs);
  }
}
