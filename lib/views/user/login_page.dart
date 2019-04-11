import 'package:com.hzztai.mdt/common/services/user/user_service.dart';
import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
import 'package:com.hzztai.mdt/common/theme/theme.dart';
import 'package:flutter/material.dart';
import './progress_dialog.dart';
import 'dart:async';
import './input_widget.dart';
import './pop_route.dart';
import './animate_hint.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  with SingleTickerProviderStateMixin{
  final _userService = UserService();
  bool _loading = false;
  String _codeKey;
  String _loginType = 'password';

  final GlobalKey _globalKey = GlobalKey();

  Timer _timer;
  int _seconds = 60;
  String message = '获取验证码';
  RegExp phoneExp = new RegExp(r"^1[34578]\d{9}$");
//  RegExp phoneExp = new RegExp(r"/1[34578]$/");

  static FocusNode nameNode = FocusNode();
  static FocusNode passNode = FocusNode();
  static FocusNode phoneNode = FocusNode();
  static FocusNode validateNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController validateController = TextEditingController();

  Color buttonColor = Color(0xFFEBEEF3);
  TextStyle validateText = TextStyle(color:Color(0xFFA2A7AF));

  final List<Tab> loginTabs = <Tab>[
    Tab(text: '密码',),
    Tab(text: '验证码',),
  ];

  TabController _tabController;
  Widget passwordLogin(){
    return Container(
        child:Column(
          children: <Widget>[
          InputWidget(
            focusNode:nameNode,
            textEditingController:nameController,
            iconPath:CustomIcons.mobile,
            placeholder:'手机号/用户名',
          ),
          SizedBox(height:16.0),
          InputWidget(
            focusNode: passNode,
            textEditingController:passController,
            iconPath: CustomIcons.password,
            placeholder: '密码',
            isSecret: true,
          ),

          ],
        )
    );
  }
  Widget validateLogin(BuildContext context){
    return Container(
        child:Column(
          children: <Widget>[
            InputWidget(
              focusNode:phoneNode,
              textEditingController:phoneController,
              iconPath:CustomIcons.mobile,
              placeholder:'手机号',
            ),
            SizedBox(height:16.0),
            InputWidget(
              focusNode:validateNode,
              textEditingController:validateController,
              iconPath:CustomIcons.sms_code,
              placeholder:'验证码',
              suffixText: message,
              buttonColor: buttonColor,
              validateText: validateText,
              sendMessage: () async{
                if(phoneController.text?.length==11&&phoneExp.hasMatch(phoneController.text)){
                  if(message=='重新发送'||message=='获取验证码'){
                    Map<String,dynamic> param = {
                      'mobile':phoneController.text,
                    };

                    final res = await _userService.smsCode(params:param);
                    if(res.error.isEmpty){
                      _codeKey = res.data['sms_key'];
                      _startTimer();
                    }
                    else{
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

          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          elevation: 0.0,
//          backgroundColor: Colors.white,
//        ),
        body: ProgressDialog(
          text:'登录中...',
          loading: _loading,
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child:Container(
              color:Colors.white,
              padding:EdgeInsets.only(top:50.0),
              child:ListView(
                children: <Widget>[
                   Center(
                      child:Container(
                          height:92.0,
                          width:92.0,
                          child: Image.asset('lib/common/images/login/logo.png'),
                      )
                    ),

                  Container(
                      margin: EdgeInsets.only(top:20.0),
                      height: 230.0,
                      child:    Column(
                        children: <Widget>[
                          Container(
                            decoration:BoxDecoration(
                                border:Border(bottom:BorderSide(width:1.0,color:Color(0xFFEBEEF3)))
                            ),
                            child: Container(
                              padding:EdgeInsets.symmetric(horizontal: 16.0),
                              child: TabBar(
                                controller: _tabController,
                                tabs:loginTabs,
                                indicatorSize: TabBarIndicatorSize.label,
                                //未被选中的文字颜色
                                unselectedLabelColor: Colors.grey,
                                // 选中时的文字颜色
                                labelColor:primaryColor,
                                indicatorColor: primaryColor,
                                onTap: (val){

                                },
                              ),
                            )
                          ),

                          Expanded(
                              child:Padding(padding: EdgeInsets.only(left:32.0,right:32.0,top:20.0),
                                child:TabBarView(
                                    controller: _tabController,
                                    children: [
                                      passwordLogin(),
                                      validateLogin(context),
                                    ]),)

                          ),

                ],
              ),) ,
                   Container(
                     width:MediaQuery.of(context).size.width,
                     margin: EdgeInsets.only(left:32.0,right:32.0),
                     height:40.0,
                     child: RaisedButton(
                         child: Padding(
                           padding: EdgeInsets.only(top:8.0,bottom:8.0),
                           child: Text('登录',
                               style:TextStyle(fontSize: 16.0)),),
                         textColor:Colors.white,
                         color: Colors.lightBlue,
                         onPressed: () async{
                           // 让键盘收起来
                           FocusScope.of(context).requestFocus(FocusNode());

                           if(_tabController.index == 0){
                             if('${nameController.text}'.isEmpty||'${passController.text}'.isEmpty){
                               Navigator.of(context).push(PopRoute(
                                   child:AnimateHint(text:'请输入用户名或者密码',top:230.0)));
                             } else{
                               setState(() {
                                 _loading = true;
                               });
//                          print('name: $nameController.text, pass: $passController.text');
                               final _errorMsg = await _userService.login(username: '${nameController.text}', password: '${passController.text}');
                               setState(() {
                                 _loading = false;
                               });
                               if (_errorMsg.isEmpty) {
                                 Scaffold.of(context).showSnackBar(SnackBar(
                                   content: Text('登录成功'),
                                   duration: const Duration(milliseconds: 500),
                                 ));
                               } else {
                                 Navigator.of(context).push(PopRoute(
                                     child:AnimateHint(text:_errorMsg,top:230.0)));
                               }
                             }

                           }else if(_tabController.index == 1){
                             if('$_codeKey'.isEmpty||'${validateController.text}'.isEmpty){
                               Navigator.of(context).push(PopRoute(
                                   child:AnimateHint(text:'请输入手机号或验证码',top:230.0)));
                             } else {
                               setState(() {
                                 _loading =true;
                               });
//                          print('codeKey:$_codeKey,code:$validateController.text');
                               final _errorMsg = await _userService.loginByMobile(key: '$_codeKey', code: '${validateController.text}');
                               setState(() {
                                 _loading =false;
                               });
                               if (_errorMsg.isEmpty) {
                                 Scaffold.of(context).showSnackBar(SnackBar(
                                   content: Text('登录成功'),
                                   duration: const Duration(milliseconds: 500),
                                 ));
                               } else {
                                 Navigator.of(context).push(PopRoute(
                                     child:AnimateHint(text:'用户名或密码错误',top:230.0)));
                               }

                             }

                           }

                         }),
                   )
                ],
              )
            ),
          )
        )

    );
  }
  _startTimer(){
    if(message=='重新发送'||message=='获取验证码'){
      _timer = Timer.periodic(Duration(seconds: 1),
              (timer){
                if(!mounted){
                  return;
                }
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
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    phoneController.addListener((){
      if(phoneController.text?.length==11){
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
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }
}
