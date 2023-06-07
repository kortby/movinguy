import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:movinguy/infoHandler/app_info.dart';
import 'package:movinguy/models/directions.dart';
import 'package:provider/provider.dart';

class RequestAssistant {
  static Future<String> searchAddressForGeographicCoOrdinates(
      Position position, context) async {
    String apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyABakRpVE4IjAVwfUmL8zrb9OsOfAmUFSA';
    String humanReadableAddress = '';
    var response = await RequestAssistant.receiveRequest(apiUrl);
    if (response != 'Error Occurred, Failed. No Response.') {
      humanReadableAddress = response['results'][0]['formatted_address'];
      Directions userPickUpAddress = Directions();
      userPickUpAddress.locationLatitude = position.latitude;
      userPickUpAddress.locationLongitude = position.longitude;
      userPickUpAddress.locationName = humanReadableAddress;
      Provider.of<AppInfo>(context, listen: false)
          .updatePickUpLocationAddress(userPickUpAddress);
    }
    return humanReadableAddress;
  }

  static Future<dynamic> receiveRequest(String url) async {
    http.Response httpResponse = await http.get(Uri.parse(url));

    try {
      if (httpResponse.statusCode == 200) {
        String resData = httpResponse.body; // json
        var decodeResponseData = jsonDecode(resData);
        return decodeResponseData;
      } else {
        return 'Error Occurred, Failed. No Response.';
      }
    } catch (exp) {
      return 'Error Occurred, Failed. No Response.';
    }
  }
}
