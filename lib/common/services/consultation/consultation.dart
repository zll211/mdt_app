import 'package:com.hzztai.mdt/common/services/config.dart';
import 'package:com.hzztai.mdt/common/services/consultation/invitee.dart';
import 'package:com.hzztai.mdt/common/services/consultation/operate_history.dart';
import 'package:com.hzztai.mdt/common/services/consultation/report.dart';
import 'package:com.hzztai.mdt/common/services/patient/patient.dart';
import 'package:com.hzztai.mdt/common/services/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'consultation.g.dart';

enum ConsultationStatusEnum {
  verifying,
  passed,
  refused,
  recorded,
  reportVerifying,
  reportRefused,
  reportVerified,
  ended
}

@JsonSerializable()
class Consultation {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(name: 'consultation_number', defaultValue: '')
  final String consultationNumber;
  @JsonKey(name: 'case_id', defaultValue: '')
  final String caseId;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String applyDoctorId;
  @JsonKey(defaultValue: '')
  final String objective;
  @JsonKey(defaultValue: '')
  final String reason;
  @JsonKey(name: 'type', nullable: false, fromJson: _reservationFromData, toJson: _dataToReservation)
  final bool isReservation;
  @JsonKey(nullable: false, fromJson: _statusFromData, toJson: _dataToStatus)
  final ConsultationStatusEnum status;
  @JsonKey(name: 'application_at', defaultValue: initTime)
  final String applicationAt;
  @JsonKey(name: 'reservation_at', defaultValue: initTime)
  final String reservationAt;
  @JsonKey(name: 'finish_at', defaultValue: initTime)
  final String finishAt;
  @JsonKey(name: 'group_id', defaultValue: '')
  final String hxGroupId;
  @JsonKey(name: 'group_name', defaultValue: '')
  final String hxGroupName;
  @JsonKey(defaultValue: '')
  final String remark;
  @JsonKey(name: 'invitee', nullable: false, fromJson: _inviteeFromData, toJson: _dataToInvitee)
  final List<Invitee> inviteeDoctors;
  @JsonKey(name: 'user')
  User applyDoctor;
  @JsonKey(name: 'case', nullable: false, fromJson: _patientFromData, toJson: _dataToPatient)
  Patient patient;
  @JsonKey(name: 'consultation_report', nullable: false, fromJson: _reportFromData, toJson: _dataToReport)
  Report report;
  @JsonKey(name: 'consultation_action', nullable: false, fromJson: _actionsFromData, toJson: _dataToActions)
  final List<OperateHistory> consultationActions;

  Consultation({
    this.id = 0,
    this.consultationNumber = '',
    this.caseId = '',
    this.applyDoctorId = '',
    this.objective = '',
    this.reason = '',
    this.isReservation = true,
    this.status = ConsultationStatusEnum.verifying,
    this.applicationAt: initTime,
    this.reservationAt: initTime,
    this.finishAt: initTime,
    this.hxGroupId = '',
    this.hxGroupName = '',
    this.remark = '',
    this.inviteeDoctors = const [],
    User applyDoctor,
    Patient patient,
    Report report,
    this.consultationActions = const [],
  }) {
    this.applyDoctor = applyDoctor ?? User();
    this.patient = patient ?? Patient();
    this.report = report ?? Report();
  }

  factory Consultation.fromJson(Map<String, dynamic> json) =>
      json == null ? Consultation() : _$ConsultationFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultationToJson(this);

  static bool _reservationFromData(String type) {
    return type == '预约会诊';
  }

  static String _dataToReservation(bool isReservation) {
    return isReservation ? '预约会诊' : '即时会诊';
  }

  static ConsultationStatusEnum _statusFromData(String status) {
    switch (status) {
      case '审核中':
        return ConsultationStatusEnum.verifying;
      case '已通过':
        return ConsultationStatusEnum.passed;
      case '未通过':
        return ConsultationStatusEnum.refused;
      case '已记录':
        return ConsultationStatusEnum.recorded;
      case '报告待审核':
        return ConsultationStatusEnum.reportVerifying;
      case '报告未通过':
        return ConsultationStatusEnum.reportRefused;
      case '报告已审核':
        return ConsultationStatusEnum.reportVerified;
      case '已结束':
        return ConsultationStatusEnum.ended;
      default:
        return ConsultationStatusEnum.verifying;
    }
  }

  static String _dataToStatus(ConsultationStatusEnum status) {
    switch (status) {
      case ConsultationStatusEnum.verifying:
        return '审核中';
      case ConsultationStatusEnum.passed:
        return '已通过';
      case ConsultationStatusEnum.refused:
        return '未通过';
      case ConsultationStatusEnum.recorded:
        return '已记录';
      case ConsultationStatusEnum.reportVerifying:
        return '报告待审核';
      case ConsultationStatusEnum.reportRefused:
        return '报告未通过';
      case ConsultationStatusEnum.reportVerified:
        return '报告已审核';
      case ConsultationStatusEnum.ended:
        return '已结束';
      default:
        return '审核中';
    }
  }

  static List<Invitee> _inviteeFromData(List<dynamic> invitee) {
    if (invitee == null) {
      return [];
    }
    return invitee.map((i) => Invitee.fromJson(i)).toList();
  }

  static List<dynamic> _dataToInvitee(List<Invitee> inviteeDoctors) {
    return inviteeDoctors.map((i) => i.toJson()).toList();
  }

  static Patient _patientFromData(Map<String, dynamic> info) {
    return info == null ? Patient() : Patient.fromJson(info);
  }

  static Map<String, dynamic> _dataToPatient(Patient info) {
    return info.toJson();
  }

  static Report _reportFromData(Map<String, dynamic> info) {
    return info == null ? Report() : Report.fromJson(info);
  }

  static Map<String, dynamic> _dataToReport(Report info) {
    return info.toJson();
  }

  static List<OperateHistory> _actionsFromData(List<dynamic> data) {
    if (data == null) {
      return [];
    }
    return data.map((i) => OperateHistory.fromJson(i)).toList();
  }

  static List<dynamic> _dataToActions(List<OperateHistory> data) {
    return data.map((i) => i.toJson()).toList();
  }
}
