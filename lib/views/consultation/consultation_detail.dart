import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
import 'package:com.hzztai.mdt/common/services/consultation/consultation.dart';
import 'package:com.hzztai.mdt/common/services/consultation/consultation_service.dart';
import 'package:com.hzztai.mdt/common/services/consultation/operate_history.dart';
import 'package:com.hzztai.mdt/common/services/http_service.dart';
import 'package:com.hzztai.mdt/common/theme/theme.dart';
import 'package:com.hzztai.mdt/views/consultation/consultation_detail_skeleton.dart';
import 'package:com.hzztai.mdt/views/consultation/doctor_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'case_detail.dart';
import 'file_list.dart';

class ConsultationDetail extends StatefulWidget {
  final int id;
  final bool history;

  ConsultationDetail(this.id, this.history);

  @override
  _ConsultationDetailState createState() => _ConsultationDetailState();
}

class _ConsultationDetailState extends State<ConsultationDetail> {
  int showNum = 2;
  final fontHeight = 1.4;
  final fontColor = Color(0xFFA2A7AF);
  final normalSize = 18.0;
  final mediumSize = 16.0;
  final smallSize = 14.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会诊资料'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<HttpFinalResult<Consultation>>(
          future: ConsultationService.getDetail(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error.isEmpty) {
                final info = snapshot.data.data;
                DateTime _applicationAt = DateTime.parse(info.applicationAt);
                String _statusText = '待会诊';
                bool isStart = _applicationAt.isBefore(DateTime.now());
                if (isStart) {
                  _statusText = '会诊中';
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(bottom: 10.0),
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: primaryColor,
                              height: 40.0,
                            ),
                            Positioned(
                                child: Container(
                              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x0F000000),
                                      blurRadius: 12.0,
                                    ),
                                  ]),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(CustomIcons.consultation_info_patient,
                                                size: normalSize, color: primaryColor),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              info.patient.name,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: normalSize,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 6.0,
                                            ),
                                            Text(
                                              info.patient.gender.isNotEmpty ? '/${info.patient.gender}' : '',
                                              style: TextStyle(
                                                color: fontColor,
                                                fontSize: smallSize,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15.0),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              CustomIcons.consultation_info_file,
                                              size: normalSize,
                                              color: primaryColor,
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              '${info.patient.age}${info.patient.ageUnit}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: mediumSize,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              info.patient.hospital.hospitalName.isNotEmpty ? '|' : '',
                                              style: TextStyle(
                                                color: fontColor,
                                                fontSize: smallSize,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              info.patient.hospital.hospitalName.isNotEmpty
                                                  ? '${info.patient.hospital.hospitalName}-${info.patient.hospital.hospitalSectionName}'
                                                  : '',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: mediumSize,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(CustomIcons.arrow_right, size: mediumSize, color: fontColor),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CaseDetail(info.patient)));
                      },
                    ),
                    Offstage(
                        offstage: !widget.history,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(normalPadding, 4.0, normalPadding, 0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: borderColor),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: <Widget>[
                              operateHistory(info.consultationActions, showNum),
                              Offstage(
                                offstage: info.consultationActions.length <= 2 ? true : false,
                                child: GestureDetector(
                                  child: Icon(
                                    showNum == 2 ? Icons.expand_more : Icons.expand_less,
                                    color: Color(0xFF828996),
                                    size: 28.0,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      showNum = showNum < info.consultationActions.length
                                          ? info.consultationActions.length
                                          : 2;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        )),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: normalPadding, right: normalPadding),
                        padding: EdgeInsets.only(top: 4.0, bottom: normalPadding),
                        child: Column(
                          children: <Widget>[
                            Offstage(
                              offstage: widget.history,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 80.0,
                                          child: Text(
                                            '会诊时间',
                                            style: TextStyle(
                                              height: fontHeight,
                                              color: Color(0xFF828996),
                                              fontSize: mediumSize,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${DateFormat.yMMMd().format(_applicationAt)} ${DateFormat.Hm().format(_applicationAt)}',
                                          style: TextStyle(
                                            height: fontHeight,
                                            fontSize: mediumSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(_statusText, style: TextStyle(height: fontHeight, fontSize: mediumSize, color: primaryColor)),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 80.0,
                                  child: Text(
                                    '会诊单号',
                                    style: TextStyle(
                                      height: fontHeight,
                                      color: Color(0xFF828996),
                                      fontSize: mediumSize,
                                    ),
                                  ),
                                ),
                                Text(
                                  info.consultationNumber,
                                  style: TextStyle(
                                    height: fontHeight,
                                    fontSize: mediumSize,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 80.0,
                                  child: Text(
                                    '申请人',
                                    style: TextStyle(
                                      height: fontHeight,
                                      color: Color(0xFF828996),
                                      fontSize: mediumSize,
                                    ),
                                  ),
                                ),
                                Text(
                                  info.applyDoctor.realName,
                                  style: TextStyle(
                                    height: fontHeight,
                                    fontSize: mediumSize,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 80.0,
                                  child: Text(
                                    '申请目的',
                                    style: TextStyle(
                                      height: fontHeight,
                                      color: Color(0xFF828996),
                                      fontSize: mediumSize,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    info.objective.isNotEmpty ? info.objective : '无',
                                    style: TextStyle(
                                      height: fontHeight,
                                      fontSize: mediumSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 80.0,
                                  child: Text(
                                    '备注',
                                    style: TextStyle(
                                      height: fontHeight,
                                      color: Color(0xFF828996),
                                      fontSize: mediumSize,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    info.remark.isNotEmpty ? info.remark : '无',
                                    style: TextStyle(
                                      height: fontHeight,
                                      fontSize: mediumSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(left: normalPadding),
                              padding: EdgeInsets.fromLTRB(0, normalPadding, 0, normalPadding),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1.0, color: borderColor)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      '资料附件',
                                      style: TextStyle(
                                        color: Color(0xFF828996),
                                        fontSize: mediumSize,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Icon(CustomIcons.arrow_right, size: 13.0, color: Color(0xFFD8D8D8)),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FileList(info.patient.attachment)),
                              );
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(left: normalPadding),
                              padding: EdgeInsets.fromLTRB(0, normalPadding, 0, normalPadding),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1.0, color: borderColor)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      '会诊医生',
                                      style: TextStyle(
                                        color: Color(0xFF828996),
                                        fontSize: mediumSize,
                                      ),
                                    ),
                                  ),
                                  doctorAvatar(info.inviteeDoctors),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Icon(CustomIcons.arrow_right, size: 13.0, color: Color(0xFFD8D8D8)),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DoctorList(info.inviteeDoctors)),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Offstage(
                      offstage: !widget.history,
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(normalPadding),
                        margin: EdgeInsets.only(bottom: 60.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('会诊报告', style: TextStyle(height: fontHeight, fontWeight: FontWeight.bold, fontSize: normalSize)),
                            RichText(
                              text: TextSpan(style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                TextSpan(
                                  text: info.applyDoctor.realName,
                                  style: TextStyle(height: fontHeight, fontSize: mediumSize),
                                ),
                                TextSpan(
                                  text: info.applyDoctor.organization.name.isNotEmpty ? ' | ' : '',
                                  style: TextStyle(height: fontHeight, fontSize: mediumSize, color: Color(0xFF828996)),
                                ),
                                TextSpan(
                                  text: info.applyDoctor.organization.name,
                                  style: TextStyle(height: fontHeight, fontSize: mediumSize),
                                ),
                              ]),
                            ),
                            Text(
                              info.report.content.isNotEmpty ? info.report.content : '暂未填写',
                              style: TextStyle(height: fontHeight, fontSize: smallSize, color: Color(0xFF828996)),
                            ),
                            Divider(),
                            Text(
                              '会诊意见',
                              style: TextStyle(height: fontHeight, fontWeight: FontWeight.bold, fontSize: normalSize),
                            ),
                            consultationOpinion(context, info.inviteeDoctors)
                          ],
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: widget.history,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(normalPadding, 90.0, normalPadding, 60.0),
                        child: FlatButton(
                          onPressed: () {},
                          color: primaryColor,
                          child: Text(
                            '进入',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  child: Text('出错了'),
                );
              }
            } else {
              return ConsultationDetailSkeleton();
            }
          },
        ),
      ),
    );
  }
}

doctorAvatar(doctors) {
//  info.inviteeDoctors[index].user.realName
  List<Widget> tiles = [];
  Widget content;
  for (var i = 0; i < doctors.length; i++) {
    if (i < 3) {
      tiles.add(Container(
        width: 30.0,
        height: 30.0,
        margin: EdgeInsets.only(left: 3.0, right: 3.0),
        child: CircleAvatar(
          backgroundImage: doctors[i].user.avatar.isNotEmpty
              ? NetworkImage(doctors[i].user.avatar)
              : AssetImage('lib/common/images/user/default-avator.png'),
        ),
      ));
    }
  }
  content = Row(children: tiles);
  return content;
}

operateHistory(history, showNum) {
  final fontColor = Color(0xFFA2A7AF);
  final mediumSize = 16.0;
  List<Widget> tiles = [];
  Widget content;
  _dataToAction(OperateActionType status) {
    switch (status) {
      case OperateActionType.applyAdd:
        return {'status': '会诊申请', 'color': consultationAdd};
      case OperateActionType.applyEdit:
        return {'status': '会诊申请修改', 'color': consultationEdit};
      case OperateActionType.applyFailed:
        return {'status': '会诊审核不通过', 'color': consultationFailed};
      case OperateActionType.applyPassed:
        return {'status': '会诊审核通过', 'color': consultationAdd};
      case OperateActionType.applyDeleted:
        return {'status': '会诊删除', 'color': consultationFailed};
      case OperateActionType.videoOver:
        return {'status': '会诊视频结束', 'color': consultationFailed};
      case OperateActionType.recordAdd:
        return {'status': '会诊总结记录', 'color': consultationReport};
      case OperateActionType.reportAdd:
        return {'status': '会诊报告保存', 'color': consultationEdit};
      case OperateActionType.reportSubmit:
        return {'status': '报告提交审核', 'color': consultationReport};
      case OperateActionType.reportFailed:
        return {'status': '报告审核不通过', 'color': consultationFailed};
      case OperateActionType.reportPassed:
        return {'status': '报告审核通过', 'color': consultationAdd};
      default:
        return {'status': '未知操作', 'color': consultationEdit};
    }
  }

  for (var i = 0; i < history.length; i++) {
    DateTime _operateAt = DateTime.parse(history[i].operateAt);
    if (i < showNum) {
      var type = _dataToAction(history[i].actionType);
      tiles.add(
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.trip_origin,
                    color: type['color'],
                    size: 17.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    '${DateFormat.yMMMd().format(_operateAt)} ${DateFormat.Hm().format(_operateAt)}',
                    style: TextStyle(color: Color(0xFF202020), fontSize: mediumSize),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 19.0,
                    margin: EdgeInsets.only(left: 8.0, top: 4.0),
                    height: i == showNum - 1 ? 20.0 : 40.0,
                    decoration: BoxDecoration(
                      border: i == showNum - 1 ? null : Border(left: BorderSide(width: 1.0, color: borderColor)),
                    ),
                  ),
                  Text(
                    type['status'],
                    style: TextStyle(color: fontColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
  content = Container(
    child: Column(
      children: tiles,
    ),
  );
  return content;
}

consultationOpinion(context, doctors) {
  final fontHeight = 1.4;
  final mediumSize = 16.0;
  final smallSize = 14.0;
  List<Widget> tiles = [];
  Widget content;
  for (var i = 0; i < doctors.length; i++) {
    tiles.add(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: <TextSpan>[
            TextSpan(text: doctors[i].user.realName, style: TextStyle(height: fontHeight, fontSize: mediumSize)),
            TextSpan(
              text: doctors[i].user.organization.name.isNotEmpty ? ' | ' : '',
              style: TextStyle(height: fontHeight, fontSize: mediumSize, color: Color(0xFF828996)),
            ),
            TextSpan(text: doctors[i].user.organization.name, style: TextStyle(height: fontHeight, fontSize: mediumSize)),
          ]),
        ),
        Text(
          doctors[i].consultationOption.content.isNotEmpty ? doctors[i].consultationOption.content : '暂未填写',
          style: TextStyle(height: fontHeight, fontSize: smallSize, color: Color(0xFF828996)),
        ),
        Divider(),
      ],
    ));
  }
  content = Column(children: tiles);
  return content;
}
