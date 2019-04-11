// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachment _$AttachmentFromJson(Map<String, dynamic> json) {
  return Attachment(
      id: json['id'] as int ?? 0,
      caseID: json['case_id'] as String ?? '',
      type: Attachment._typeFromData(json['type'] as String),
      fileName: json['filename'] as String ?? '',
      path: json['path'] as String ?? '');
}

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'case_id': instance.caseID,
      'type': Attachment._dataToType(instance.type),
      'filename': instance.fileName,
      'path': instance.path
    };
