import 'package:flutter/material.dart';
import 'package:com.hzztai.mdt/common/models/UserModel.dart';
import 'package:com.hzztai.mdt/common/services/user/user.dart';
import 'package:com.hzztai.mdt/common/services/user/user_service.dart';
import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
import './modify_username.dart';
import './modify_mobile.dart';
import './animate_hint.dart';
import './pop_route.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
typedef callBack = Function();
class UserInfoPage extends StatefulWidget {
  final int id;
  UserInfoPage(this.id);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {

  final userService = UserService();
  String mobile = '';


  @override
  Widget build(BuildContext context) {
    final _userService = UserModel.of(context, 'user').userService;
    return Scaffold(
      appBar: AppBar(
        title: Text('个人信息'),
        centerTitle: true,
      ),
      body:Container(
          child: StreamBuilder<User>(
              stream: _userService.user$,
              builder: (context, snapshot) {
                User _user = User();
                if (snapshot.hasData) {
                  _user = snapshot.data;
                  if(_user.mobile.isNotEmpty){
                    mobile = _user.mobile.substring(0,3)+'****'+_user.mobile.substring(7,11);
                  }

                }
                return ListView(
                  children: <Widget>[
                    Container(
                      color:Colors.white,
                        padding:EdgeInsets.fromLTRB(16.0,16.0,0.0,0.0),
                        child: Column(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  padding:EdgeInsets.only(bottom:16.0),
                                  decoration: BoxDecoration(
                                      border:Border(
                                          bottom: BorderSide(width:1.0,color:const Color(0xFFE2E6ED))
                                      )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child:Text('头像',style:TextStyle(fontSize: 16.0)) ,
                                      ),
                                      CircleAvatar(
                                        radius: 36.0,
                                        backgroundImage:  _user.avatar.length>0 ? new NetworkImage('${_user.avatar}'): new AssetImage('lib/common/images/user/default-avator.png'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                        child:  Icon(CustomIcons.arrow_right,size:13.0,color:Color(0xFFD8D8D8)),)
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  changeAvatar(context);
                                }
                              ),

                              listItemContent(title:'用户名',value:_user?.username,isModify:true,
                                  callBack: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ModifyUsername(_user.id,_user.username)));
                                  }),
                              listItemContent(title:'手机号',value:mobile,isModify:true,
                                  callBack: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ModifyMobile(_user.id,_user?.mobile??'')));
                                  }),
                              listItemContent(title:'性别', value:_user?.gender, isModify:true,
                                  callBack: (){
                                    changeGender(context);
                                  }
                              ),
                            ],
                            )
                        ),
                    SizedBox(height:24.0),
                    Container(
                      padding:EdgeInsets.only(left:16.0),
                      color:Colors.white,
                        child: Column(
                          children: <Widget>[
                            listItemContent(title:'医院',value:_user?.hospital?.name ?? ''),
                            listItemContent(title:'科室',value:_user?.organization?.name ?? '',),
                          ],
                        ),
                      ),
                    Container(
                      margin:EdgeInsets.only(top:30.0),
                      color:Colors.white,
                      width:MediaQuery.of(context).size.width,
                      child:  RaisedButton(
                        child: Text('退出登录',
                            style:TextStyle(fontSize: 16.0,color:Colors.red)),
                        color:Colors.white,
                        elevation:0.0,
                        onPressed: () async{
                          await _userService.logout();
                        },
                      ),
                    )
                  ],
                );
              }
          )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    getInfo();
  }
  getInfo() async{
    await userService.getUserInfo(widget.id);
  }

  final rightArrowIcon = Padding(
     padding: EdgeInsets.only(right:10.0),
     child: Icon(CustomIcons.arrow_right,size:13.0,color:Color(0xFFD8D8D8)),
  );
  Widget listItemContent({String title,String value,bool isModify=false,callBack callBack}){
     return GestureDetector(
       child: Container(
           padding:EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
           decoration: BoxDecoration(
               border:Border(
                   bottom: BorderSide(width:1.0,color:const Color(0xFFE2E6ED))
               )
           ),
           child: Row(
             children: <Widget>[
               Expanded(child: Text(title,style:TextStyle(fontSize: 16.0,color:Colors.black87)),),
               Padding(
                 padding:EdgeInsets.only(right:10.0),
                 child:Text(value ?? '',style:TextStyle(fontSize: 16.0,color:Colors.grey)),
               ),
               isModify ? rightArrowIcon: Container(width:0,height:0)
             ],
           )
       ) ,
       onTap: isModify ? callBack : null,
     );

   }
  changeAvatar(context){
     return showDialog(context: context,builder: (context){
       return SimpleDialog(
         shape: const RoundedRectangleBorder(
             side:BorderSide.none,
             borderRadius: BorderRadius.all(Radius.circular(10))
         ),
         children: <Widget>[
           _dialogMenuItem("相机拍照", source:ImageSource.camera,position:'top',isImage:true),
           new Divider(height: 2.0,),
           _dialogMenuItem("从手机相册选择", source:ImageSource.gallery,position: 'bottom',isImage:true)
         ],
       );
     });

  }
  _dialogMenuItem(title, {ImageSource source,String position='',bool isImage=false}) {
    var item = new Container(
      padding: position.length>0 ? position=='top'? EdgeInsets.only(bottom:7.0) :EdgeInsets.only(top:7.0) : null,
      height:32.0,
      child: new Center(
          child: new Text(title)
      ),
    );
    return new GestureDetector(
      child: item,
      onTap: () {
        isImage ? uploadAvatar(source) : patchGender(title);
      },
    );
  }
  Future uploadAvatar(source) async{
     Navigator.of(context).pop();
     var image = await ImagePicker.pickImage(source: source);
     final response = await UserService.compressAndUploadImage(image);
     if(response.statusCode == 200){
       response.stream.transform(utf8.decoder).listen((value){
         final _data = json.decode(value);
         String _imageUrl = _data['data']['src'];
         patchAvatar(_imageUrl);
       });
     } else {
       Scaffold.of(context).showSnackBar(SnackBar(content: Text('上传失败'),));
     }
  }
  patchAvatar(String url) async{
    final error = await userService.modifyUserInfo(widget.id, {'avatar': url});
    if(error.isEmpty){
      getInfo();
    }
  }

  changeGender(context){
    return showDialog(context: context,builder: (context){
      return SimpleDialog(
        shape: const RoundedRectangleBorder(
            side:BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        children: <Widget>[
          _dialogMenuItem('男',position: 'top'),
          Divider(),
          _dialogMenuItem('女'),
          Divider(),
         _dialogMenuItem('保密',position: 'bottom'),
        ],
      );
    });
  }

  patchGender(text) async{
     Map<String, dynamic> params = {
        'gender':text
     };
    final error = await userService.modifyUserInfo(widget.id, params);
    getInfo();
    Navigator.of(context).pop();
    if(error.isEmpty){
      Navigator.of(context).push(PopRoute(
          child:AnimateHint(text:'修改成功',top:230.0)));
    }

  }
    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
    }

  }


