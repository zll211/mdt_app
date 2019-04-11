// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extension.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Extension _$ExtensionFromJson(Map<String, dynamic> json) {
  return Extension(
      summary: json['summary'] as String ?? '',
      testResult: json['test_result'] as String ?? '',
      checkReport: json['check_report'] as String ?? '');
}

Map<String, dynamic> _$ExtensionToJson(Extension instance) => <String, dynamic>{
      'summary': instance.summary,
      'test_result': instance.testResult,
      'check_report': instance.checkReport
    };
