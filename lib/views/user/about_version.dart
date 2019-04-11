import 'package:flutter/material.dart';
import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
import 'package:com.hzztai.mdt/common/widgets/version.dart';

class AboutVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('关于MDT',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 19.0)),
        centerTitle: true,
        leading: InkWell(
          child:Center(child:Icon(CustomIcons.arrow_left,size:24.0)),
          onTap: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body:Container(
        margin:EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 16.0),
        width:MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('lib/common/images/login/logo.png'),
                  SizedBox(height:16.0),
                  Text('MDT多学科联合会诊平台',style:TextStyle(fontSize: 18.0)),
                  SizedBox(height:8.0),
                  Version(),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('版权 江丰生物©2018',style:TextStyle(color:Color(0xFFBABABA),fontSize: 14.0,)),
                  SizedBox(height:4.0),
                  Text('宁波江丰生物信息技术有限公司',style:TextStyle(color:Color(0xFFBABABA),fontSize: 14.0,)),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
