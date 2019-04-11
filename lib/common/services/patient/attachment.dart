import 'package:json_annotation/json_annotation.dart';

part 'attachment.g.dart';

enum AttachmentType { ct, mri, cr, dr, dsa, rf, us, ultrasonic, endoscopy, kfb, ecg, other }

@JsonSerializable()
class Attachment {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(name: 'case_id', defaultValue: '')
  final String caseID;
  @JsonKey(nullable: false, fromJson: _typeFromData, toJson: _dataToType)
  final AttachmentType type;
  @JsonKey(name: 'filename', defaultValue: '')
  final String fileName;
  @JsonKey(defaultValue: '')
  final String path;

  Attachment({
    this.id = 0,
    this.caseID = '',
    this.type = AttachmentType.other,
    this.fileName = '',
    this.path = '',
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => json == null ? Attachment() : _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);

  static AttachmentType _typeFromData(String type) {
    switch (type) {
      case 'CT':
        return AttachmentType.ct;
      case 'MRI':
        return AttachmentType.mri;
      case 'CR':
        return AttachmentType.cr;
      case 'DR':
        return AttachmentType.dr;
      case 'DSA':
        return AttachmentType.dsa;
      case 'RF':
        return AttachmentType.rf;
      case 'US':
        return AttachmentType.us;
      case '超声':
        return AttachmentType.ultrasonic;
      case '内镜':
        return AttachmentType.endoscopy;
      case '病理':
        return AttachmentType.kfb;
      case '心电图':
        return AttachmentType.ecg;
      default:
        return AttachmentType.other;
    }
  }

  static String _dataToType(AttachmentType status) {
    switch (status) {
      case AttachmentType.ct:
        return 'CT';
      case AttachmentType.mri:
        return 'MRI';
      case AttachmentType.cr:
        return 'CR';
      case AttachmentType.dr:
        return 'DR';
      case AttachmentType.dsa:
        return 'DSA';
      case AttachmentType.rf:
        return 'RF';
      case AttachmentType.us:
        return 'US';
      case AttachmentType.ultrasonic:
        return '超声';
      case AttachmentType.endoscopy:
        return '内镜';
      case AttachmentType.kfb:
        return '病理';
      case AttachmentType.ecg:
        return '心电图';
      default:
        return '其他';
    }
  }
}
