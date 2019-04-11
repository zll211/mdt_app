import 'package:com.hzztai.mdt/common/services/config.dart';
import 'package:com.hzztai.mdt/common/services/consultation/report_file.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable()
class Report {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(name: 'consultation_id', defaultValue: '')
  final String consultationId;
  @JsonKey(name: 'case_id', defaultValue: '')
  final String caseId;
  @JsonKey(defaultValue: '')
  final String content;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(defaultValue: '')
  final String reason;
  @JsonKey(name: 'created_at', defaultValue: initTime)
  final String createdAt;
  @JsonKey(name: 'updated_at', defaultValue: initTime)
  final String updatedAt;
  @JsonKey(name: 'report_img', nullable: false, fromJson: _imagesFromData, toJson: _dataToImages)
  final List<ReportFile> reportImages;

  Report({
    this.id = 0,
    this.consultationId = '',
    this.caseId = '',
    this.content = '',
    this.description = '',
    this.reason = '',
    this.createdAt: initTime,
    this.updatedAt: initTime,
    this.reportImages = const [],
  });

  factory Report.fromJson(Map<String, dynamic> json) => json == null ? Report() : _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);

  static List<ReportFile> _imagesFromData(List<dynamic> data) {
    return data == null ? [] : data.map((i) => ReportFile.fromJson(i)).toList();
  }

  static List<dynamic> _dataToImages(List<ReportFile> images) {
    return images.map((i) => i.toJson()).toList();
  }
}
