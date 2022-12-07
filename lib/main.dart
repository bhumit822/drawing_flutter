import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:drawing_flutter/resizableWidge/resizableRectengle.dart';
import 'package:drawing_flutter/resizableWidge/resizableText.dart';
import 'package:flutter/material.dart';

import 'resizableWidge/resizable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class ShapeC {
  final String type;
  String? text;
  Offset start = Offset(0, 0);
  Offset? end = Offset(0, 0);
  ShapeC(
      {required this.type,
      this.start = const Offset(0, 0),
      this.end,
      this.text});
}

List<ShapeC> paints = [];
Offset start = Offset(0, 0);
Offset end = Offset(0, 0);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var height = 0.0;
  var width = 0.0;
  String action = "";
  int selected = -1;
  bool isInteract = false;

  TextEditingController _text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(child: LayoutBuilder(builder: (context, constraint) {
            height = constraint.maxHeight;
            width = constraint.maxWidth;
            return Container(
              height: height,
              width: width,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              alignment: Alignment.center,
              child: ClipRRect(
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: -5)
                      ]),
                    ),
                    ResizebleWidget(
                      child: Container(),
                    ),
                    ResizebleRectWidget(
                      child: Container(),
                    ),
                    ResizebleTextWidget(
                      child: Container(),
                    )
                  ]),
                ),
              ),
            );
          })),
          SizedBox(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        action = "Square";
                      });
                    },
                    icon: Text("Square"),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        action = "Circle";
                      });
                    },
                    icon: Text("Circle"),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        action = "Text";
                      });

                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _text,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      paints.add(ShapeC(
                                          type: action,
                                          start: Offset(width / 2, height / 2),
                                          end: Offset(500, 300),
                                          text: _text.text));
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Submit"),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    icon: Text("Text"),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        action = "Line";
                      });
                    },
                    icon: Text("Line"),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        action = "Resize";
                      });
                    },
                    icon: Text("Resize"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
