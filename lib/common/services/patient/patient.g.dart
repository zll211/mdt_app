// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
      id: json['id'] as int ?? 0,
      name: json['patient_name'] as String ?? '',
      age: json['age'] as String ?? '',
      ageUnit: json['age_unit'] as String ?? '',
      gender: json['gender'] as String ?? '',
      maritalStatus: json['marital_status'] as String ?? '',
      papersType: json['papers_type'] as String ?? '',
      papersNumber: json['papers_number'] as String ?? '',
      address: json['address'] as String ?? '',
      phone: json['phone'] as String ?? '',
      nation: json['nation'] as String ?? '',
      createUserId: json['create_user_id'] as String ?? '',
      career: json['career'] as String ?? '',
      extension:
          Patient._extensionFromData(json['ext'] as Map<String, dynamic>),
      attachment: Patient._attachmentFromData(json['attachment'] as List),
      hospital: Patient._hospitalFromData(
          json['case_hospital'] as Map<String, dynamic>));
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'patient_name': instance.name,
      'age': instance.age,
      'age_unit': instance.ageUnit,
      'gender': instance.gender,
      'marital_status': instance.maritalStatus,
      'papers_type': instance.papersType,
      'papers_number': instance.papersNumber,
      'address': instance.address,
      'phone': instance.phone,
      'nation': instance.nation,
      'create_user_id': instance.createUserId,
      'career': instance.career,
      'ext': Patient._dataToExtension(instance.extension),
      'attachment': Patient._dataToAttachment(instance.attachment),
      'case_hospital': Patient._dataToHospital(instance.hospital)
    };
