import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
import 'package:com.hzztai.mdt/common/services/consultation/consultation.dart';
import 'package:com.hzztai.mdt/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'consultation_detail.dart';

class ConsultationCard extends StatefulWidget {
  final Consultation info;

  ConsultationCard(this.info);

  @override
  _ConsultationCardState createState() => _ConsultationCardState(info);
}

class _ConsultationCardState extends State<ConsultationCard> {
  final Consultation info;

  _ConsultationCardState(this.info);

  bool history = true;

  @override
  Widget build(BuildContext context) {
    DateTime _applicationAt = DateTime.parse(info.applicationAt);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ConsultationDetail(info.id, history)));
      },
      child: Card(
        margin: const EdgeInsets.only(left: normalPadding, right: normalPadding, top: normalPadding),
        child: Container(
          padding: const EdgeInsets.only(
            left: normalPadding,
            top: normalPadding / 2,
            bottom: normalPadding,
            right: normalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 30.0,
                          height: 30.0,
                          child: CircleAvatar(
                            radius: 22.0,
                            backgroundImage: info.applyDoctor.avatar.isNotEmpty
                                ? NetworkImage('${info.applyDoctor.avatar}')
                                : AssetImage('lib/common/images/user/default-avator.png'),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          info.applyDoctor.realName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          '/申请人',
                          style: TextStyle(
                            color: Color(0xFFA2A7AF),
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(_applicationAt),
                    style: TextStyle(
                      color: Color(0xFFA2A7AF),
                    ),
                  ),
                ],
              ),
              Divider(),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '会诊患者：${info.patient.name}',
                      style: TextStyle(
                        height: 1.4,
                        color: Color(0xFF828996),
                        fontSize: 16.0,
                      ),
                    ),
                    Container(
                      child: Text(
                        '会诊医生：${info.inviteeDoctors.map((i) => i.user.realName).toList().join('、')}',
                        style: TextStyle(
                          height: 1.4,
                          color: Color(0xFF828996),
                          fontSize: 16.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    consultationStatus(info.status)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

consultationStatus(status) {
  _dataToStatus(ConsultationStatusEnum status) {
    switch (status) {
      case ConsultationStatusEnum.recorded:
        return {'status': '已记录', 'color': consultationEdit};
      case ConsultationStatusEnum.reportVerifying:
        return {'status': '报告待审核', 'color': consultationReport};
      case ConsultationStatusEnum.reportRefused:
        return {'status': '报告未通过', 'color': consultationFailed};
      case ConsultationStatusEnum.reportVerified:
        return {'status': '报告已审核', 'color': consultationAdd};
      case ConsultationStatusEnum.ended:
        return {'status': '已结束', 'color': consultationEdit};
      default:
        return {'status': '审核中', 'color': consultationEdit};
    }
  }

  var type = _dataToStatus(status);
  Widget content = Container(
    margin: EdgeInsets.only(top: 8.0),
    child: Row(
      children: <Widget>[
        Icon(CustomIcons.consultation_status, size: 16.0, color: type['color']),
        Text(
          type['status'],
          style: TextStyle(
            color: type['color'],
            fontSize: 14.0,
          ),
        ),
      ],
    ),
  );
  return content;
}
