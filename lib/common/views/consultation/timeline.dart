import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
import 'package:com.hzztai.mdt/common/services/config.dart';
import 'package:com.hzztai.mdt/common/services/consultation/consultation.dart';
import 'package:com.hzztai.mdt/common/theme/theme.dart';
import 'package:com.hzztai.mdt/common/widgets/custom_avatar.dart';
import 'package:com.hzztai.mdt/views/consultation/consultation_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Item extends StatelessWidget {
  final Consultation item;
  final bool isLast;

  _Item(this.item, this.isLast);

  @override
  Widget build(BuildContext context) {
    DateTime _applicationAt = DateTime.parse(item.applicationAt);
    String _statusText = '待会诊';
    bool isStart = _applicationAt.isBefore(DateTime.now());
    if (isStart) {
      _statusText = '会诊中';
    }
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConsultationDetail(item.id, false)));
          },
          child: Container(
            padding: const EdgeInsets.only(
                left: normalPadding, top: normalPadding / 2, bottom: normalPadding, right: normalPadding),
            margin: const EdgeInsets.only(left: normalPadding + 60.0, right: normalPadding, top: normalPadding),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                boxShadow: normalShadow),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CustomAvatar(url: item.applyDoctor.avatar),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          child: Text(item.applyDoctor.username,
                              style: TextStyle(fontSize: 24.0, color: titleColor), overflow: TextOverflow.ellipsis)),
                    ),
                    Container(
                      width: 72,
                      height: 32,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: isStart
                          ? FlatButton(
                              onPressed: () {},
                              color: primaryColor,
                              child: Text(
                                '进入',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Container(),
                    )
                  ],
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    '会诊患者：${item.patient.name}',
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('会诊医生：${item.inviteeDoctors.map((i) => i.user.username).toList().join('、')}',
                      overflow: TextOverflow.ellipsis, style: TextStyle(color: textColor, fontSize: 16)),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Icon(
                        CustomIcons.consultation_status,
                        color: primaryColor,
                        size: 16,
                      ),
                    ),
                    Text(
                      _statusText,
                      style: TextStyle(color: primaryColor),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
            left: normalPadding,
            top: normalPadding * 2,
            bottom: -normalPadding * 2 + 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    isStart
                        ? Container(
                            width: 16,
                            height: 16,
                            margin: const EdgeInsets.only(right: 4.0),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                border: Border.all(color: Color(0xFFCCDFFC), width: 2),
                                boxShadow: [
                                  BoxShadow(blurRadius: 3.0, color: Color(0x22000000), offset: Offset(0, 1))
                                ]),
                          )
                        : Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.only(left: 2, right: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              border: Border.all(color: Color(0xFFC9CFD9), width: 2),
                            ),
                          ),
                    Text(DateFormat.Hm().format(_applicationAt), style: TextStyle(color: textColor, fontSize: 12))
                  ],
                ),
                isLast
                    ? Container()
                    : Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 7.0, top: 6.0),
                          decoration:
                              BoxDecoration(border: Border(left: BorderSide(color: Color(0xFFC9CFD9), width: 1))),
                        ),
                      )
              ],
            ))
      ],
    );
  }
}

class Timeline extends StatelessWidget {
  final DateTime date;
  final List<Consultation> list;
  final DateFormat _localeDate = DateFormat.yMMMMd();

  Timeline({this.date, this.list = const []});

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [
      Row(children: <Widget>[
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: normalPadding),
                  child: Text(
                    _localeDate.dateSymbols.WEEKDAYS[date.weekday % 7],
                    style: TextStyle(color: titleColor, fontSize: 20),
                  ),
                ),
                Text(_localeDate.format(date), style: TextStyle(color: textColor))
              ],
            ))
      ])
    ];
    if (list.isEmpty) {
      _list.add(Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            width: 280.0,
            child: Image.asset(
              "lib/common/images/consultation/no_consultation.png",
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 0,
            right: 0,
            child: Center(child: Text("暂无会诊安排", style: TextStyle(color: Color(0xFFA2A7AF)))),
          )
        ],
      ));
    } else {
      list.forEach((i) {
        _list.add(_Item(i, list.last.id == i.id));
      });
    }
    return Container(
      color: Color(0xFFF7FAFC),
      padding: const EdgeInsets.only(bottom: normalPadding),
      child: Column(
        children: _list,
      ),
    );
  }
}
