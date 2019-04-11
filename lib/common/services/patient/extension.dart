import 'package:json_annotation/json_annotation.dart';

part 'extension.g.dart';

@JsonSerializable()
class Extension {
  @JsonKey(defaultValue: '')
  final String summary;
  @JsonKey(name: 'test_result', defaultValue: '')
  final String testResult;
  @JsonKey(name: 'check_report', defaultValue: '')
  final String checkReport;

  Extension({
    this.summary = '',
    this.testResult = '',
    this.checkReport = '',
  });

  factory Extension.fromJson(Map<String, dynamic> json) => json == null ? Extension() : _$ExtensionFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionToJson(this);
}
