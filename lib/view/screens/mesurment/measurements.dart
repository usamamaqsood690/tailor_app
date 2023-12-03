import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_app/view/screens/mesurment/mesurment_chart.dart';
import 'package:tailor_app/view_model/Measurement.dart';

// class Measurement {
//   final String details;
//   final String horizontalText1;
//   final String horizontalText2;

//   Measurement(this.details, this.horizontalText1, this.horizontalText2);
// }

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Measurement> measurements = [];
  List<Map<String, dynamic>> measurementList = [];

  @override
  void initState() {
    super.initState();
    loadLocalMeasurements();
    // fetchMeasurementData();
  }

  Future<void> loadLocalMeasurements() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> queuedMeasurements =
          prefs.getStringList('add_measurements') ?? [];

      setState(() {
        measurementList = queuedMeasurements
            .map((measurement) => jsonDecode(measurement))
            .cast<Map<String, dynamic>>()
            .toList();
      });

      print("Loaded Data: $measurementList");
    } catch (e) {
      print('Error: $e');
    }
  }

  // Future<void> fetchMeasurementData1() async {
  //   final response = await http.get(Uri.parse(
  //       'http://192.168.150.115:3005/api/measurementByUserId?user_id=91'));

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     print(' Data ' + responseData.length.toString());
  //     setState(() {
  //       measurements = [Measurement.fromJson(responseData)];
  //     });
  //   } else {
  //     throw Exception('Failed to load measurement data');
  //   }
  // }

// //  Shared Pref Category
//   Future<void> fetchMeasurementData() async {
//     // final SharedPreferences prefs = await SharedPreferences.getInstance();
//     // final String token = prefs.getString('access_token') ?? '';

//     // Map<String, String> headers = {
//     //   'Authorization': 'Bearer $token',
//     // };
//     final response = await http.get(
//       Uri.parse(
//           'http://192.168.150.115:3005/api/measurementByUserId?user_id=91'),
//     );

//     // print("Step 1: ${response.body}");

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = jsonDecode(response.body);
//       final List<dynamic> dataArray = data['measurements'];
//       final List<Measurement> chatagoriDataArray =
//           dataArray.map((jsonData) => Measurement.fromJson(jsonData)).toList();

//       // Convert Item instances to JSON-compatible maps
//       final List<Map<String, dynamic>> serializedData = chatagoriDataArray
//           .map((chatagoriItem) => chatagoriItem.toJson())
//           .toList();

//       setState(() {
//         measurements = chatagoriDataArray;
//       });

//       // Store the serialized data in SharedPreferences
//       // await prefs.setString('chatagoriDataArray', jsonEncode(serializedData));
//       print(serializedData);
//       // Now you have the chatagoriDataArray stored in SharedPreferences
//     } else {
//       print('API request failed with status: ${response.statusCode}.');
//     }
//   }

