import 'dart:developer';

import 'package:drawing_flutter/resizableWidge/resizable.dart';
import 'package:flutter/material.dart';

class ResizebleTextWidget extends StatefulWidget {
  ResizebleTextWidget({required this.child});

  final Widget child;
  @override
  _ResizebleTextWidgetState createState() => _ResizebleTextWidgetState();
}

const ballDiameter = 20.0;

class _ResizebleTextWidgetState extends State<ResizebleTextWidget> {
  double height = 0;
  double width = 200;
  double? initX;
  double? initY;

  double top = 0;
  double left = 0;

  void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }

  bool isselected = false;
  bool isrect = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: GestureDetector(
            onTapDown: (d) {
              setState(() {
                isselected = !isselected;
              });
            },
            onPanEnd: (d) {
              setState(() {
                isselected = true;
              });
            },
            onPanStart: (d) {
              initX = d.globalPosition.dx;
              initY = d.globalPosition.dy;
              setState(() {});
            },
            onPanUpdate: (d) {
              log(((d.globalPosition.dx - (width + left)) + left).toString());
              var dx = d.globalPosition.dx - initX!;
              var dy = d.globalPosition.dy - initY!;
              initX = d.globalPosition.dx;
              initY = d.globalPosition.dy;
              left = left + dx;
              top = top + dy;
              isselected = false;
              setState(() {});
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: isselected
                        ? Border.all(color: Color(0xffa32cc4))
                        : null),
                width: width,
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    "hello  asdasdas da sdsdf sdf sdfs asd asdasdasd asdasd",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40),
                  ),
                )),
            // center right
          ),
        ),

        // // bottom center
        // if (isselected)
        //   Positioned(
        //     top: top - (ballDiameter + 40) / 2,
        //     left: left + width / 2 - (ballDiameter + 40) / 2,
        //     child: ManipulatingBall(
        //       onDrag: (dx, dy) {
        //         var newHeight = height + dy;

        //         setState(() {
        //           height = newHeight > 0 ? newHeight : 0;
        //         });
        //       },
        //     ),
        //   ),
        // top left
        if (isselected)
          Positioned(
            top: top - (ballDiameter + 40) / 2,
            left: left - (ballDiameter + 40) / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var mid = (dx + dy) / 2;
                var newHeight = height - 2 * mid;
                var newWidth = width - 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0
                      ? newWidth.clamp(
                          40, MediaQuery.of(context).size.width + 40)
                      : 0;
                  top = top + mid;
                  left = left + mid;
                });
              },
            ),
          ),
        // center right
        // if (isselected)
        //   Positioned(
        //     top: 0,
        //     bottom: 0,
        //     left: left + width - (ballDiameter + 40) / 2,
        //     child: ManipulatingBall(
        //       onDrag: (dx, dy) {
        //         var newWidth = width + dx;

        //         setState(() {
        //           width = newWidth > 0
        //               ? newWidth.clamp(
        //                   40, MediaQuery.of(context).size.width + 40)
        //               : 0;
        //         });
        //       },
        //     ),
        //   ),

        // center center
        // Positioned(
        //   top: top + height / 2 - ballDiameter / 2,
        //   left: left + width / 2 - ballDiameter / 2,
        //   child: ManipulatingBall(
        //     onDrag: (dx, dy) {
        //       log("----$dx----$dy");
        //       setState(() {
        //         top = top + dy;
        //         left = left + dx;
        //       });
        //     },
        //   ),
        // ),
      ],
    );
  }
}
