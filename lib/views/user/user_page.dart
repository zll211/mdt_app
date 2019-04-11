import 'package:flutter/material.dart';
import 'package:com.hzztai.mdt/common/models/UserModel.dart';
import 'package:com.hzztai.mdt/common/services/user/user.dart';
import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
import 'package:com.hzztai.mdt/common/theme/theme.dart';
import './user_info_page.dart';
import './feed_back.dart';
import './about_version.dart';
class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String mobile = '';
  int id;
  @override
  Widget build(BuildContext context) {
    final _userService = UserModel.of(context, 'user').userService;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('我的'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryColor,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            StreamBuilder<User>(
              stream:_userService.user$,
              builder:(context,snapshot){
                User _user = User();
                if(snapshot.hasData){
                  _user = snapshot.data;
                  mobile = _user.mobile.substring(0,3)+'****'+_user.mobile.substring(7,11);
                  id = _user.id;
                }
                return  Container(
                    color:Colors.white,
                    width:MediaQuery.of(context).size.width,
                    height:100,
                    child:  Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                          width:MediaQuery.of(context).size.width,
                          color:primaryColor,
                          height:40.0,
                        ),
                        Positioned(
                            child: Container(
                              margin:EdgeInsets.symmetric(vertical: 0.0,horizontal: 15.0),
                              padding:EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
                              decoration: BoxDecoration(
                                  color:Colors.white,
                                  borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                                  boxShadow: [BoxShadow(color: Color(0x0F000000), offset: Offset(3.0, 3.0),blurRadius: 5.0, spreadRadius: 1.0), BoxShadow(color: Color(0x0F000000), offset: Offset(1.0, 1.0)), BoxShadow(color: Color(0x0F000000))]
                              ),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 36.0,
                                    backgroundImage: _user.avatar.length>0 ? new NetworkImage('${_user.avatar}'): new AssetImage('lib/common/images/user/default-avator.png'),
                                  ),
                                  SizedBox(width:10.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        RichText(
                                          text:TextSpan(text:_user?.realName ?? '',
                                              style: getTextStyle(Colors.black,18.0,true),
                                              children:[
                                                TextSpan(text:'/'+'${_user?.title}'?? '',style: getTextStyle(Color(0xFFA2A7AF), 16.0, false))
                                              ]
                                          ),

                                        ),
                                        SizedBox(height:15.0),

                                        Text(mobile??'',style:getTextStyle(Color(0xFFA2A7AF), 16.0, false))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  );
              }
            ),
            Container(

              padding:EdgeInsets.fromLTRB(15.0, 16.0, 0.0, 0.0),
              child: Column(
                children: <Widget>[
                  listItem(context,
                      title:'账号与安全',
                      iconPath:CustomIcons.account_safe,
                      color:Colors.blue,

                  ),
                  listItem(context,title:'意见反馈',iconPath: CustomIcons.feedback, color:Colors.orange),
                  listItem(context,title:'关于版本',iconPath: CustomIcons.aboutUs,color:Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  GestureDetector listItem(context,{String title,var iconPath,Color color,Function callBack}){
    return GestureDetector(
      child: Container(
        margin:EdgeInsets.fromLTRB(10.0, 16.0, 0.0, 0.0),
        padding:EdgeInsets.only(bottom:16.0),
        decoration: BoxDecoration(
            border:Border(
                bottom: BorderSide(width:1.0,color:const Color(0xFFDCDDDC))
            )
        ),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(iconPath,size:20.0,color:color),
            SizedBox(width:16.0),
            Expanded(child: Text(title),),
            Padding(
             padding: EdgeInsets.only(right:10.0),
             child: Icon(CustomIcons.arrow_right,size:13.0,color:Color(0xFFD8D8D8))
           )
          ],
        ),
      ),
      onTap: (){
        if(title == '账号与安全'){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UserInfoPage(id)));
        }
        else if(title == '意见反馈'){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FeedBack()));
        } else if(title == '关于版本'){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AboutVersion()));
        }
      },
    );
  }
  TextStyle getTextStyle(Color color,double fontSizes,bool isFontWeight){
    return TextStyle(
      color: color,
      fontSize: fontSizes,
      fontWeight: isFontWeight==true ? FontWeight.bold :FontWeight.normal,
    );
  }
}