//Remove Complaint
  Future<void> removeMesurement(int index) async {
    print("Index remove :${index}");
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> deleteMesurement =
          prefs.getStringList('add_measurements') ?? [];

      print("Index remove :${deleteMesurement}");

      if (index >= 0 && index < deleteMesurement.length) {
        // if (deleteMesurement.contains(index)) {
        deleteMesurement.removeAt(index);
        await prefs.setStringList('add_measurements', deleteMesurement);
        print("Delete After :${deleteMesurement}");
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    double scHeight = MediaQuery.of(context).size.height;
    double scWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: scWidth / 40, vertical: scHeight / 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: scHeight / 17,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: .5,
                        blurRadius: 15,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search measurement by name or product',
                      filled: true,
                      helperStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: scWidth / 65,
                          vertical: scWidth / 55,
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.purple,
                          size: scWidth / 15,
                        ),
                      ),
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    cursorColor:
                        Colors.blue[100], // Change the color of the cursor
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: scHeight / 65),
          Container(
            width: scWidth / 3, // Adjust the width based on your requirements
            height:
                scHeight / 20, // Adjust the height based on your requirements
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Add New Measurement logic
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MesurementChart()));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      15.0), // Adjust the border radius to make it round
                ),
                backgroundColor: Colors.purple, // Customize the button color
                foregroundColor: Colors.white, // Customize the text color
              ),
              child: Container(
                  margin: EdgeInsets.all(scWidth / 40),
                  child: Text('+ Add New Measurement')),
            ),
          ),
          SizedBox(height: scHeight / 70),
          Container(
            width: scWidth, // Adjust the width based on your requirements
            height: scHeight / 1.55,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: measurementList.length,
              itemBuilder: (context, index) {
                // String base64Image = measurements[index].imageData;
                String base64Image = measurementList[index]['image'];

// Convert the Base64 string to a Uint8List
                // Uint8List bytes = base64.decode(base64Image);
                return Material(
                  color: Colors.black,
                  elevation: 65,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(scHeight / 80),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                360.0), // Adjust the border radius
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                360.0), // Same as the outer border radius
                            child: Container(
                              width: scWidth / 4,
                              height: scWidth / 4,
                              alignment: Alignment.center,
                              color: Colors.white, // Inner side color
                              padding: EdgeInsets.all(
                                  scWidth / 25), // Adjust padding as needed
                              child: Image.file(
                                File(base64Image),
                                errorBuilder: (context, error, stackTrace) {
                                  return Text("No Image Availabe");
                                },
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: scWidth / 40),
                              width: scWidth / 2.7,
                              child: RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Product Name: ',
                                      style: TextStyle(
                                          color: Colors.purple,
                                          // Change the color as per your preference
                                          fontWeight: FontWeight.bold,
                                          fontSize: scWidth / 40),
                                    ),
                                    TextSpan(
                                      text: measurementList[index]
                                          ['productName'],
                                      style: TextStyle(fontSize: scWidth / 40
                                          // Default text style here (e.g., color: Colors.black)
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: scWidth / 40),
                              width: scWidth / 2.7,
                              child: RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Description: ',
                                      style: TextStyle(
                                          color: Colors
                                              .purple, // Change the color as per your preference
                                          fontWeight: FontWeight.bold,
                                          fontSize: scWidth / 40),
                                    ),
                                    TextSpan(
                                      text: measurementList[index]
                                          ['description'],
                                      style: TextStyle(fontSize: scWidth / 40
                                          // Default text style here (e.g., color: Colors.black)
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: scWidth /
                                  5, // Adjust the width based on your requirements

                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  print("Navigation");
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => SaveMeasuremnet()));

                                  // Add New Measurement logic
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Adjust the border radius to make it round
                                  ),
                                  backgroundColor: Colors
                                      .purple, // Customize the button color
                                  foregroundColor:
                                      Colors.white, // Customize the text color
                                ),
                                child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: scWidth / 60),
                                    child: Text(
                                      'Update',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: scWidth / 45,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                            SizedBox(height: scHeight / 125),
                            Container(
                              width: scWidth /
                                  5, // Adjust the width based on your requirements

                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add New Measurement logic
                                  showAlertDialog(context, index);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Adjust the border radius to make it round
                                  ),
                                  backgroundColor: Colors
                                      .purple, // Customize the button color
                                  foregroundColor:
                                      Colors.white, // Customize the text color
                                ),
                                child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: scWidth / 60),
                                    child: Text(
                                      'Delete',
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: scWidth / 45,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context, mesureId) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: AlertDialog(
              title: const Text(
                'Delete?',
                textAlign: TextAlign.center,
              ),
              alignment: Alignment.center,
              content: const Text(
                  'Are you sure you want to delete this measurement?'),
              actions: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                          onPressed: () {
                            print("Index remove :${mesureId}");
                            setState(() {
                              removeMesurement(mesureId);
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 40),
                              child: const Text('Yes'))),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple),
                          onPressed: () {
                            Navigator.pop(context);
                            // Write code to delete item
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 40),
                              child: const Text('No'))),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
