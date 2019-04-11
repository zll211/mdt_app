import 'package:flutter/material.dart';
import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
class InputWidget extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final IconData iconPath;
  final String placeholder;
  final bool isSecret;
  final String suffixText;
  final bool sendEnabled;
  final Color buttonColor;
  final TextStyle validateText;
  final Function sendMessage;
  InputWidget({Key key,
    this.focusNode,
    this.textEditingController,
    this.iconPath,
    this.placeholder,
    this.isSecret = false,
    this.suffixText = '',
    this.sendEnabled,
    this.buttonColor,
    this.validateText,
    this.sendMessage,
  });
  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool _focus = false;
  bool _see = false;
  bool _obscuretext =true;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener((){
      if(widget.focusNode.hasFocus){
        if(!mounted){
          return;
        }
        setState(() {
          _focus = true;
        });
      } else {
        if(!mounted){
          return;
        }
        setState(() {
          _focus = false;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: _focus ? BorderSide(color:Colors.blue,width:1.0) : BorderSide(color:Color(0xFFEBEEF3),width:1.0)
        )
      ),
      child: widget.suffixText.isEmpty ? TextField(
        focusNode: widget.focusNode,
        controller: widget.textEditingController,
        obscureText: _obscuretext&&widget.isSecret,
          decoration: InputDecoration(
            hintText: widget.placeholder,
              hintStyle:TextStyle(fontSize: 14.0,color:Color(0xFFA2A7AF)),
              border:InputBorder.none,
            prefixIcon:Icon(widget.iconPath,size:20.0,),
            suffixIcon: widget.isSecret ? IconButton(
              icon:_see ? Icon(CustomIcons.eyes_open,size:20.0,) : Icon(CustomIcons.eyes_close,size:20.0),
              onPressed: (){
                setState(() {
                  _see=!_see;
                  _obscuretext =!_obscuretext;
                });
              },): null
          ),
      ) : Row(
        children: <Widget>[
          Expanded(
            child:TextField(
              controller: widget.textEditingController,
              focusNode: widget.focusNode,
              decoration: InputDecoration(
                  hintText: widget.placeholder,
                  hintStyle:TextStyle(fontSize: 14.0,color:Color(0xFFA2A7AF)),
                  border:InputBorder.none,
                  prefixIcon:Icon(widget.iconPath,size:20.0,),
              ),
            ),
          ),
          Container(
            child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 8.0),
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(const Radius.circular(4.0)),
                ),
                color: widget.buttonColor,
                onPressed: widget.sendMessage,
                child: Text(widget.suffixText,style:widget.validateText)
            ),
          )
        ],
      )
    );
  }
}

