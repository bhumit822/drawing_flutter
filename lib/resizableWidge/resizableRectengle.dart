import 'dart:developer';

import 'package:drawing_flutter/resizableWidge/resizable.dart';
import 'package:flutter/material.dart';

class ResizebleRectWidget extends StatefulWidget {
  ResizebleRectWidget({required this.child});

  final Widget child;
  @override
  _ResizebleRectWidgetState createState() => _ResizebleRectWidgetState();
}

const ballDiameter = 20.0;

class _ResizebleRectWidgetState extends State<ResizebleRectWidget> {
  double height = 100;
  double width = 100;
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
  double tl = 0;
  double tr = 0;
  double bl = 0;
  double br = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
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
              height: height,
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  border:
                      isselected ? Border.all(color: Color(0xffa32cc4)) : null),
              width: width,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(tl),
                  topRight: Radius.circular(tr),
                  bottomLeft: Radius.circular(bl),
                  bottomRight: Radius.circular(br),
                ),
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          ),
        ),
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
                  width = newWidth > 0 ? newWidth : 0;
                  top = top + mid;
                  left = left + mid;
                });
              },
            ),
          ),
        // top middle
        if (isselected)
          Positioned(
            top: top - (ballDiameter + 40) / 2,
            left: left + width / 2 - (ballDiameter + 40) / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var newHeight = height - dy;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  top = top + dy;
                });
              },
            ),
          ),
        // top right
        if (isselected)
          Positioned(
            top: top - (ballDiameter + 40) / 2,
            left: left + width - (ballDiameter + 40) / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var mid = (dx + (dy * -1)) / 2;

                var newHeight = height + 2 * mid;
                var newWidth = width + 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  top = top - mid;
                  left = left - mid;
                });
              },
            ),
          ),
        // center right
        if (isselected)
          Positioned(
            top: top + height / 2 - (ballDiameter + 40) / 2,
            left: left + width - (ballDiameter + 40) / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var newWidth = width + dx;

                setState(() {
                  width = newWidth > 0 ? newWidth : 0;
                });
              },
            ),
          ),
        // bottom right
        if (isselected)
          Positioned(
            top: top + height - (ballDiameter + 40) / 2,
            left: left + width - (ballDiameter + 40) / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var mid = (dx + dy) / 2;

                var newHeight = height + 2 * mid;
                var newWidth = width + 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  top = top - mid;
                  left = left - mid;
                });
              },
            ),
          ),
        // bottom center
        if (isselected)
          Positioned(
            top: top + height - (ballDiameter + 40) / 2,
            left: left + width / 2 - (ballDiameter + 40) / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var newHeight = height + dy;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                });
              },
            ),
          ),
        // bottom left
        if (isselected)
          Positioned(
            top: top + height - (ballDiameter + 40) / 2,
            left: left - (ballDiameter + 40) / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var mid = ((dx * -1) + dy) / 2;

                var newHeight = height + 2 * mid;
                var newWidth = width + 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  top = top - mid;
                  left = left - mid;
                });
              },
            ),
          ),
        //left center
        if (isselected)
          Positioned(
            top: top + height / 2 - (ballDiameter + 40) / 2,
            left: left - (ballDiameter + 40) / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var newWidth = width - dx;

                setState(() {
                  width = newWidth > 0 ? newWidth : 0;
                  left = left + dx;
                });
              },
            ),
          ),
        // center center
        // Positioned(
        //   top: top + height / 2 - (ballDiameter + 40) / 2,
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
