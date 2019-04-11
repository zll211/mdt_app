import 'package:com.hzztai.mdt/common/services/config.dart';
import 'package:com.hzztai.mdt/common/services/consultation/consultation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'system_notify.g.dart';

enum SystemNotifyEnum { consultation }

@JsonSerializable()
class SystemNotify {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(name: 'pub_time', defaultValue: initTime)
  final String time;
  @JsonKey(defaultValue: '')
  final String notification;
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(nullable: false, fromJson: _typeFromData, toJson: _dataToType)
  final SystemNotifyEnum type;
  @JsonKey(defaultValue: '')
  final String icon;
  @JsonKey(nullable: false, fromJson: _consultationFromData, toJson: _dataToConsultation)
  Consultation consultation;

  SystemNotify({
    this.id = -1,
    this.time: initTime,
    this.notification = '',
    this.title = '',
    this.type = SystemNotifyEnum.consultation,
    Consultation consultation,
    this.icon: '',
  }) {
    this.consultation = consultation ?? Consultation();
  }

  factory SystemNotify.fromJson(Map<String, dynamic> json) =>
      json == null ? SystemNotify() : _$SystemNotifyFromJson(json);

  Map<String, dynamic> toJson() => _$SystemNotifyToJson(this);

  static bool _hasReadFromData(String status) {
    assert(status != null);
    return status == '已读';
  }

  static String _dataToHasRead(bool hasRead) {
    assert(hasRead != null);
    return hasRead ? '已读' : '未读';
  }

  static Consultation _consultationFromData(Map<String, dynamic> data) {
    if (data == null) {
      return Consultation();
    }
    return Consultation.fromJson(data);
  }

  static Map<String, dynamic> _dataToConsultation(Consultation data) {
    return data.toJson();
  }

  static SystemNotifyEnum _typeFromData(String type) {
    switch (type) {
      case 'consultation':
        return SystemNotifyEnum.consultation;
      default:
        return SystemNotifyEnum.consultation;
    }
  }

  static String _dataToType(SystemNotifyEnum type) {
    switch (type) {
      case SystemNotifyEnum.consultation:
        return 'consultation';
      default:
        return 'consultation';
    }
  }
}
