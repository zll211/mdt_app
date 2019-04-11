// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organization _$OrganizationFromJson(Map<String, dynamic> json) {
  return Organization(
      id: json['id'] as int ?? 0, name: json['name'] as String ?? '');
}

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
