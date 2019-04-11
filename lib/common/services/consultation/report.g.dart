// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) {
  return Report(
      id: json['id'] as int ?? 0,
      consultationId: json['consultation_id'] as String ?? '',
      caseId: json['case_id'] as String ?? '',
      content: json['content'] as String ?? '',
      description: json['description'] as String ?? '',
      reason: json['reason'] as String ?? '',
      createdAt: json['created_at'] as String ?? initTime,
      updatedAt: json['updated_at'] as String ?? initTime,
      reportImages: Report._imagesFromData(json['report_img'] as List));
}

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'consultation_id': instance.consultationId,
      'case_id': instance.caseId,
      'content': instance.content,
      'description': instance.description,
      'reason': instance.reason,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'report_img': Report._dataToImages(instance.reportImages)
    };
