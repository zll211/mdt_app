import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final bool loading;
  final Widget child;
  final String text='';
  ProgressDialog({Key key,@required this.child,@required this.loading,text})
      :assert(child != null),
       assert(loading != null),
       super(key:key);
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if(loading){
      widgetList.add(
        Opacity(
            opacity: 0.8,
            child: ModalBarrier(
            color:Colors.black87
          ),
        )
      );
      widgetList.add(Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              this.text.length>0 ? Text(this.text,style: TextStyle(color: Colors.white),):SizedBox(),
            ],
          ),
        )
      ));
    }
    return Stack(
      children: widgetList,
    );
  }
}
