import 'package:com.hzztai.mdt/common/services/patient/attachment.dart';
import 'package:com.hzztai.mdt/common/services/patient/extension.dart';
import 'package:com.hzztai.mdt/common/services/patient/hospital.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(name: 'patient_name', defaultValue: '')
  final String name;
  @JsonKey(defaultValue: '')
  final String age;
  @JsonKey(name: 'age_unit', defaultValue: '')
  final String ageUnit;
  @JsonKey(defaultValue: '')
  final String gender;
  @JsonKey(name: 'marital_status', defaultValue: '')
  final String maritalStatus;
  @JsonKey(name: 'papers_type', defaultValue: '')
  final String papersType;
  @JsonKey(name: 'papers_number', defaultValue: '')
  final String papersNumber;
  @JsonKey(defaultValue: '')
  final String address;
  @JsonKey(defaultValue: '')
  final String phone;
  @JsonKey(defaultValue: '')
  final String nation;
  @JsonKey(name: 'create_user_id', defaultValue: '')
  final String createUserId;
  @JsonKey(defaultValue: '')
  final String career;
  @JsonKey(name: 'ext', nullable: false, fromJson: _extensionFromData, toJson: _dataToExtension)
  Extension extension;
  @JsonKey(nullable: false, fromJson: _attachmentFromData, toJson: _dataToAttachment)
  List<Attachment> attachment;
  @JsonKey(name: 'case_hospital', nullable: false, fromJson: _hospitalFromData, toJson: _dataToHospital)
  Hospital hospital;

  Patient({
    this.id = 0,
    this.name = '',
    this.age = '',
    this.ageUnit = '',
    this.gender = '',
    this.maritalStatus = '',
    this.papersType = '',
    this.papersNumber = '',
    this.address = '',
    this.phone = '',
    this.nation = '',
    this.createUserId = '',
    this.career = '',
    Extension extension,
    this.attachment = const [],
    Hospital hospital,
  }) {
    this.extension = extension ?? Extension();
    this.hospital = hospital ?? Hospital();
  }

  factory Patient.fromJson(Map<String, dynamic> json) => json == null ? Patient() : _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);

  static Extension _extensionFromData(Map<String, dynamic> info) {
    return info == null ? Extension() : Extension.fromJson(info);
  }

  static Map<String, dynamic> _dataToExtension(Extension info) {
    return info.toJson();
  }

  static List<Attachment> _attachmentFromData(List<dynamic> info) {
    if (info == null) {
      return [];
    } else {
      return info.map((i) => Attachment.fromJson(i)).toList();
    }
  }

  static List<dynamic> _dataToAttachment(List<Attachment> info) {
    return info.map((i) => i.toJson()).toList();
  }

  static Hospital _hospitalFromData(Map<String, dynamic> info) {
    return info == null ? Hospital() : Hospital.fromJson(info);
  }

  static Map<String, dynamic> _dataToHospital(Hospital info) {
    return info.toJson();
  }
}
