// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Record _$RecordFromJson(Map<String, dynamic> json) {
  return Record(
      id: json['id'] as int ?? 0, content: json['content'] as String ?? '');
}

Map<String, dynamic> _$RecordToJson(Record instance) =>
    <String, dynamic>{'id': instance.id, 'content': instance.content};
