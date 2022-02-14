import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:overcome_breakup/constants/colors.dart';
import 'package:overcome_breakup/screens/home_screens.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:scribble/scribble.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class DrawingSheet extends StatefulWidget {
  const DrawingSheet({Key? key}) : super(key: key);

  @override
  State<DrawingSheet> createState() => _HomePageState();
}

class _HomePageState extends State<DrawingSheet> {
  late ScribbleNotifier notifier;

  @override
  void initState() {
    notifier = ScribbleNotifier();
    UnityAds.load(
      placementId: AdManager.interstitialVideoAdPlacementId,
      onComplete: (placementId) {
        print('Load Complete $placementId');
      },
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
    super.initState();
  }
ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            children: [
              Center(
                child: Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () async {
                          await _saveImage(context);
                        },
                        child: const Text("View Image")),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () async {
                          // await UnityAds.showVideoAd(placementId: AdManager.interstitialVideoAdPlacementId);
                          await _shareImage(context);
                        },
                        child: const Text("Share Image")),
                    const Spacer(),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Stack(
                  children: [
                    Screenshot(child: Container(
                      color: Colors.white,
                      child: Scribble(
                        notifier: notifier,
                        drawPen: true,
                      ),
                    ), controller: screenshotController) ,
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildStrokeToolbar(context),
                          const Text(
                            '''         ''',
                            style: TextStyle(),
                          ),
                          _buildColorToolbar(context),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      
    );
  }

  Future<void> _saveImage(BuildContext context) async {
    final image = await notifier.renderImage();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Your Image"),
        content: Image.memory(image.buffer.asUint8List(),),
      ),
    );
  }

  Future<void> _shareImage(BuildContext context) async {
    final image = await notifier.renderImage();
    Uint8List uint8List = image.buffer.asUint8List();
    final directory = (await getTemporaryDirectory ()).path; //from path_provide package
// String fileName = DateTime.now().microsecondsSinceEpoch.toString();

await screenshotController.captureAndSave(
    directory, //set path where screenshot will be saved
    fileName:'image.jpg' 
);
    // print(File.fromRawPath(uint8List).path);
    // final tempDir = await getTemporaryDirectory();
    // File file = await File('${tempDir.path}/image.jpg').create();
    // file.writeAsBytesSync(uint8List);
    print('$directory/image.jpg');
    Share.shareFiles(['$directory/image.jpg'], text: 'Check my Writing created from https://play.google.com/store/apps/details?id=com.alphabet.practice');
  }

  Widget _buildStrokeToolbar(BuildContext context) {
    return StateNotifierBuilder<ScribbleState>(
      stateNotifier: notifier,
      builder: (context, state, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
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
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Material(
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
    );
  }

  Widget _buildColorToolbar(BuildContext context) {
    Color avatarColor = Colors.black;
    return StateNotifierBuilder<ScribbleState>(
      stateNotifier: notifier,
      builder: (context, state, _) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        // scrollDirection: Axis.horizontal,
        children: [
          _buildPointerModeSwitcher(context,
              penMode:
                  state.allowedPointersMode == ScribblePointerMode.penOnly),
          const Divider(
            height: 4.0,
          ),
          _buildUndoButton(context),
          const Divider(
            height: 4.0,
          ),
          _buildClearButton(context),
          const Divider(
            height: 5.0,
          ),
          _buildEraserButton(context, isSelected: state is Erasing),
          // _buildColorButton(context, color: Colors.black, state: state),
          // _buildColorButton(context, color: Colors.red, state: state),
          InkWell(
              onTap: () {
                // notifier.setColor(Colors.black);
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: GridView.builder(
                          itemCount: colors.length,
                          itemBuilder: (context, index) {
                            final color = colors[index];
                            return Center(
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    avatarColor = color;
                                    notifier.setColor(color);
                                  });
                                },
                                leading: CircleAvatar(
                                  backgroundColor: color,
                                ),
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5),
                        ),
                      );
                    });
              },
              child: CircleAvatar(
                backgroundColor: avatarColor,
              )),
          // }, child: const Text("Color")),
          // _buildColorButton(context, color: Colors.green, state: state),
          // _buildColorButton(context, color: Colors.blue, state: state),
          // _buildColorButton(context, color: Colors.yellow, state: state),
        ],
      ),
    );
  }

  Widget _buildPointerModeSwitcher(BuildContext context,
      {required bool penMode}) {
    return FloatingActionButton.small(
      onPressed: () => notifier.setAllowedPointersMode(
        penMode ? ScribblePointerMode.all : ScribblePointerMode.penOnly,
      ),
      tooltip:
          "Switch drawing mode to " + (penMode ? "all pointers" : "pen only"),
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
    return Padding(
      padding: const EdgeInsets.all(4),
      child: FloatingActionButton.small(
        tooltip: "Erase",
        backgroundColor: const Color(0xFFF7FBFF),
        elevation: isSelected ? 10 : 2,
        shape: !isSelected
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
        child: const Icon(Icons.remove, color: Colors.blueGrey),
        onPressed: notifier.setEraser,
      ),
    );
  }

  Widget _buildColorButton(
    BuildContext context, {
    required Color color,
    required ScribbleState state,
  }) {
    final isSelected = state is Drawing && state.selectedColor == color.value;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: FloatingActionButton.small(
          backgroundColor: color,
          elevation: isSelected ? 10 : 2,
          shape: !isSelected
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
          child: Container(),
          onPressed: () => notifier.setColor(color)),
    );
  }

  Widget _buildUndoButton(
    BuildContext context,
  ) {
    return FloatingActionButton.small(
      tooltip: "Undo",
      onPressed: notifier.canUndo ? notifier.undo : null,
      disabledElevation: 0,
      backgroundColor: notifier.canUndo ? Colors.blueGrey : Colors.grey,
      child: const Icon(
        Icons.undo_rounded,
        color: Colors.white,
      ),
    );
  }

  Widget _buildRedoButton(
    BuildContext context,
  ) {
    return FloatingActionButton.small(
      tooltip: "Redo",
      onPressed: notifier.canRedo ? notifier.redo : null,
      disabledElevation: 0,
      backgroundColor: notifier.canRedo ? Colors.blueGrey : Colors.grey,
      child: const Icon(
        Icons.redo_rounded,
        color: Colors.white,
      ),
    );
  }

  Widget _buildClearButton(BuildContext context) {
    return FloatingActionButton.small(
      tooltip: "Clear",
      onPressed: notifier.clear,
      disabledElevation: 0,
      backgroundColor: Colors.blueGrey,
      child: const Icon(Icons.clear),
    );
  }
}
