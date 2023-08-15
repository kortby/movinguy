import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movinguy/global/global.dart';
import 'package:movinguy/helpers/helper_methods.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class SelectNearestActiveDriversScreen extends StatefulWidget {
  DatabaseReference? referenceRideRequest;

  SelectNearestActiveDriversScreen({super.key, this.referenceRideRequest});

  @override
  State<SelectNearestActiveDriversScreen> createState() =>
      _SelectNearestActiveDriversScreenState();
}

class _SelectNearestActiveDriversScreenState
    extends State<SelectNearestActiveDriversScreen> {
  get key => null;
  String fareAmount = '';

  getFareAmountAccordingToVehicleType(int index) {
    if(tripDirectionDetailsInfo != null) {
      if(dList[index]['car_details']['car_type'].toString() == 'taxi-big') {
        fareAmount = (HelperMethods.calculateFareAmountFromOriginToDestination(tripDirectionDetailsInfo!) * 2).toString();
      }
      if(dList[index]['car_details']['car_type'].toString() == 'taxi-small') {
        fareAmount = HelperMethods.calculateFareAmountFromOriginToDestination(tripDirectionDetailsInfo!).toString();
      }
    }
    return fareAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: const Text(
          'Nearest Online Drivers',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            // delete the request
            widget.referenceRideRequest!.remove();
            Fluttertoast.showToast(msg: 'You have cancelled the ride request.');
            SystemNavigator.pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: dList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                chosenDriverId = dList[index]['id'].toString();
              });
              Navigator.pop(context, 'driverChosen');
            },
            child: Card(
              key: key,
              color: Colors.grey,
              elevation: 3,
              shadowColor: Colors.cyan,
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Image.asset(
                    'images/${dList[index]['car_details']['car_type']}.png',
                    width: 70,
                  ),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${dList[index]['name']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '${dList[index]['car_details']['model']}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                    SmoothStarRating(
                      rating: 3.5,
                      color: Colors.black,
                      borderColor: Colors.black,
                      allowHalfRating: true,
                      starCount: 5,
                      size: 15,
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$${getFareAmountAccordingToVehicleType(index)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      tripDirectionDetailsInfo != null ? tripDirectionDetailsInfo!.duration_text! : '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      tripDirectionDetailsInfo != null ? tripDirectionDetailsInfo!.distance_text! : '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
