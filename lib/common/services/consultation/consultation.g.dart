// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consultation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Consultation _$ConsultationFromJson(Map<String, dynamic> json) {
  return Consultation(
      id: json['id'] as int ?? 0,
      consultationNumber: json['consultation_number'] as String ?? '',
      caseId: json['case_id'] as String ?? '',
      applyDoctorId: json['user_id'] as String ?? '',
      objective: json['objective'] as String ?? '',
      reason: json['reason'] as String ?? '',
      isReservation: Consultation._reservationFromData(json['type'] as String),
      status: Consultation._statusFromData(json['status'] as String),
      applicationAt: json['application_at'] as String ?? initTime,
      reservationAt: json['reservation_at'] as String ?? initTime,
      finishAt: json['finish_at'] as String ?? initTime,
      hxGroupId: json['group_id'] as String ?? '',
      hxGroupName: json['group_name'] as String ?? '',
      remark: json['remark'] as String ?? '',
      inviteeDoctors: Consultation._inviteeFromData(json['invitee'] as List),
      applyDoctor: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      patient:
          Consultation._patientFromData(json['case'] as Map<String, dynamic>),
      report: Consultation._reportFromData(
          json['consultation_report'] as Map<String, dynamic>),
      consultationActions:
          Consultation._actionsFromData(json['consultation_action'] as List));
}

Map<String, dynamic> _$ConsultationToJson(Consultation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'consultation_number': instance.consultationNumber,
      'case_id': instance.caseId,
      'user_id': instance.applyDoctorId,
      'objective': instance.objective,
      'reason': instance.reason,
      'type': Consultation._dataToReservation(instance.isReservation),
      'status': Consultation._dataToStatus(instance.status),
      'application_at': instance.applicationAt,
      'reservation_at': instance.reservationAt,
      'finish_at': instance.finishAt,
      'group_id': instance.hxGroupId,
      'group_name': instance.hxGroupName,
      'remark': instance.remark,
      'invitee': Consultation._dataToInvitee(instance.inviteeDoctors),
      'user': instance.applyDoctor,
      'case': Consultation._dataToPatient(instance.patient),
      'consultation_report': Consultation._dataToReport(instance.report),
      'consultation_action':
          Consultation._dataToActions(instance.consultationActions)
    };
