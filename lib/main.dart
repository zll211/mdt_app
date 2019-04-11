import 'dart:io';

import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
import 'package:com.hzztai.mdt/common/models/UserModel.dart';
import 'package:com.hzztai.mdt/common/services/config.dart';
import 'package:com.hzztai.mdt/common/services/notify/jpush_notify.dart';
import 'package:com.hzztai.mdt/common/services/notify/notify_service.dart';
import 'package:com.hzztai.mdt/common/services/user/user_service.dart';
import 'package:com.hzztai.mdt/common/theme/theme.dart';
import 'package:com.hzztai.mdt/common/widgets/badges.dart';
import 'package:com.hzztai.mdt/views/consultation/consultation_page.dart';
import 'package:com.hzztai.mdt/views/notify/notify_detail.dart';
import 'package:com.hzztai.mdt/views/notify/notify_page.dart';
import 'package:com.hzztai.mdt/views/user/login_page.dart';
import 'package:com.hzztai.mdt/views/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  Intl.defaultLocale = locale;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return UserModel(
      userService: UserService(),
      child: MaterialApp(
        title: 'MDT会诊',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, appBarTheme: AppBarTheme(color: primaryColor)),
        home: MyHomePage(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        routes: {
          "/system_notify": (context) => NotifyDetail(),
        },
        supportedLocales: [
          const Locale('zh', 'CN'), // Simplified Chinese
          const Locale('en', 'US'), // English
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<bool>(
          stream: _userService.authStatus$,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                return NavPage();
              } else {
                return LoginPage();
              }
            } else {
              return Center(
                child: Image.asset('lib/common/images/launch_image.png'),
              );
            }
          }),
    );
  }
}

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  final _notifyService = NotifyService();

  void onBottomTabTap(int index) {
    bodyPageController.animateToPage(index, duration: Duration(microseconds: 30), curve: Curves.ease);
  }

  void onBodyPageChange(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
    //print(this.pageIndex);
  }

  int pageIndex = 0;
  PageController bodyPageController;

  @override
  void initState() {
    super.initState();
    print(Platform.version);
    JPushNotify(
      onRegistration: onRegistration,
      onReceiveNotification: onReceiveNotification,
      onOpenNotification: onOpenNotification,
      onReceiveMessage: onReceiveMessage,
    );
    bodyPageController = new PageController(initialPage: pageIndex);
    _notifyService.updateSystemNotifyUnread.add(true);
  }

  void onRegistration(String id) {
    // TODO: 上报本机 id，便于推送到指定人
    print('jpush getRegistrationID: $id');
    JPushNotify.reportId(id);
  }

  void onReceiveNotification(Map<String, dynamic> message) {
    // TODO: 判断通知类型
    // TODO: 更新未读消息数量
    print("jpush onReceiveNotification: $message");
  }

  void onOpenNotification(Map<String, dynamic> message) {
    print("jpush onOpenNotification: $message");
    // TODO: 如果是会诊开始通知，就直接进入会诊
    // TODO: 如果是会诊过审通知，则显示会诊安排，并刷新会诊安排
    // TODO: 如果都不是，则跳到消息页面
    onBottomTabTap(1);
  }

  void onReceiveMessage(Map<String, dynamic> message) {
    print("jpush onReceiveMessage: $message");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: bodyPageController,
        onPageChanged: onBodyPageChange,
        children: <Widget>[
          ConsultationPage(),
          NotifyPage(),
          UserPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: primaryColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.tab_bar_consultation),
                activeIcon: Icon(CustomIcons.tab_bar_consultation_active),
                title: Text('会诊')),
            BottomNavigationBarItem(
                icon: StreamBuilder<int>(
                    stream: _notifyService.systemNotifyUnread$,
                    builder: (context, snapshot) {
                      return Badges(
                        child: Icon(CustomIcons.tab_bar_message),
                        count: snapshot.data,
                        dot: true,
                      );
                    }),
                activeIcon: StreamBuilder<int>(
                    stream: _notifyService.systemNotifyUnread$,
                    builder: (context, snapshot) {
                      return Badges(child: Icon(CustomIcons.tab_bar_message_active), count: snapshot.data, dot: true);
                    }),
                title: Text('通知')),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.tab_bar_user),
                activeIcon: Icon(CustomIcons.tab_bar_user_active),
                title: Text('我的')),
          ],
          onTap: onBottomTabTap,
          currentIndex: pageIndex),
    );
  }
}
