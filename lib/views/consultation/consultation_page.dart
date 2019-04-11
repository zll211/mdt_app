import 'package:com.hzztai.mdt/common/views/consultation/current_consultation.dart';
import 'package:com.hzztai.mdt/common/widgets/custom_app_bar.dart';
import 'package:com.hzztai.mdt/views/consultation/consultation_header.dart';
import 'package:com.hzztai.mdt/views/consultation/history_consultation.dart';
import 'package:flutter/material.dart';

class ConsultationPage extends StatefulWidget {
  @override
  _ConsultationPageState createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> with AutomaticKeepAliveClientMixin<ConsultationPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppbar(
          child: ConsultationHeader(),
        ),
        body: TabBarView(
          children: <Widget>[CurrentConsultation(), HistoryConsultation()],
        ),
      ),
    );
  }
}
