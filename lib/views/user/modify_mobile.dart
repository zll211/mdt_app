import 'package:flutter/material.dart';
import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
import 'package:com.hzztai.mdt/common/services/user/user_service.dart';
import './input_widget.dart';
import 'dart:async';
import './animate_hint.dart';
import './pop_route.dart';

class ModifyMobile extends StatefulWidget {
  final String mobile;
  final int id;
  ModifyMobile(this.id,this.mobile);
  @override
  _ModifyMobileState createState() => _ModifyMobileState();
}

class _ModifyMobileState extends State<ModifyMobile> {

  final _userService = UserService();

  FocusNode phoneNode = FocusNode();
  FocusNode validateNode = FocusNode();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController validateController = TextEditingController();
  Color buttonColor = Color(0xFFEBEEF3);
  bool offstage = true;
  String message = '获取验证码';
  TextStyle validateText = TextStyle(color:Color(0xFFA2A7AF));
  String _codeKey;
  Timer _timer;
  bool enable = false;
  int _seconds = 60;
  String phoneText = '输入原手机号';
  RegExp phoneExp = new RegExp(r"/^1[34578]\d{9}$/");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('更换手机号',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 19.0)),
        centerTitle: true,
        leading: InkWell(
          child:Center(child:Icon(CustomIcons.arrow_left,size:24.0)),
          onTap: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body:SingleChildScrollView(
        child: Container(
            margin:EdgeInsets.only(top:100.0),
            padding:EdgeInsets.symmetric(horizontal: 24.0),
            height:200.0,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InputWidget(
                  focusNode:phoneNode,
                  textEditingController:offstage ? phoneController : mobileController,
                  iconPath:CustomIcons.mobile,
                  placeholder:phoneText,
                ),
                Offstage(
                  offstage: offstage,
                  child:  InputWidget(
                    focusNode:validateNode,
                    textEditingController:validateController,
                    iconPath:CustomIcons.sms_code,
                    placeholder:'验证码',
                    suffixText: message,
                    buttonColor: buttonColor,
                    validateText: validateText,
                    sendMessage: () async{
                      if(mobileController.text?.length==11&&phoneExp.hasMatch(mobileController.text)){
                        if(message=='重新发送'||message=='获取验证码'){
                          Map<String,dynamic> param = {
                            'mobile': mobileController.text,
                            'type':'modify',
                          };
                          final res = await _userService.smsCode(params:param);
                          if(res.error.isEmpty){
                            _codeKey = res.data['sms_key'];
                            _startTimer();
                          } else {
                            Navigator.of(context).push(PopRoute(
                                child:AnimateHint(text:res.error,top:230.0)));
                          }

                        } else {
                          Navigator.of(context).push(PopRoute(
                              child:AnimateHint(text:'验证码正在发送，请注意查收',top:230.0)));

                        }
                      } else {
                        Navigator.of(context).push(PopRoute(
                            child:AnimateHint(text:'请输入正确的手机号',top:230.0)));
                      }
                    },
                  ),
                ),
                Offstage(
                  offstage: !offstage,
                  child: Container(
                      height:40.0,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                          child:Text('下一步',style:TextStyle(color:Colors.white)),
                          color: Colors.lightBlue,
                          onPressed: phoneController.text.length==11 ? (){
                            FocusScope.of(context).requestFocus(FocusNode());
                            if(phoneController.text==widget.mobile){
                              setState(() {
                                phoneController.text = '';
                                phoneText = '输入新手机号';
                                offstage = false;
                              });
                            } else {
                              Navigator.of(context).push(PopRoute(
                                  child:AnimateHint(text:'请输入正确的手机号',top:230.0)));
                            }
                          } : null)
                  ),
                ),
                Offstage(
                  offstage: offstage,
                    child: Container(
                        height:40.0,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                            child:Text('确定',style:TextStyle(color:Colors.white)),
                            color: Colors.lightBlue ,
                            onPressed: mobileController.text.length==11&&validateController.text.isNotEmpty ? () async{
                              if(mobileController.text.length==11&&validateController.text.isNotEmpty){
                                //发送修改手机号的请求
                                Map<String,dynamic> param = {
                                  'code':validateController.text,
                                  'sms_key':_codeKey
                                };
                                final error = await _userService.modifyMobile(param);
                                if(error.isEmpty){
                                  Navigator.of(context).push(PopRoute(
                                      child:AnimateHint(text:'修改成功',top:230.0)));
                                  Navigator.of(context).pop();
                                } else {
                                  Navigator.of(context).push(PopRoute(
                                      child:AnimateHint(text:error,top:230.0)));
                                }
                              } else {
                                Navigator.of(context).push(PopRoute(
                                    child:AnimateHint(text:'请输入正确的信息',top:230.0)));
                              }
                            }: null)
                    )
                )
              ],
            )
        ),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    phoneController.addListener((){
      if(phoneController.text==widget.mobile){
        setState(() {
          enable = true;
        });
      } else {
        setState(() {
          enable = false;
        });
      }
    });
    mobileController.addListener((){
      if(mobileController.text?.length==11){
        if(!mounted){
          return;
        }
        setState(() {
          buttonColor = Color(0xFF609EFE);
          validateText = TextStyle(color:Color(0xFFFFFFFF));
        });
      } else {
        if(!mounted){
          return;
        }
        setState(() {
          buttonColor = Color(0xFFEBEEF3);
          validateText = TextStyle(color:Color(0xFFA2A7AF));
        });
      }
    });
    validateController.addListener((){
        setState(() {
        });
    });
  }

  _startTimer(){
    if(message=='重新发送'||message=='获取验证码'){
      _timer = Timer.periodic(Duration(seconds: 1),
              (timer){
            if(_seconds == 0){
              _cancelTimer();
              setState(() {
                _seconds = 60;
                message = '重新发送';
                buttonColor = Color(0xFF609EFE);
                validateText = TextStyle(color:Color(0xFFFFFFFF));
              });
              return;
            }
            setState(() {
              buttonColor = Color(0xFFEBEEF3);
              validateText = TextStyle(color:Color(0xFFA2A7AF));
              _seconds--;
              message = '$_seconds'+'s后重发';
            });
          });
    }

  }
  _cancelTimer(){
    _timer?.cancel();
  }
  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }
}
