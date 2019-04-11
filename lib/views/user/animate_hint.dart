import 'package:flutter/material.dart';
import 'dart:async';

class AnimateHint extends StatefulWidget {
  final String text;
  final double top;
  AnimateHint({this.text,this.top});
  @override
  _AnimateHintState createState() => _AnimateHintState();
}

class _AnimateHintState extends State<AnimateHint> {
  double opacityLevel =1.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      // 背景色设置
//      color:Colors.transparent,
      //color:Color.fromARGB(130, 0, 0, 0),
      child: Center(
        child:  new AnimatedOpacity(// 使用一个AnimatedOpacity Widget
            opacity: opacityLevel,
            duration: new Duration(seconds: 1),//过渡时间：1
            child:new Container(
              margin:EdgeInsets.only(top:widget.top),
              padding:const EdgeInsets.symmetric(vertical: 14.0,horizontal: 13.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color:Color.fromARGB(150, 0, 0, 0),
              ),
              child:new Text(widget.text,style:TextStyle(color:Colors.white,fontSize: 14.0,decoration: TextDecoration.none)) ,)
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startAnimation();
    goBack();
  }
  Future startAnimation() async{
    if(!mounted) return;
    await Future.delayed(Duration(milliseconds: 500),(){
      if(!mounted) return;
      setState(() {
        opacityLevel = 0.0;
      });
    });
  }
  Future goBack() async{
    if(!mounted) return;
    await Future.delayed(Duration(seconds: 2),(){
      if(!mounted) return;
      Navigator.of(context).pop();
    });
  }
}
