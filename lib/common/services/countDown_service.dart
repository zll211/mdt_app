import 'dart:async';

import 'package:rxdart/rxdart.dart' as Rx;

class _AppResumedService {
  final _appResumed = new Rx.BehaviorSubject<bool>();

  Stream<bool> get appResumed$ => _appResumed.stream;
  final _appResumedStreamController = new StreamController<bool>();

  Sink<bool> get appDoResumed => _appResumed.sink;

  _AppResumedService() {
    _appResumedStreamController.stream.listen((count) {
      _appResumed.add(count);
    });
  }

  dispose() {
    _appResumed.close();
    _appResumedStreamController.close();
  }
}

final _appResumedS = new _AppResumedService();

class CountDownService {
  static Sink<bool> get appResumed => _appResumedS.appDoResumed;
  Duration _countDownSecond;
  DateTime _startTime;

  final _countDownStreamController = new StreamController<Duration>();

  Sink<Duration> get startCountDown => _countDownStreamController.sink;

  Stream<int> get _stop$ => _appResumedS.appResumed$.where((_) => _countDownSecond != null).map((isResumed) {
        print("_appResumedStreamController, $isResumed");
        return isResumed;
      }).transform(Rx.SwitchMapStreamTransformer((isResumed) {
        // app 退到后台
        if (!isResumed) {
          return Stream.fromIterable([0]);
        }
        return Rx.TimerStream(1, _countDownSecond);
      }));

  final _countDownSub = Rx.BehaviorSubject<int>();

  Stream<int> get countDown$ => _countDownSub.stream;
  StreamSubscription<int> _countSubscription;

  CountDownService() {
    print(" ----new CountDownService ----");
    _countSubscription = Rx.MergeStream([
      _countDownStreamController.stream.where((count) => !count.isNegative).map((count) {
        _appResumedS.appDoResumed.add(true);
        return count;
      }),
      _appResumedS.appResumed$.where((isResumed) => _countDownSecond != null && isResumed).map((_) {
        final _sleepTime = _countDownSecond.inMilliseconds - DateTime.now().difference(_startTime).inMilliseconds;
        final _sleepSecond = (_sleepTime / 1000).ceil();
        // app 从后台回复，倒计时还有时间
        if (_sleepSecond > 0) {
          _countDownSecond = Duration(seconds: _sleepSecond);
          return _countDownSecond;
        } else {
          // app 从后台回复，倒计时已经结束
          _countDownSecond = Duration(seconds: 0);
          return _countDownSecond;
        }
      })
    ]).map((count) {
      _countDownSecond = count;
      _startTime = DateTime.now();
      return count;
    }).transform(Rx.SwitchMapStreamTransformer((count) {
      if (count.inSeconds <= 0) {
        return Stream.fromIterable([0]);
      }
      return Stream.periodic(const Duration(seconds: 1), (num) => _countDownSecond.inSeconds - num - 1)
          .transform(Rx.StartWithStreamTransformer<int>(_countDownSecond.inSeconds))
          .transform(Rx.TakeUntilStreamTransformer(_stop$));
    })).listen((count) {
      _countDownSub.add(count);
    });
  }

  dispose() {
    _countSubscription.cancel();
    _countDownStreamController.close();
    _countDownSub.close();
  }
}
