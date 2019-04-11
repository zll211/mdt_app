import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
import 'package:com.hzztai.mdt/common/services/patient/patient.dart';
import 'package:com.hzztai.mdt/common/services/patient/patient_service.dart';
import 'package:com.hzztai.mdt/common/services/http_service.dart';
import 'package:flutter/material.dart';

class CaseDetail extends StatefulWidget {
  final Patient info;
  CaseDetail(this.info);
  @override
  _CaseDetailState createState() => _CaseDetailState();
}

class _CaseDetailState extends State<CaseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(title: Text('病例详情'),centerTitle: true,),
        body:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BasicInfo(widget.info),
                Container(height: 10.0,color: Color(0xFFF7FAFC),),
                HospitalInfo(widget.info),
                Container(height: 10.0,color: Color(0xFFF7FAFC),),
                Report(widget.info),
              ],
            )
        )
    );
  }
}

class BasicInfo extends StatelessWidget {
  final Patient info;
  BasicInfo(this.info);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          infoHead(title: '基本信息',icon: CustomIcons.consultation_info_patient),
          labelItem(label: '姓名',item: info.name),
          labelItem(label: '性别',item: info.gender),
          labelItem(label: '年龄',item: info.age),
          labelItem(label: '婚否',item: info.maritalStatus),
          labelItem(label: '民族',item: info.nation),
        ],
      ),
    );
  }
}

class HospitalInfo extends StatelessWidget {
  final Patient info;
  HospitalInfo(this.info);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          infoHead(title: '医院信息',icon: CustomIcons.consultation_info_hospital),
          labelItem(label: '就诊医院',item: info.hospital.hospitalName),
          labelItem(label: '就诊科室',item: info.hospital.hospitalSectionName),
          labelItem(label: '主治医生',item: info.hospital.doctorName),
          labelItem(label: '就诊类别',item: info.hospital.visitingCate),
          labelItem(label: '病理号',item: info.hospital.caseNo),
          labelItem(label: '住院号',item: info.hospital.inpatientNo),
          labelItem(label: '床号',item: info.hospital.bedNo),
        ],
      ),
    );
  }
}

class Report extends StatelessWidget {
  final Patient info;
  Report(this.info);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          infoHead(title: '报告信息',icon: CustomIcons.consultation_info_file),
          Text('病情摘要',style: TextStyle(height: 1.6,fontSize: 16.0,color: Color(0xFF202020))),
          Text(info.extension.summary.isNotEmpty?info.extension.summary:'暂未填写',style: TextStyle(height: 1.4,color: Color(0xFF828996))),
          Divider(),
          Text('检验结果',style: TextStyle(height: 1.6,fontSize: 16.0,color: Color(0xFF202020))),
          Text(info.extension.testResult.isNotEmpty?info.extension.testResult:'暂未填写',style: TextStyle(height: 1.4,color: Color(0xFF828996))),
          Divider(),
          Text('检验报告',style: TextStyle(height: 1.6,fontSize: 16.0,color: Color(0xFF202020))),
          Text(info.extension.checkReport.isNotEmpty?info.extension.checkReport:'暂未填写',style: TextStyle(height: 1.4,color: Color(0xFF828996))),
        ],
      ),
    );
  }
}

labelItem({String label,String item}){
  return Row(
    children: <Widget>[
      Container(
        width: 80.0,
        child: Text(label,style: TextStyle(height: 1.4,color: Color(0xFF828996),fontSize: 16.0,)),
      ),
      Text(item,style: TextStyle(height: 1.4,fontSize: 16.0,)),
    ],
  );
}

infoHead({String title,icon}){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Icon(icon,size:20.0,color:Color(0xFF409eff)),
      SizedBox(width: 10.0,),
      Text(title,style: TextStyle(color: Color(0xFF202020),fontSize: 18.0,fontWeight: FontWeight.bold),),
    ],
  );
}


