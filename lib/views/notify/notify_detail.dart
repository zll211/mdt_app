import 'package:com.hzztai.mdt/common/services/notify/notify_service.dart';
import 'package:com.hzztai.mdt/common/services/notify/system_notify.dart';
import 'package:com.hzztai.mdt/common/services/utils.dart';
import 'package:com.hzztai.mdt/common/theme/theme.dart';
import 'package:com.hzztai.mdt/common/widgets/custom_app_bar.dart';
import 'package:com.hzztai.mdt/common/widgets/custom_avatar.dart';
import 'package:com.hzztai.mdt/common/widgets/enhance_list_view.dart';
import 'package:flutter/material.dart';

enum Direction { from, to }

class _ChatItem extends StatelessWidget {
  final SystemNotify item;

  _ChatItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: normalPadding),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: normalPadding),
            child: Center(
              child: Text(getLocaleTime(DateTime.parse(item.time))),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: normalPadding),
                child: CustomAvatar(
                  url: item.icon,
                  size: 44.0,
                  isCircle: false,
                ),
              ),
              Stack(
                children: <Widget>[
                  Positioned(
                    left: 11,
                    top: normalPadding,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: normalShadow,
                        ),
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: normalShadow,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: const EdgeInsets.all(normalPadding / 2),
                      margin: const EdgeInsets.only(left: normalPadding),
                      child: Text(item.notification),
                    ),
                  ),
                  Positioned(
                    left: 11,
                    top: normalPadding,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        color: Colors.white,
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class NotifyDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: '系统通知',
        needBack: true,
      ),
      backgroundColor: Color(0xFFF7FAFC),
      body: EnhancedListView<SystemNotify>(
        key: Key('SystemNotifyPage'),
        reverse: true,
        offsetHeight: 0.0,
        getListFuture: ({int page, int pageSize}) async {
          final res = await NotifyService.getSystemNotify(page: page, pageSize: pageSize);
          return res.data;
        },
        itemBuilder: (context, item, index) => _ChatItem(item),
      ),
    );
  }
}
