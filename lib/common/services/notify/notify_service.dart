import 'dart:async';

import 'package:com.hzztai.mdt/common/services/http_service.dart';
import 'package:com.hzztai.mdt/common/services/notify/system_notify.dart';
import 'package:com.hzztai.mdt/common/services/pagination/pagination.dart';
import 'package:rxdart/rxdart.dart' as Rx;

class NotifyService {
  final _systemNotifyUnreadSubject = Rx.BehaviorSubject<int>.seeded(0);

  Stream<int> get systemNotifyUnread$ => _systemNotifyUnreadSubject.stream;

  final _updateSystemNotifyUnreadController = StreamController<bool>();

  Sink<bool> get updateSystemNotifyUnread => _updateSystemNotifyUnreadController.sink;
  StreamSubscription _updateSystemNotifyUnreadSubscription;

  final _latestNotifySubject = Rx.BehaviorSubject<SystemNotify>();

  Stream<SystemNotify> get latestNotify$ => _latestNotifySubject.stream;

  final _updateLatestNotifyController = StreamController<bool>();

  Sink<bool> get updateLatestNotify => _updateLatestNotifyController.sink;
  StreamSubscription _updateLatestNotifySubscription;

  static NotifyService _single = new NotifyService._internal();

  factory NotifyService() => NotifyService._single;

  NotifyService._internal() {
    _updateSystemNotifyUnreadSubscription = _updateSystemNotifyUnreadController.stream
        .transform(
            Rx.SwitchMapStreamTransformer<bool, int>((_) => Stream.fromFuture(NotifyService.getNotifyStatistic())))
        .listen((count) {
      _systemNotifyUnreadSubject.add(count);
    });

    _updateLatestNotifySubscription = _updateLatestNotifyController.stream
        .transform(Rx.SwitchMapStreamTransformer<bool, PaginationData<SystemNotify>>(
            (_) => Stream.fromFuture(NotifyService.getSystemNotify())))
        .listen((data) {
      if (data.data.length > 0) {
        _latestNotifySubject.add(data.data.first);
      }
    });
  }

  /// 获取列表
  static Future<PaginationData<SystemNotify>> getSystemNotify({int page = 1, int pageSize = 15}) async {
    final response = await HttpService.get('/notification',
        needAuth: true, params: {'page_size': pageSize, 'page': page, 'include': 'consultation.room'});
    final List<dynamic> data = response.data['data'];
    return PaginationData(
        data: data.map((i) => SystemNotify.fromJson(i)).toList(),
        pagination: Pagination.fromJson(response.data['meta']['pagination']));
  }

  /// 获取详情
  static Future<SystemNotify> getSystemNotifyDetail(int id) async {
    final response = await HttpService.get('/notification/$id', needAuth: true);
    return SystemNotify.fromJson(response.data);
  }

  /// 获取统计
  static Future<int> getNotifyStatistic() async {
    final response = await HttpService.get('/notification_statistic', needAuth: true);
    if (response.error.isEmpty) {
      return response.data['data']['unread'] ?? 0;
    } else {
      return 0;
    }
  }

  dispose() {
    _systemNotifyUnreadSubject.close();
    _updateSystemNotifyUnreadController.close();
    _updateSystemNotifyUnreadSubscription.cancel();

    _latestNotifySubject.close();
    _updateLatestNotifyController.close();
    _updateLatestNotifySubscription.cancel();
  }
}
