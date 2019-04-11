import 'package:com.hzztai.mdt/common/services/config.dart';
import 'package:com.hzztai.mdt/common/services/consultation/record.dart';
import 'package:com.hzztai.mdt/common/services/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invitee.g.dart';

@JsonSerializable()
class Invitee {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(name: 'consultation_id', defaultValue: '')
  final String consultationId;
  @JsonKey(name: 'consultation_option', nullable: false, fromJson: _recordFromData, toJson: _dataToRecord)
  final Record consultationOption;
  @JsonKey(name: 'created_at', defaultValue: initTime)
  final String createdAt;
  @JsonKey(name: 'updated_at', defaultValue: initTime)
  final String updatedAt;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(defaultValue: '')
  final String affirm;
  @JsonKey(nullable: false, fromJson: _userFromData, toJson: _dataToUser)
  User user;

  Invitee({
    this.id = 0,
    this.consultationId = '',
    this.consultationOption,
    this.createdAt: initTime,
    this.updatedAt: initTime,
    this.userId = '',
    this.affirm = '',
    User user,
  }) {
    this.user = user ?? User();
  }

  factory Invitee.fromJson(Map<String, dynamic> json) => json == null ? Invitee() : _$InviteeFromJson(json);

  Map<String, dynamic> toJson() => _$InviteeToJson(this);

  static User _userFromData(Map<String, dynamic> data) {
    if (data == null) {
      return User();
    } else {
      return User.fromJson(data);
    }
  }

  static Map<String, dynamic> _dataToUser(User user) {
    return user.toJson();
  }

  static Record _recordFromData(Map<String, dynamic> data) {
    if (data == null) {
      return Record();
    } else {
      return Record.fromJson(data);
    }
  }

  static Map<String, dynamic> _dataToRecord(Record data) {
    return data.toJson();
  }
}
