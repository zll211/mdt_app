import 'package:com.hzztai.mdt/common/services/consultation/consultation.dart';
import 'package:com.hzztai.mdt/common/services/consultation/consultation_service.dart';
import 'package:com.hzztai.mdt/common/widgets/enhance_list_view.dart';
import 'package:com.hzztai.mdt/views/consultation/consultation_card.dart';
import 'package:flutter/material.dart';

class HistoryConsultation extends StatefulWidget {
  @override
  _HistoryConsultationState createState() => _HistoryConsultationState();
}

class _HistoryConsultationState extends State<HistoryConsultation>
    with AutomaticKeepAliveClientMixin<HistoryConsultation> {
  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    return EnhancedListView<Consultation>(
      key: Key('HistoryConsultation'),
      getListFuture: ({int page, int pageSize}) async {
        final res = await ConsultationService.getList(page: page, pageSize: pageSize, history: true);
        print(res.data.length);
        return res.data;
      },
      itemBuilder: (context, item, index) => ConsultationCard(item),
    );
  }
}
