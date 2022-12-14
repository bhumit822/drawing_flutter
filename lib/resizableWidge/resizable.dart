import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall({Key? key, required this.onDrag});

  final Function onDrag;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  double? initX;
  double? initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        margin: EdgeInsets.all(20),
        width: ballDiameter,
        height: ballDiameter,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class ResizebleWidget extends StatefulWidget {
  ResizebleWidget({required this.child});

  final Widget child;
  @override
  _ResizebleWidgetState createState() => _ResizebleWidgetState();
}

const ballDiameter = 20.0;

class _ResizebleWidgetState extends State<ResizebleWidget> {
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
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
                  // color: Colors.red[100],
                  border:
                      isselected ? Border.all(color: Color(0xffa32cc4)) : null),
              width: width,
              child: ClipOval(
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    //   borderRadius: BorderRadius.circular(
                    //     math.max(height * height, width * width),
                    //   ),
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
        //   left: left + width / 2 - (ballDiameter + 40) / 2,
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
