import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_app/animated_checkmark_dialog.dart';
import 'package:tailor_app/constant.dart';
import 'package:tailor_app/view/screens/dashboard/bottom_nav_bar.dart';

// import 'package:http/http.dart' as http;

class SaveMeasuremnet extends StatelessWidget {
  final ImageData;
  SaveMeasuremnet({required this.ImageData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: appcolor,
          centerTitle: true,
          title: Text("New Measurements"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
            child: MeasuremnetWidget(
          ImageData: ImageData,
        )),
      ),
    );
  }
}

class MeasuremnetWidget extends StatefulWidget {
  final ImageData;
  MeasuremnetWidget({required this.ImageData});
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MeasuremnetWidget> {
  // Dummy items for the spinner
  List<String> dummyItems = [
    'Select',
    'Shirt',
    'Kameez',
    'Shalwar',
  ];
  bool _isLoading = false;
  // Selected item in the spinner
  String selectedItem = 'Select';

  String typeProduct = "";
  String productDescrp = "";

  @override
  Widget build(BuildContext context) {
    double scHeight = MediaQuery.of(context).size.height;
    double scWidth = MediaQuery.of(context).size.width;
    return Container(
      // width: scWidth / 1.15,
      margin: EdgeInsets.symmetric(
          horizontal: scWidth / 20, vertical: scHeight / 30),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: scWidth / 3.1,
            height: scWidth / 3.1,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(360.0), // Adjust the border radius
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  360.0), // Same as the outer border radius
              child: Container(
                width: scWidth / 3.1,
                height: scWidth / 3.1,
                alignment: Alignment.center,
                color: Colors.white, // Inner side color
                padding:
                    EdgeInsets.all(scWidth / 25), // Adjust padding as needed
                child: Image.memory(widget.ImageData.buffer.asUint8List()),

                // Text(
                //   "Mesurments Details",
                //   style: TextStyle(
                //       fontSize: scWidth / 30, fontWeight: FontWeight.bold),
                //   textAlign: TextAlign.center, // Center the text vertically
                // ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: Text(
              "New Measurements Details!",
              style: TextStyle(
                  fontSize: scWidth / 22, fontWeight: FontWeight.w500),
            ),
          ),

          // Spinner with White Background and Shadow
          Material(
            borderRadius: BorderRadius.circular(22),
            child: Container(
              // width: scWidth / 1.15,
              padding: EdgeInsets.symmetric(
                  horizontal: scWidth / 40, vertical: scHeight / 110),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'asserts/icons/product_name.png', // Replace 'your_image.png' with the actual path to your image in the assets folder
                    color: appcolor,
                  ), // Set your desired color
                  Container(
                    height: scHeight / 50,
                    width: 2,
                    color: Colors.blue[100],
                  ),
                  Container(
                    width: scWidth / 1.4,
                    child: DropdownButton<String>(
                      underline: Container(),
                      padding: EdgeInsets.all(0),
                      value: selectedItem,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItem = newValue!;
                        });
                      },
                      items: dummyItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      icon: Icon(
                        Icons
                            .keyboard_arrow_down, // Custom icon (you can replace it with your custom icon)
                        color: appcolor, // Customize the icon color
                      ),
                      iconSize: 34, // Adjust the icon size as needed
                      isExpanded:
                          true, // Set to true to make the dropdown fill the width of its parent
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Product Name Field with White Background, Rounded Border, and Shadow
          SizedBox(height: scHeight / 40),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: scWidth / 40, vertical: scHeight / 110),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'asserts/icons/product_name_write.png', // Replace 'your_image.png' with the actual path to your image in the assets folder
                  color: appcolor,
                ), // Set your desired color
                Container(
                  height: scHeight / 50,
                  width: 2,
                  color: Colors.blue[100],
                ),
                Container(
                  width: scWidth / 1.4,
                  child: TextField(
                    onChanged: (value) {
                      typeProduct = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      hintText: 'Type Product Name if not found',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Add rounded border
                        borderSide: BorderSide.none,
                        // Remove the border line
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

// Product Description Field with White Background, Rounded Border, and Shadow

          // Product Name Field with White Background, Rounded Border, and Shadow
          SizedBox(height: scHeight / 40),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: scWidth / 40, vertical: scHeight / 110),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'asserts/icons/measurement_description.png', // Replace 'your_image.png' with the actual path to your image in the assets folder
                  color: appcolor,
                ), // Set your desired color
                Container(
                  height: scHeight / 50,
                  width: 2,
                  color: Colors.blue[100],
                ),
                Container(
                  width: scWidth / 1.4,
                  child: TextField(
                    onChanged: (value) {
                      productDescrp = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      hintText: 'Write Description',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Add rounded border
                        borderSide: BorderSide.none, // Remove the border line
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: scHeight / 40),
          Container(
            width: scWidth / 1, // Adjust the width based on your requirements
            height:
                scHeight / 12, // Adjust the height based on your requirements
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                print("Press Ok");
                // postMeasurementData();
                Random random = Random();

                int randomId = random.nextInt(1000);

                //------------------//////////
                Uint8List imageDataBytes =
                    widget.ImageData.buffer.asUint8List();

                // Get the application documents directory
                Directory appDocumentsDirectory =
                    await getApplicationDocumentsDirectory();

                String uniqueIdentifier =
                    DateTime.now().millisecondsSinceEpoch.toString();

                // Create a File from the image data in the documents directory
                File imageFile = File(
                    '${appDocumentsDirectory.path}/image_$uniqueIdentifier.jpg');

                await imageFile.writeAsBytes(imageDataBytes);

                ////-----------------////////////

                Map<String, dynamic> mesurementData = {
                  'tagId': randomId,
                  'productName': selectedItem.toString(),
                  'description': productDescrp.toString(),
                  'user_id': '91',
                  'image': imageFile.path,
                };

                savelocalMesument(mesurementData);
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
                  margin: EdgeInsets.symmetric(
                      horizontal: scWidth / 3, vertical: scHeight / 50),
                  child: Text(
                    'Save',
                    style: TextStyle(
                        fontSize: scWidth / 25, fontWeight: FontWeight.w600),
                  )),
            ),
          ),

          SizedBox(height: scHeight / 45),
          Container(
            width: scWidth / 1, // Adjust the width based on your requirements
            height:
                scHeight / 12, // Adjust the height based on your requirements
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                // Add New Measurement logic
                print("new press");
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
                  margin: EdgeInsets.symmetric(
                      horizontal: scWidth / 10, vertical: scHeight / 50),
                  child: Text(
                    'Save and New Measurement',
                    style: TextStyle(
                        fontSize: scWidth / 25, fontWeight: FontWeight.w600),
                  )),
            ),
          ),
        ],
      ),
    );
  }

