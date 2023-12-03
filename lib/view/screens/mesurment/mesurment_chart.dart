import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:scribble/scribble.dart';
import 'package:tailor_app/constant.dart';
import 'package:tailor_app/view/screens/mesurment/save_measuremnet.dart';

class MesurementChart extends StatefulWidget {
  const MesurementChart({Key? key}) : super(key: key);

  @override
  State<MesurementChart> createState() => _MesurementChartState();
}

class _MesurementChartState extends State<MesurementChart> {
  late ScribbleNotifier notifier;
  Color updateColor = appcolor;

  @override
  void initState() {
    notifier = ScribbleNotifier();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scWidth = MediaQuery.of(context).size.width;
    final scHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: dfColor,
      appBar: AppBar(
        backgroundColor: appcolor,
        centerTitle: true,
        title: Text("New Measurements"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: "Save to Image",
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        height: scHeight,
        child: Column(
          children: [
            // _buildStrokeToolbar(context),
            Container(
                width: scWidth, // Adjust the width based on your requirements
                height: scHeight /
                    11.3, // Adjust the height based on your requirements
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: _buildColorToolbar(context)),
            SingleChildScrollView(
              child: SizedBox(
                width: scWidth, // Adjust the width based on your requirements
                height: scHeight /
                    1.25, // Adjust the height based on your requirements
                child: Container(
                  width: scWidth, // Adjust the width based on your requirements
                  height: scHeight /
                      1.25, // Adjust the height based on your requirements
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 0.5, color: blackColor)),
                  child: SizedBox(
                    height: scHeight / 11,
                    child: Container(
                      width:
                          scWidth, // Adjust the width based on your requirements
                      height: scHeight /
                          1.5, // Adjust the height based on your requirements

                      child: Scribble(
                        notifier: notifier,
                        drawPen: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Container(
            //   margin: EdgeInsets.symmetric(vertical: scHeight / 50),
            //   width:
            //       scWidth / 1.1, // Adjust the width based on your requirements
            //   height:
            //       scHeight / 20, // Adjust the height based on your requirements
            //   alignment: Alignment.bottomCenter,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Add New Measurement logic
            //       Navigator.of(context).push(MaterialPageRoute(
            //           builder: (context) => SaveMeasuremnet()));
            //     },
            //     style: ElevatedButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(
            //             15.0), // Adjust the border radius to make it round
            //       ),
            //       backgroundColor: Colors.purple, // Customize the button color
            //       foregroundColor: Colors.white, // Customize the text color
            //     ),
            //     child: Container(
            //         margin: EdgeInsets.symmetric(
            //             horizontal: scWidth / 25, vertical: scHeight / 65),
            //         child: Text('Submit Measuremnet')),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveImage(BuildContext context) async {
    final scWidth = MediaQuery.of(context).size.width;
    final image = await notifier.renderImage();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Measurements Perview",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: scWidth / 20),
        ),
        titleTextStyle: TextStyle(
            color: appcolor, fontSize: 25, fontWeight: FontWeight.w600),
        content: Image.memory(image.buffer.asUint8List()),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SaveMeasuremnet(ImageData:image)));
            },
            child: Text(
              "Next",
              style: TextStyle(color: dfColor),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: appcolor),
          )
        ],
      ),
    );
  }

  Widget _buildStrokeToolbar(BuildContext context) {
    double scHeight = MediaQuery.of(context).size.height;
    double scWidth = MediaQuery.of(context).size.width;
    return StateNotifierBuilder<ScribbleState>(
      stateNotifier: notifier,
      builder: (context, state, _) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final w in notifier.widths)
            _buildStrokeButton(
              context,
              strokeWidth: w,
              state: state,
            ),
        ],
      ),
    );
  }

  Widget _buildStrokeButton(
    BuildContext context, {
    required double strokeWidth,
    required ScribbleState state,
  }) {
    final selected = state.selectedWidth == strokeWidth;
    return Column(
      children: [
        Material(
          elevation: selected ? 4 : 0,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () => notifier.setStrokeWidth(strokeWidth),
            customBorder: const CircleBorder(),
            child: AnimatedContainer(
              duration: kThemeAnimationDuration,
              width: strokeWidth * 2,
              height: strokeWidth * 2,
              decoration: BoxDecoration(
                  color: state.map(
                    drawing: (s) => Color(s.selectedColor),
                    erasing: (_) => Colors.transparent,
                  ),
                  border: state.map(
                    drawing: (_) => null,
                    erasing: (_) => Border.all(width: 1),
                  ),
                  borderRadius: BorderRadius.circular(50.0)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorToolbar(BuildContext context) {
    return StateNotifierBuilder<ScribbleState>(
      stateNotifier: notifier,
      builder: (context, state, _) => Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _buildEraserButton(context, isSelected: state is Erasing),
              Text(
                "Erase",
                style: TextStyle(color: appcolor),
              )
            ],
          ),
          // Column(
          //   children: [
          //     _buildColorButton(context, color: Colors.black, state: state),
          //     Text(
          //       "Pen",
          //       style: TextStyle(color: appcolor),
          //     )
          //   ],
          // ),
          Column(
            children: [
              PopupMenuButton(
                icon: CircleAvatar(
                  backgroundColor: updateColor,
                  child: Image.asset(
                    'asserts/icons/colorfilter.png',
                  ),
                ),
                onSelected: (value) {
                  notifier.setColor(value);
                  updateColor = value;
                },
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.red,
                          ),
                          Text(
                            "Red",
                            style: TextStyle(color: blackColor),
                          ),
                        ],
                      ),
                      value: Colors.red,
                    ),
                    PopupMenuItem(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                          ),
                          Text(
                            "Black",
                            style: TextStyle(color: blackColor),
                          ),
                        ],
                      ),
                      value: Colors.black,
                    ),
                    PopupMenuItem(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green,
                          ),
                          Text(
                            "Green",
                            style: TextStyle(color: blackColor),
                          ),
                        ],
                      ),
                      value: Colors.green,
                    ),
                    PopupMenuItem(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                          ),
                          Text(
                            "Blue",
                            style: TextStyle(color: blackColor),
                          ),
                        ],
                      ),
                      value: Colors.blue,
                    ),
                  ];
                },
              ),
              // _buildColorButton(context, color: Colors.red, state: state),
              Text(
                "Pen",
                style: TextStyle(color: appcolor),
              )
            ],
          ),
          Column(
            children: [
              _buildUndoButton(context),
              Text(
                "Undo",
                style: TextStyle(color: appcolor),
              )
            ],
          ),

          // _buildRedoButton(context),

          Column(
            children: [
              _buildClearButton(context),
              Text(
                "Clear",
                style: TextStyle(color: appcolor),
              )
            ],
          ),

          // _buildPointerModeSwitcher(context,
          //     penMode:
          //         state.allowedPointersMode == ScribblePointerMode.penOnly),

          Column(
            children: [
              _buildSaveButton(context),
              Text(
                "Perview",
                style: TextStyle(color: appcolor),
              )
            ],
          ),
          // _buildColorButton(context, color: Colors.green, state: state),
          // _buildColorButton(context, color: Colors.blue, state: state),
          // _buildColorButton(context, color: Colors.yellow, state: state),
        ],
      ),
    );
  }

  Widget _buildPointerModeSwitcher(BuildContext context,
      {required bool penMode}) {
    return ElevatedButton(
      onPressed: () => notifier.setAllowedPointersMode(
        penMode ? ScribblePointerMode.all : ScribblePointerMode.penOnly,
      ),
      // tooltip:
      //     "Switch drawing mode to " + (penMode ? "all pointers" : "pen only"),
      child: AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: !penMode
            ? const Icon(
                Icons.touch_app,
                key: ValueKey(true),
              )
            : const Icon(
                Icons.do_not_touch,
                key: ValueKey(false),
              ),
      ),
    );
  }

  Widget _buildEraserButton(BuildContext context, {required bool isSelected}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: isSelected ? 10 : 2,
          backgroundColor: appcolor,
          shape: CircleBorder()),
      child: Image.asset(
        'asserts/icons/eras.png', // Replace 'your_image.png' with the actual path to your image in the assets folder
        color: dfColor, // Set your desired color
      ),
      onPressed: notifier.setEraser,
    );
  }

  Widget _buildColorButton(
    BuildContext context, {
    required Color color,
    required ScribbleState state,
  }) {
    final isSelected = state is Drawing && state.selectedColor == color.value;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: isSelected ? 10 : 2,
          backgroundColor: color,
          shape: isSelected
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
        ),
        // backgroundColor: color,
        // elevation: isSelected ? 10 : 2,

        child: Container(),
        onPressed: () => notifier.setColor(color));
  }

  Widget _buildUndoButton(BuildContext context) {
    return ElevatedButton(
      onPressed: notifier.canUndo ? notifier.undo : null,
      style: ElevatedButton.styleFrom(
          elevation: 2, backgroundColor: appcolor, shape: CircleBorder()),
      child: Image.asset(
        'asserts/icons/undo.png', // Replace 'your_image.png' with the actual path to your image in the assets folder
        color: dfColor, // Set your desired color
      ),
    );
  }

  Widget _buildRedoButton(
    BuildContext context,
  ) {
    return ElevatedButton(
      onPressed: notifier.canRedo ? notifier.redo : null,
      style: ElevatedButton.styleFrom(
          elevation: 2, backgroundColor: appcolor, shape: CircleBorder()),
      child: const Icon(
        Icons.redo_rounded,
        color: Colors.white,
      ),
    );
  }

  Widget _buildClearButton(BuildContext context) {
    return ElevatedButton(
      onPressed: notifier.clear,
      style: ElevatedButton.styleFrom(
          elevation: 2, backgroundColor: appcolor, shape: CircleBorder()),
      child: Image.asset(
        'asserts/icons/Trash.png', // Replace 'your_image.png' with the actual path to your image in the assets folder
        color: dfColor, // Set your desired color
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _saveImage(context),
      style: ElevatedButton.styleFrom(
          elevation: 2, backgroundColor: appcolor, shape: CircleBorder()),
      child: Image.asset(
        'asserts/icons/save.png', // Replace 'your_image.png' with the actual path to your image in the assets folder
        color: dfColor,
      ), // Set your desired color
    );
  }
}
