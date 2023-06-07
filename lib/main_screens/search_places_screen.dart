import 'package:flutter/material.dart';
import 'package:movinguy/assistants/request_assistant.dart';
import 'package:movinguy/global/map_key.dart';
import 'package:movinguy/models/predicted_places.dart';
import 'package:movinguy/widgets/place_prediction_tile.dart';

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({Key? key}) : super(key: key);

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  List<PredictedPlaces> placesPredictedList = [];

  void findPlaceAutoCompleteSearch(String inputText) async {
    if (inputText.length > 2) {
      String urlSearch =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapKey&components=country:US';
      var res = await RequestAssistant.receiveRequest(urlSearch);
      if (res != 'Error Occurred, Failed. No Response.' &&
          res['status'] == 'OK') {
        var placesPredictions = res['predictions'];

        var predictedList = (placesPredictions as List)
            .map((jsonData) => PredictedPlaces.fromJson(jsonData))
            .toList();
        setState(() {
          placesPredictedList = predictedList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Colors.black54,
              boxShadow: [
                BoxShadow(
                  color: Colors.white54,
                  blurRadius: 8,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Center(
                        child: Text(
                          'Search & Set Drop off location',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.adjust_sharp,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (val) {
                            findPlaceAutoCompleteSearch(val);
                          },
                          decoration: const InputDecoration(
                              hintText: 'Search here...',
                              fillColor: Colors.white54,
                              filled: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 11,
                                top: 8,
                                bottom: 8,
                              )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          placesPredictedList.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                  itemBuilder: (context, index) {
                    return PlacePredictionTile(
                      predictedPlaces: placesPredictedList[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 1,
                      color: Colors.grey,
                      thickness: 1,
                    );
                  },
                  physics: ClampingScrollPhysics(),
                  itemCount: placesPredictedList.length,
                ))
              : Container(),
        ],
      ),
    );
  }
}
