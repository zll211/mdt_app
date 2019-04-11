import 'package:com.hzztai.mdt/common/theme/theme.dart';
import 'package:flutter/material.dart';

class DoctorList extends StatefulWidget {
  final doctor;
  DoctorList(this.doctor);

  @override
  _DoctorListState createState() => _DoctorListState(doctor);
}

class _DoctorListState extends State<DoctorList> {
  final doctor;
  _DoctorListState(this.doctor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text('会诊医生'),centerTitle: true,),
      body: ListView.builder(
        itemCount: doctor.length,
        itemBuilder: (context, index) {
          return Container(
            margin:EdgeInsets.only(left:16.0),
            padding:EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
            decoration: BoxDecoration(
              border:Border(
                  bottom: BorderSide(width:1.0,color:borderColor)
              ),
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 28.0,
                  backgroundImage: doctor[index].user.avatar.isNotEmpty ? NetworkImage(doctor[index].user.avatar): AssetImage('lib/common/images/user/default-avator.png'),
                ),
                SizedBox(width: 10.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(doctor[index].user.realName,style: TextStyle(color: Colors.black,fontSize: 18.0,),),
                    Text(doctor[index].user.hospital.name.isNotEmpty? '${doctor[index].user.hospital.name} | ${doctor[index].user.organization.name}':'',style: TextStyle(height: 1.4,fontSize: 16.0,color: Color(0xFF828996))),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
