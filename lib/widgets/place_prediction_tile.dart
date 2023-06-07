import 'package:flutter/material.dart';
import 'package:movinguy/assistants/request_assistant.dart';
import 'package:movinguy/global/map_key.dart';
import 'package:movinguy/infoHandler/app_info.dart';
import 'package:movinguy/models/directions.dart';
import 'package:movinguy/models/predicted_places.dart';
import 'package:movinguy/widgets/progress_dialog.dart';
import 'package:provider/provider.dart';

class PlacePredictionTile extends StatelessWidget {
  final PredictedPlaces? predictedPlaces;

  const PlacePredictionTile({Key? key, this.predictedPlaces}) : super(key: key);

  getPlaceDirectionDetails(String placeId, context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        message: 'Setting up drop off locations, Please Wait...',
      ),
    );
    String placeDirectionDetails =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey';
    var res = await RequestAssistant.receiveRequest(placeDirectionDetails);

    Navigator.pop(context);

    if (res == 'Error Occurred, Failed. No Response.') {
      return;
    }
    if (res['status'] == 'OK') {
      Directions directions = Directions();
      directions.locationId = placeId;
      directions.locationName = res['result']['name'];
      directions.locationLatitude =
          res['result']['geometry']['location']['lat'];
      directions.locationLongitude =
          res['result']['geometry']['location']['lng'];

      Provider.of<AppInfo>(context, listen: false)
          .updateDropOffLocationAddress(directions);
      Navigator.pop(context, 'obtainDropOff');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.white10),
      onPressed: () {
        getPlaceDirectionDetails(predictedPlaces!.place_id!, context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(
              Icons.add_location,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                  predictedPlaces!.main_text!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white54,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  predictedPlaces!.secondary_text!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
