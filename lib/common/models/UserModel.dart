import 'package:com.hzztai.mdt/common/services/user/user_service.dart';
import 'package:flutter/material.dart';

class UserModel extends InheritedModel<String> {
  final UserService userService;

  UserModel({this.userService, Widget child}) : super(child: child);

  static UserModel of(BuildContext context, String aspect) {
    return InheritedModel.inheritFrom<UserModel>(context, aspect: aspect);
  }

  @override
  bool updateShouldNotify(UserModel old) {
    return true;
  }

  @override
  bool updateShouldNotifyDependent(UserModel old, Set<String> aspects) {
    return (userService != old.userService && aspects.contains('user'));
  }
}
