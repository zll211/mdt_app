import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable()
class Role {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String name;

  Role({
    this.id = -1,
    this.name = '',
  });

  factory Role.fromJson(Map<String, dynamic> json) => json == null ? Role() : _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
