import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
import 'package:com.hzztai.mdt/common/services/consultation/consultation.dart';
import 'package:com.hzztai.mdt/common/services/consultation/consultation_service.dart';
import 'package:com.hzztai.mdt/common/theme/theme.dart';
import 'package:com.hzztai.mdt/common/views/consultation/timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/event.dart';
import 'package:flutter_calendar/event_list.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

class CurrentConsultation extends StatefulWidget {
  @override
  _CurrentConsultationState createState() => _CurrentConsultationState();
}

class _CurrentConsultationState extends State<CurrentConsultation>
    with AutomaticKeepAliveClientMixin<CurrentConsultation> {
  @override
  bool get wantKeepAlive => true;

  DateTime _currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool _weekFormat = false;
  EventList<Event<Consultation>> _markedDatesMap = EventList<Event<Consultation>>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  Future<void> getList() async {
    final response = await ConsultationService.getList();
    response.data.forEach((i) {
      DateTime _parsedDate = DateTime.parse(i.reservationAt);
      DateTime _dayDate = DateTime(_parsedDate.year, _parsedDate.month, _parsedDate.day);
      _markedDatesMap.add(_dayDate, Event<Consultation>(date: _dayDate, title: i.objective, data: i));
    });

    setState(() {
      _markedDatesMap = _markedDatesMap;
    });
  }

  void toggleCalendar() {
    setState(() {
      _weekFormat = !_weekFormat;
    });
  }

  void onDateSelected(DateTime date, List<Event<Consultation>> events) {
    this.setState(() {
      _currentDate = date;
    });
    print(date);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: normalPadding),
            padding: const EdgeInsets.only(bottom: normalPadding),
            color: Colors.white,
            child: Calendar<Consultation>(
              onDateSelected: onDateSelected,
              isExpanded: _weekFormat,
              events: _markedDatesMap,
              toggleExpanded: IconButton(
                icon: Icon(
                  _weekFormat ? CustomIcons.calendar_week : CustomIcons.calendar_month,
                  color: primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _weekFormat = !_weekFormat;
                  });
                },
              ),
            ),
          ), //
          Timeline(
            date: _currentDate,
            list: _markedDatesMap.getEvents(_currentDate).map((i) => i.data).toList(),
          )
        ],
      ),
    );
  }
}
