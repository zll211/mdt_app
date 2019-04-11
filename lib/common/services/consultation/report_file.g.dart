// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportFile _$ReportFileFromJson(Map<String, dynamic> json) {
  return ReportFile(
      id: json['id'] as int ?? 0,
      consultationReportId: json['consultation_report_id'] as String ?? '',
      path: json['path'] as String ?? '',
      thumbnail: json['thumbnail'] as String ?? '',
      fileName: json['filename'] as String ?? '',
      remark: json['remark'] as String ?? '');
}

Map<String, dynamic> _$ReportFileToJson(ReportFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'consultation_report_id': instance.consultationReportId,
      'path': instance.path,
      'thumbnail': instance.thumbnail,
      'filename': instance.fileName,
      'remark': instance.remark
    };