//Store local complaints
  Future<void> savelocalMesument(Map<String, dynamic> complaint) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> queuedComplaints =
          prefs.getStringList('add_measurements') ?? [];
      queuedComplaints.add(jsonEncode(complaint));
      await prefs.setStringList('add_measurements', queuedComplaints);

      print("SAve Data : ${queuedComplaints}");

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => BottomNavBar()));
    } catch (e) {
      print('Error: $e');
      // Handle the error appropriately
    }
  }

// //Online Upload Data
//   Future<void> postMeasurementData() async {
//     final Uri url = Uri.parse('http://192.168.150.115:3005/api/newMeasurement');

//     // Convert _ByteDataView to Uint8List
//     Uint8List imageDataBytes = widget.ImageData.buffer.asUint8List();

//     // Get the application documents directory
//     Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

//     // Create a File from the image data in the documents directory
//     File imageFile = File('${appDocumentsDirectory.path}/image.jpg');

//     await imageFile.writeAsBytes(imageDataBytes);

//     if (selectedItem == 'Select') {
//       selectedItem = typeProduct;
//     }

//     // Your data to be posted
//     Map<String, String> data = {
//       'productName': '$selectedItem',
//       'description': '$productDescrp',
//       'user_id': '91',
//     };

//     // Attach the image file to the request
//     var request = http.MultipartRequest('POST', url)
//       ..headers['Content-Type'] = 'application/json; charset=UTF-8'
//       ..fields.addAll(data)
//       ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

//     try {
//       final response = await request.send();

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print('POST request successful');
//         print('Response: ${await response.stream.bytesToString()}');

//         showAnimatedCheckmarkDialog(
//             context, 'Data Uploaded Successfully!', appcolor);
//         _isLoading = false;
//         await Future.delayed(Duration(seconds: 1));

//         final route = MaterialPageRoute(builder: (context) => BottomNavBar());
//         Navigator.pushAndRemoveUntil(context, route, (route) => false);
//       } else {
//         print('POST request failed with status: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error making POST request: $error');
//     }
//   }
}
