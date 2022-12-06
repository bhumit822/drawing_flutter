import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

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
            return SizedBox(
              height: constraint.maxHeight,
              width: constraint.maxWidth,
              child: GestureDetector(
                onTapDown: (d) {
                  if (paints.isNotEmpty && action == "") {
                    // log("from list ---->${paints[0].start}");
                    // log("from list ---->${paints[0].end}");

                    // final _height =
                    //     math.max(paints[0].start.dy, paints[0].end!.dy);
                    // final _width =
                    //     math.max(paints[0].start.dx, paints[0].end!.dx);

                    // final minw =
                    //     math.min(paints[0].start.dx, paints[0].end!.dx);
                    // final minh =
                    //     math.min(paints[0].start.dx, paints[0].end!.dx);
                    // log("tap detail ---->${_width > d.localPosition.dx && minw < d.localPosition.dx && _height > d.localPosition.dy && minh < d.localPosition.dy}");
                    // log("tap detail ---->${d.localPosition}");

                    final aa = paints.lastIndexWhere((e) {
                      final _height = math.max(e.start.dy, e.end!.dy);
                      final _width = math.max(e.start.dx, e.end!.dx);

                      final minw = math.min(e.start.dx, e.end!.dx);
                      final minh = math.min(e.start.dy, e.end!.dy);
                      log("tap detail ---->${_width > d.localPosition.dx && minw < d.localPosition.dx && _height > d.localPosition.dy && minh < d.localPosition.dy}");
                      return _width > d.localPosition.dx &&
                          minw < d.localPosition.dx &&
                          _height > d.localPosition.dy &&
                          minh < d.localPosition.dy;
                    });
                    if (aa >= 0) {
                      selected = aa;
                      isInteract = true;
                      // paints.removeAt(aa);
                    } else {
                      isInteract = false;
                    }
                    setState(() {});
                    log("---->$aa");
                  }
                  // paints.lastIndexWhere((e) =>);
                },
                onPanEnd: (d) {
                  setState(() {});
                  start = Offset(0, 0);
                  end = Offset(0, 0);
                  action = "";

                  setState(() {});
                },
                onPanStart: (d) {
                  setState(() {
                    if (action != "") {
                      isInteract = false;
                      start = d.localPosition;
                      paints
                          .add(ShapeC(type: action, start: start, end: start));
                    }
                  });
                  // log("pan start  -->$start");
                },
                onPanUpdate: (d) {
                  // log("pan update");
                  setState(() {
                    if (action != "") {
                      end = d.localPosition;
                      paints[paints.length - 1].end = end;
                    }
                  });
                  // log("pan update  --> ${end}");
                },
                child: CustomPaint(
                  foregroundPainter:
                      custompaint(index: selected, interact: isInteract),
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2022/11/24/02/28/clouds-7613361_960_720.png",
                    fit: BoxFit.cover,
                  ),
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

class custompaint extends CustomPainter {
  bool interact;
  int index;
  custompaint({required this.index, required this.interact});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3;
    for (var e in paints) {
      if (e.type == "Square") {
        canvas.drawRect(Rect.fromPoints(e.start, e.end!), paint);
      }
      if (e.type == "Circle") {
        canvas.drawOval(Rect.fromPoints(e.start, e.end!), paint);
        // canvas.drawCircle(e.start, (e.end!.dx - e.start.dx).abs(), paint);
      }
      if (e.type == "Line") {
        canvas.drawLine(e.start, e.end!, paint);
      }
      if (e.type == "Text") {
        TextPainter _t = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
              text: e.text,
              style: TextStyle(fontSize: 50, color: Colors.amber)),
        );

        _t.layout(
          minWidth: 0,
          maxWidth: size.width,
        );

        log("---->${size.width}");
        _t.paint(canvas, e.start);
      }
      if (interact && paints[index] == e) {
        final _paint = Paint()
          ..color = Colors.amber
          ..strokeWidth = 3;
        if (e.type != "Line") {
          canvas.drawCircle(e.start, 8, _paint);
          canvas.drawCircle(Offset(e.end!.dx, e.start.dy), 8, _paint);
          // canvas.drawCircle(
          //     Offset(
          //         e.end!.dx,
          //         (math.max(e.start.dy, e.end!.dy) -
          //                         math.min(e.start.dy, e.end!.dy))
          //                     .abs() /
          //                 2 +
          //             math.min(e.start.dy, e.end!.dy)),
          //     8,
          //     _paint);
          // canvas.drawOval(
          //     Rect.fromPoints(
          //         Offset(
          //             e.end!.dx - 5,
          //             (math.max(e.start.dy, e.end!.dy) -
          //                             math.min(e.start.dy, e.end!.dy))
          //                         .abs() /
          //                     2 +
          //                 math.min(e.start.dy, e.end!.dy) -
          //                 10),
          //         Offset(
          //             e.end!.dx + 5,
          //             ((math.max(e.start.dy, e.end!.dy) -
          //                             math.min(e.start.dy, e.end!.dy))
          //                         .abs() /
          //                     2) +
          //                 10 +
          //                 math.min(e.start.dy, e.end!.dy))),
          //     _paint);

          canvas.drawCircle(Offset(e.start.dx, e.end!.dy), 8, _paint);
          canvas.drawCircle(e.end!, 8, _paint);
          // final path = Path();
          // path.lineTo(e.start.dx, e.end!.dx);

          // canvas.drawPath(path, _paint);

          canvas.drawLine(Offset(e.start.dx, e.start.dy),
              Offset(e.end!.dx, e.start.dy), _paint);

          canvas.drawLine(Offset(e.end!.dx, e.start.dy),
              Offset(e.end!.dx, e.end!.dy), _paint);
          canvas.drawLine(Offset(e.end!.dx, e.end!.dy),
              Offset(e.start.dx, e.end!.dy), _paint);
          canvas.drawLine(Offset(e.start.dx, e.end!.dy),
              Offset(e.start.dx, e.start.dy), _paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// class pp extends BoxPainter{
//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {

//   }

// }

