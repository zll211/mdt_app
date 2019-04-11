// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hospital _$HospitalFromJson(Map<String, dynamic> json) {
  return Hospital(
      caseNo: json['case_no'] as String ?? '',
      hospitalName: json['hospital'] as String ?? '',
      hospitalSectionName: json['section'] as String ?? '',
      doctorName: json['doctor'] as String ?? '',
      visitingCate: json['visiting_cate'] as String ?? '',
      outpatientNo: json['outpatient_no'] as String ?? '',
      inpatientNo: json['inpatient_no'] as String ?? '',
      bedNo: json['bed_no'] as String ?? '',
      visitingTime: json['visiting_time'] ?? '');
}

Map<String, dynamic> _$HospitalToJson(Hospital instance) => <String, dynamic>{
      'case_no': instance.caseNo,
      'hospital': instance.hospitalName,
      'section': instance.hospitalSectionName,
      'doctor': instance.doctorName,
      'visiting_cate': instance.visitingCate,
      'outpatient_no': instance.outpatientNo,
      'inpatient_no': instance.inpatientNo,
      'bed_no': instance.bedNo,
      'visiting_time': instance.visitingTime
    };
