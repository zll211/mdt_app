// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invitee _$InviteeFromJson(Map<String, dynamic> json) {
  return Invitee(
      id: json['id'] as int ?? 0,
      consultationId: json['consultation_id'] as String ?? '',
      consultationOption: Invitee._recordFromData(
          json['consultation_option'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String ?? initTime,
      updatedAt: json['updated_at'] as String ?? initTime,
      userId: json['user_id'] as String ?? '',
      affirm: json['affirm'] as String ?? '',
      user: Invitee._userFromData(json['user'] as Map<String, dynamic>));
}

Map<String, dynamic> _$InviteeToJson(Invitee instance) => <String, dynamic>{
      'id': instance.id,
      'consultation_id': instance.consultationId,
      'consultation_option': Invitee._dataToRecord(instance.consultationOption),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'user_id': instance.userId,
      'affirm': instance.affirm,
      'user': Invitee._dataToUser(instance.user)
    };
