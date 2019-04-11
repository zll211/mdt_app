import 'package:json_annotation/json_annotation.dart';

part 'report_file.g.dart';

@JsonSerializable()
class ReportFile {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(name: 'consultation_report_id', defaultValue: '')
  final String consultationReportId;
  @JsonKey(defaultValue: '')
  final String path;
  @JsonKey(defaultValue: '')
  final String thumbnail;
  @JsonKey(name: 'filename', defaultValue: '')
  final String fileName;
  @JsonKey(defaultValue: '')
  final String remark;

  ReportFile({
    this.id = 0,
    this.consultationReportId = '',
    this.path = '',
    this.thumbnail = '',
    this.fileName = '',
    this.remark = '',
  });

  factory ReportFile.fromJson(Map<String, dynamic> json) => json == null ? ReportFile() : _$ReportFileFromJson(json);

  Map<String, dynamic> toJson() => _$ReportFileToJson(this);
}
