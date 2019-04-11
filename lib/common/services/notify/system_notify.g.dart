// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_notify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemNotify _$SystemNotifyFromJson(Map<String, dynamic> json) {
  return SystemNotify(
      id: json['id'] as int ?? 0,
      time: json['pub_time'] as String ?? initTime,
      notification: json['notification'] as String ?? '',
      title: json['title'] as String ?? '',
      type: SystemNotify._typeFromData(json['type'] as String),
      consultation: SystemNotify._consultationFromData(
          json['consultation'] as Map<String, dynamic>),
      icon: json['icon'] as String ?? '');
}

Map<String, dynamic> _$SystemNotifyToJson(SystemNotify instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pub_time': instance.time,
      'notification': instance.notification,
      'title': instance.title,
      'type': SystemNotify._dataToType(instance.type),
      'icon': instance.icon,
      'consultation': SystemNotify._dataToConsultation(instance.consultation)
    };
