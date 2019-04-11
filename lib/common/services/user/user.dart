import 'package:com.hzztai.mdt/common/services/user/organization.dart';
import 'package:com.hzztai.mdt/common/services/user/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  static String tokenKey = 'token';
  static String userKey = 'user';

  @JsonKey(defaultValue: 0)
  int id;
  @JsonKey(defaultValue: '')
  String username;
  @JsonKey(defaultValue: '')
  String email;
  @JsonKey(defaultValue: '')
  String avatar;
  @JsonKey(defaultValue: '')
  String mobile;
  @JsonKey(name: 'realname', defaultValue: '')
  String realName;
  @JsonKey(defaultValue: '')
  String gender;
  @JsonKey(defaultValue: '')
  String title;
  @JsonKey(name: 'hospital_id', defaultValue: '')
  String hospitalId;
  @JsonKey(name: 'organization_id', defaultValue: '')
  String organizationId;
  @JsonKey(name: 'hx_id', defaultValue: '')
  String hxId;
  @JsonKey(name: 'hx_pwd', defaultValue: '')
  String hxPwd;
  @JsonKey(nullable: false, fromJson: _rolesFromData, toJson: _dataToRoles)
  List<Role> roles;
  @JsonKey(nullable: false, fromJson: _organizationFromData, toJson: _dataToOrganization)
  Organization organization;
  @JsonKey(nullable: false, fromJson: _organizationFromData, toJson: _dataToOrganization)
  Organization hospital;

  User({
    this.id = -1,
    this.username = '',
    this.email = '',
    this.avatar = '',
    this.mobile = '',
    this.realName = '',
    this.gender = '',
    this.title = '',
    this.hospitalId = '',
    this.organizationId = '',
    this.hxId = '',
    this.hxPwd = '',
    this.roles = const [],
    Organization organization,
    Organization hospital,
  }) {
    this.hospital = hospital ?? Organization();
    this.organization = organization ?? Organization();
  }

  factory User.fromJson(Map<String, dynamic> json) => json == null ? User() : _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static List<Role> _rolesFromData(Map<String, dynamic> data) {
    if (data == null || !(data['data'] is List<dynamic>)) {
      return [];
    }
    final List<dynamic> _roles = data['data'];
    return _roles.map((i) => Role.fromJson(i)).toList();
  }

  static Map<String, dynamic> _dataToRoles(List<Role> roles) {
    assert(roles != null);
    Map<String, dynamic> data = {};
    data['data'] = roles.map((i) => i.toJson()).toList();
    return data;
  }

  static Organization _organizationFromData(Map<String, dynamic> info) {
    return info == null ? Organization() : Organization.fromJson(info);
  }

  static Map<String, dynamic> _dataToOrganization(Organization info) {
    return info.toJson();
  }
}
