import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable()
class Organization {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String name;

  Organization({
    this.id = 0,
    this.name = '',
  });

  factory Organization.fromJson(Map<String, dynamic> json) =>
      json == null ? Organization() : _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}
