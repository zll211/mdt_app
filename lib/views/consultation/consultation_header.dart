import 'package:com.hzztai.mdt/common/widgets/tabs.dart';
import 'package:flutter/material.dart';

class ConsultationHeader extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => Size.fromHeight(30);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('会诊', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        MDTTabBar(
            indicatorColor: Colors.white,
            indicatorSize: MDTTabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
            tabs: <Widget>[MDTTab(text: '会诊安排'), MDTTab(text: '历史会诊')])
      ],
    );
  }
}
