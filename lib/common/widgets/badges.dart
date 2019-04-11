import 'package:flutter/material.dart';

class Badges extends StatelessWidget {
  final Widget child;
  final int count;
  final Color color;
  final bool dot;

  Badges({this.child, this.count: 0, this.color: Colors.redAccent, this.dot: false});

  @override
  Widget build(BuildContext context) {
    return count != null && count > 0
        ? Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              this.child,
              dot
                  ? Positioned(
                      right: -10,
                      top: 0,
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      ),
                    )
                  : Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                            child: Text(
                          count.toString(),
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        )),
                      ),
                    )
            ],
          )
        : this.child;
  }
}
