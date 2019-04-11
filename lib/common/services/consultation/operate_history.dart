import 'package:com.hzztai.mdt/common/services/config.dart';
import 'package:com.hzztai.mdt/common/services/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'operate_history.g.dart';

enum OperateActionType {
  applyAdd,
  applyEdit,
  applyFailed,
  applyPassed,
  applyDeleted,
  videoOver,
  recordAdd,
  reportAdd,
  reportSubmit,
  reportFailed,
  reportPassed,
  other
}

@JsonSerializable()
class OperateHistory {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(name: 'action', nullable: false, fromJson: _actionFromData, toJson: _dataToAction)
  final OperateActionType actionType;
  @JsonKey(name: 'operate_at', defaultValue: initTime)
  final String operateAt;
  @JsonKey(name: 'consultation_id', defaultValue: '')
  final String consultationId;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(nullable: false, fromJson: _userFromData, toJson: _dataToUser)
  User user;
  @JsonKey(defaultValue: '')
  final String desc;
  @JsonKey(name: 'created_at', defaultValue: initTime)
  final String createdAt;
  @JsonKey(name: 'updated_at', defaultValue: initTime)
  final String updatedAt;

  OperateHistory({
    this.id = 0,
    this.actionType = OperateActionType.other,
    this.operateAt: initTime,
    this.consultationId = '',
    this.userId = '',
    this.desc = '',
    this.createdAt: initTime,
    this.updatedAt: initTime,
    User user,
  }) {
    this.user = user ?? User();
  }

  factory OperateHistory.fromJson(Map<String, dynamic> json) =>
      json == null ? OperateHistory() : _$OperateHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$OperateHistoryToJson(this);

  static OperateActionType _actionFromData(String status) {
    switch (status) {
      case '会诊申请':
        return OperateActionType.applyAdd;
      case '会诊申请修改':
        return OperateActionType.applyEdit;
      case '会诊审核不通过':
        return OperateActionType.applyFailed;
      case '会诊审核通过':
        return OperateActionType.applyPassed;
      case '会诊删除':
        return OperateActionType.applyDeleted;
      case '会诊视频结束':
        return OperateActionType.videoOver;
      case '会诊总结记录':
        return OperateActionType.recordAdd;
      case '会诊报告保存':
        return OperateActionType.reportAdd;
      case '报告提交审核':
        return OperateActionType.reportSubmit;
      case '报告审核不通过':
        return OperateActionType.reportFailed;
      case '报告审核通过':
        return OperateActionType.reportPassed;
      default:
        return OperateActionType.other;
    }
  }

  static String _dataToAction(OperateActionType status) {
    switch (status) {
      case OperateActionType.applyAdd:
        return '会诊申请';
      case OperateActionType.applyEdit:
        return '会诊申请修改';
      case OperateActionType.applyFailed:
        return '会诊审核不通过';
      case OperateActionType.applyPassed:
        return '会诊审核通过';
      case OperateActionType.applyDeleted:
        return '会诊删除';
      case OperateActionType.videoOver:
        return '会诊视频结束';
      case OperateActionType.recordAdd:
        return '会诊总结记录';
      case OperateActionType.reportAdd:
        return '会诊报告保存';
      case OperateActionType.reportSubmit:
        return '报告提交审核';
      case OperateActionType.reportFailed:
        return '报告审核不通过';
      case OperateActionType.reportPassed:
        return '报告审核通过';
      default:
        return '未知操作';
    }
  }

  static User _userFromData(Map<String, dynamic> info) {
    return info == null ? User() : User.fromJson(info);
  }

  static Map<String, dynamic> _dataToUser(User info) {
    return info.toJson();
  }
}
