import '../models/active_near_by_available_drivers.dart';

class GeoFireAssistant {
  static List<ActiveNearByAvailableDrivers> activeNearByAvailableDriversList = [];

  static void deleteOfflineDriverFromList(String driverId) {
    int indexNumber = activeNearByAvailableDriversList.indexWhere((element) => element.driverId == driverId);
    activeNearByAvailableDriversList.removeAt(indexNumber);
  }

  static void updateActiveNearByAvailableDriverLocation(ActiveNearByAvailableDrivers driver) {
    int indexNumber = activeNearByAvailableDriversList.indexWhere((element) => element.driverId == driver.driverId);
    activeNearByAvailableDriversList[indexNumber].locationLatitude = driver.locationLatitude;
    activeNearByAvailableDriversList[indexNumber].locationLongitude = driver.locationLongitude;
  }
}