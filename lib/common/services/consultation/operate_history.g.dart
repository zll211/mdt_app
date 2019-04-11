// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operate_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperateHistory _$OperateHistoryFromJson(Map<String, dynamic> json) {
  return OperateHistory(
      id: json['id'] as int ?? 0,
      actionType: OperateHistory._actionFromData(json['action'] as String),
      operateAt: json['operate_at'] as String ?? initTime,
      consultationId: json['consultation_id'] as String ?? '',
      userId: json['user_id'] as String ?? '',
      desc: json['desc'] as String ?? '',
      createdAt: json['created_at'] as String ?? initTime,
      updatedAt: json['updated_at'] as String ?? initTime,
      user: OperateHistory._userFromData(json['user'] as Map<String, dynamic>));
}

Map<String, dynamic> _$OperateHistoryToJson(OperateHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': OperateHistory._dataToAction(instance.actionType),
      'operate_at': instance.operateAt,
      'consultation_id': instance.consultationId,
      'user_id': instance.userId,
      'user': OperateHistory._dataToUser(instance.user),
      'desc': instance.desc,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt
    };
