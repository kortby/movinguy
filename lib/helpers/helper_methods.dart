import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movinguy/assistants/request_assistant.dart';
import 'package:movinguy/global/global.dart';
import 'package:movinguy/global/map_key.dart';
import 'package:movinguy/models/direction_details_info.dart';
import 'package:movinguy/models/user_model.dart';

class HelperMethods {
  static void readCurrentOnlineInfo() async {
    currentFirebaseUser = FirebaseAuth.instance.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(currentFirebaseUser!.uid);
    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        userModelCurrentUser = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }

  static Future<DirectionDetailsInfo?> obtainOriginToDestinationDirectionDetail(
      LatLng originPosition, LatLng destinationPosition) async {
    String urlDirection =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${originPosition.latitude},${originPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=$mapKey';
    var res = await RequestAssistant.receiveRequest(urlDirection);

    if (res == 'Error Occurred, Failed. No Response.') {
      return null;
    }

    DirectionDetailsInfo directionDetailsInfo = DirectionDetailsInfo();
    directionDetailsInfo.e_points =
        res['routes'][0]['overview_polyline']['points'];
    directionDetailsInfo.distance_text =
        res['routes'][0]['legs'][0]['distance']['text'];
    directionDetailsInfo.distance_value =
        res['routes'][0]['legs'][0]['distance']['value'];

    directionDetailsInfo.duration_text =
        res['routes'][0]['legs'][0]['duration']['text'];
    directionDetailsInfo.duration_value =
        res['routes'][0]['legs'][0]['duration']['value'];

    return directionDetailsInfo;
  }
}
