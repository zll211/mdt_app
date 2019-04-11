import 'package:com.hzztai.mdt/common/services/notify/system_notify.dart';
import 'package:com.hzztai.mdt/common/services/utils.dart';
import 'package:com.hzztai.mdt/common/theme/theme.dart';
import 'package:com.hzztai.mdt/common/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotifyItem extends StatelessWidget {
  final SystemNotify item;
  final bool isSystem;

  NotifyItem(this.item, {this.isSystem: false}) : super(key: Key(item.id.toString()));

  @override
  Widget build(BuildContext context) {
    return Slidable(
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            // TODO: 真删除
            print('delete');
          },
        ),
      ],
      child: GestureDetector(
        onTap: () {
          if (isSystem) {
            Navigator.of(context).pushNamed('/system_notify');
          } else {
            // TODO: 打开环信聊天
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: normalPadding),
          padding: const EdgeInsets.fromLTRB(0, normalPadding / 2, normalPadding, normalPadding / 2),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFEAEAEA)))),
          child: Row(
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(right: normalPadding),
                  child: CustomAvatar(
                    url: item.icon,
                    size: 44,
                    isCircle: false,
                  )),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          item.title,
                          style: TextStyle(color: titleColor, fontSize: 18.0),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        )),
                        Container(
                            margin: const EdgeInsets.only(left: 4),
                            child: Text(getLocaleTime(DateTime.parse(item.time))))
                      ],
                    ),
                    Text(
                      item.notification,
                      style: TextStyle(color: textColor),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    )
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
