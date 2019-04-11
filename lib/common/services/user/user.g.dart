// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      id: json['id'] as int ?? 0,
      username: json['username'] as String ?? '',
      email: json['email'] as String ?? '',
      avatar: json['avatar'] as String ?? '',
      mobile: json['mobile'] as String ?? '',
      realName: json['realname'] as String ?? '',
      gender: json['gender'] as String ?? '',
      title: json['title'] as String ?? '',
      hospitalId: json['hospital_id'] as String ?? '',
      organizationId: json['organization_id'] as String ?? '',
      hxId: json['hx_id'] as String ?? '',
      hxPwd: json['hx_pwd'] as String ?? '',
      roles: User._rolesFromData(json['roles'] as Map<String, dynamic>),
      organization: User._organizationFromData(
          json['organization'] as Map<String, dynamic>),
      hospital:
          User._organizationFromData(json['hospital'] as Map<String, dynamic>));
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'avatar': instance.avatar,
      'mobile': instance.mobile,
      'realname': instance.realName,
      'gender': instance.gender,
      'title': instance.title,
      'hospital_id': instance.hospitalId,
      'organization_id': instance.organizationId,
      'hx_id': instance.hxId,
      'hx_pwd': instance.hxPwd,
      'roles': User._dataToRoles(instance.roles),
      'organization': User._dataToOrganization(instance.organization),
      'hospital': User._dataToOrganization(instance.hospital)
    };
