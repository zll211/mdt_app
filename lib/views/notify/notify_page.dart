import 'package:com.hzztai.mdt/common/services/notify/notify_service.dart';
import 'package:com.hzztai.mdt/common/services/notify/system_notify.dart';
import 'package:com.hzztai.mdt/common/widgets/custom_app_bar.dart';
import 'package:com.hzztai.mdt/views/notify/notify_item.dart';
import 'package:flutter/material.dart';

class NotifyPage extends StatefulWidget {
  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> with AutomaticKeepAliveClientMixin<NotifyPage> {
  @override
  bool get wantKeepAlive => true;

  SystemNotify _latestNotify;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotifyService().updateSystemNotifyUnread.add(true);
    NotifyService().updateLatestNotify.add(true);
    NotifyService().latestNotify$.listen((data) {
      this.setState(() {
        _latestNotify = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [];
    if (_latestNotify != null) {
      _list.add(NotifyItem(
        _latestNotify,
        isSystem: true,
      ));
    }
    return Scaffold(
      appBar: CustomAppbar(title: '消息'),
      body: SingleChildScrollView(
        child: Column(
          children: _list,
        ),
      ),
    );
  }
}
