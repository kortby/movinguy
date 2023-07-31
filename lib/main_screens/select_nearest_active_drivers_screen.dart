import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movinguy/global/global.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class SelectNearestActiveDriversScreen extends StatefulWidget {
  const SelectNearestActiveDriversScreen({Key? key}) : super(key: key);

  // const SelectNearestActiveDriverScreen({super.key});

  @override
  State<SelectNearestActiveDriversScreen> createState() =>
      _SelectNearestActiveDriversScreenState();
}

class _SelectNearestActiveDriverScreenState
    extends State<SelectNearestActiveDriversScreen> {
  get key => null;

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
            SystemNavigator.pop();
          },
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int idx) {
          return Card(
            key: key,
            color: Colors.grey,
            elevation: 3,
            shadowColor: Colors.cyan,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Image.asset(
                  'images/${dList[idx]['car_details']['car_type']}.png',
                  width: 70,
                ),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    dList[idx]['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    dList[idx]['car_details']['car_model'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                  ),
                  SmoothStarRating(
                    allowHalfRating: true,
                    onRatingChanged: (v) {
                      // rating = v;
                      setState(() {});
                    },
                    starCount: 5,
                    rating: 3.5,
                    size: 15.0,
                    filledIconData: Icons.blur_off,
                    halfFilledIconData: Icons.blur_on,
                    color: Colors.black,
                    borderColor: Colors.black,
                    spacing: 0.0,
                  ),
                ],
              ),
              trailing: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '3',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    '13 miles',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: dList.length,
      ),
    );
  }
}
