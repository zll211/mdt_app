import 'package:flutter/material.dart';
import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
import 'package:com.hzztai.mdt/common/services/user/user_service.dart';

class ModifyUsername extends StatefulWidget {
  final String username;
  final int id;
  ModifyUsername(this.id,this.username);
  @override
  _ModifyUsernameState createState() => _ModifyUsernameState();
}

class _ModifyUsernameState extends State<ModifyUsername> {
  final _userService = UserService();
  TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text('用户名',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 19.0)),
          centerTitle: true,
          leading: InkWell(
            child:Center(child:Text('取消',style:TextStyle(fontSize: 18.0))),
            onTap: (){
            Navigator.of(context).pop();
            },
          ),
        actions: <Widget>[
          GestureDetector(
            child:Center(child:Text('完成',style:TextStyle(fontSize: 18.0))),
            onTap: () async{
              if(usernameController.text.isEmpty){
                Navigator.of(context).pop();
              }
              else {
               await _userService.modifyUserInfo(widget.id,{'username':usernameController.text});
               Navigator.of(context).pop();
               getInfo();

              }
            }
          ),
          SizedBox(width:10.0),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            color:Colors.white,
            border:Border(
                bottom: BorderSide(width:1.0,color:const Color(0xFFE2E6ED))
            )
        ),
        padding:EdgeInsets.fromLTRB(16.0, 10.0, 10.0, 10.0),
        child: TextField(
          controller: usernameController,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              child: Icon(CustomIcons.clear),
              onTap: (){
                usernameController.text = '';
              },
            ),
            border: InputBorder.none,
          ),
        ),
      )

    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController.text = widget.username;
  }
  getInfo() async{
    await _userService.getUserInfo(widget.id);
  }
}
