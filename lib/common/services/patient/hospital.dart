import 'package:json_annotation/json_annotation.dart';

part 'hospital.g.dart';

@JsonSerializable()
class Hospital {
  @JsonKey(name: 'case_no', defaultValue: '')
  final String caseNo;
  @JsonKey(name: 'hospital', defaultValue: '')
  final String hospitalName;
  @JsonKey(name: 'section', defaultValue: '')
  final String hospitalSectionName;
  @JsonKey(name: 'doctor', defaultValue: '')
  final String doctorName;
  @JsonKey(name: 'visiting_cate', defaultValue: '')
  final String visitingCate;
  @JsonKey(name: 'outpatient_no', defaultValue: '')
  final String outpatientNo;
  @JsonKey(name: 'inpatient_no', defaultValue: '')
  final String inpatientNo;
  @JsonKey(name: 'bed_no', defaultValue: '')
  final String bedNo;
  @JsonKey(name: 'visiting_time', defaultValue: '')
  final visitingTime;

  Hospital({
    this.caseNo = '',
    this.hospitalName = '',
    this.hospitalSectionName = '',
    this.doctorName = '',
    this.visitingCate = '',
    this.outpatientNo = '',
    this.inpatientNo = '',
    this.bedNo = '',
    this.visitingTime = '',
  });

  factory Hospital.fromJson(Map<String, dynamic> json) => json == null ? Hospital() : _$HospitalFromJson(json);

  Map<String, dynamic> toJson() => _$HospitalToJson(this);
}
