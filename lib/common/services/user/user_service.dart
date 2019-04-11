import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:com.hzztai.mdt/common/services/config.dart';
import 'package:com.hzztai.mdt/common/services/http_service.dart';
import 'package:com.hzztai.mdt/common/services/user/user.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart' as Rx;
import 'package:shared_preferences/shared_preferences.dart';

String _localToken = '';

class UserService {
  bool hasFreshToken = false;
  final _userSubject = Rx.BehaviorSubject<User>();

  Stream<User> get user$ => _userSubject.stream;

  final _authStatusSubject = Rx.BehaviorSubject<bool>();

  Stream<bool> get authStatus$ => _authStatusSubject.stream;

  static UserService _single = new UserService._internal();

  factory UserService() => UserService._single;

  UserService._internal() {
    this.init();
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _userString = prefs.getString(User.userKey);
    if (_userString == null) {
      _authStatusSubject.add(false);
    } else {
      await this.refresh();
      final _user = User.fromJson(jsonDecode(_userString));
      _userSubject.add(_user);
      _authStatusSubject.add(true);
    }
  }

  /// 退出
  logout() async {
    await UserService.delToken();
    await UserService.delUser();
//    await HttpService.post('/logout', {}, needAuth: true);
    _userSubject.add(User());
    _authStatusSubject.add(false);
  }

  static setToken(String token) async {
    _localToken = token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(User.tokenKey, _localToken);
  }

  static Future<String> getToken() async {
    if (_localToken.isNotEmpty) {
      return _localToken;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _token = prefs.getString(User.tokenKey) ?? '';
    _localToken = _token;
    if (_token.isNotEmpty) {}
    return _token;
  }

  static delToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(User.tokenKey);
  }

  static setUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(User.userKey, jsonEncode(user.toJson()));
  }

  static delUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(User.userKey);
  }

  /// 登录
  Future<String> login({@required String username, @required String password}) async {
    final response =
        await HttpService.post('/login', {'username': username, 'password': password, 'from': 'app'}, needAuth: false);
    if (response.error.isEmpty) {
      final _user = User.fromJson(response.data['user']);
      await UserService.setUser(_user);
      _userSubject.add(_user);
      _authStatusSubject.add(true);
      final _token = 'bearer ${response.data['access_token']}';
      UserService.setToken(_token);
    }
    return response.error;
  }

  /// 获取验证码
  Future<HttpResult> smsCode({@required params}) async {
    final response = await HttpService.post('/sms_code', params, needAuth: false);
    return response;
  }

  ///手机登录
  Future<String> loginByMobile({@required String key, @required String code}) async {
    final response = await HttpService.post('/sms_login', {'sms_key': key, 'code': code}, needAuth: false);
    if (response.error.isEmpty) {
      final _user = User.fromJson(response.data['user']);
      await UserService.setUser(_user);
      _userSubject.add(_user);
      _authStatusSubject.add(true);
      final _token = 'bearer ${response.data['access_token']}';
      UserService.setToken(_token);
    }
    return response.error;
  }

  /// 刷新token
  Future<void> refresh() async {
    final response = await HttpService.post('/refresh', {'from': 'app'}, needAuth: true);
    if (response.error.isEmpty) {
      await UserService.setToken('bearer ${response.data['access_token']}');
    } else {
      this.logout();
    }
  }

  /// 获取用户信息
  Future<String> getUserInfo(id) async {
    final response = await HttpService.get('/users/$id', params: {'include': 'organization, roles, hospital'});
    if (response.error.isEmpty) {
      final _user = User.fromJson(response.data);
      await UserService.setUser(_user);
      _userSubject.add(_user);
    }
    return response.error;
  }

  ///修改用户信息
  Future<String> modifyUserInfo(id, params) async {
    final response = await HttpService.put('/users/$id', params);
    if (response.error.isEmpty) {
      final _user = User.fromJson(response.data);
      await UserService.setUser(_user);
      _userSubject.add(_user);
    }
    return response.error;
  }

  /// 修改手机号
  Future<String> modifyMobile(params) async {
    final response = await HttpService.patch('/user/mobile', params);
    return response.error;
  }

  /// 压缩并上传图片
  static Future<StreamedResponse> compressAndUploadImage(File image,
      {String uploadURL = '$apiHost/api/im/upload_image'}) async {
    try {
      int _startCompress = DateTime.now().millisecondsSinceEpoch;
      List<int> _imageBytes = await FlutterImageCompress.compressWithFile(
        image.absolute.path,
        minHeight: 1000,
        minWidth: 1000,
        quality: 88,
      );
      image..writeAsBytesSync(_imageBytes);
      int _endCompress = DateTime.now().millisecondsSinceEpoch;
      print('compressImage cost ${_endCompress - _startCompress}');
      var stream = new ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      var uri = Uri.parse(uploadURL);
      var request = new MultipartRequest("POST", uri);
      var multipartFile = new MultipartFile('file', stream, length, filename: basename(image.path));
      request.files.add(multipartFile);
      final String _token = await UserService.getToken();
      request.headers.addAll({"Authorization": _token});
      var response = await request.send();
      return response;
    } catch (e) {
      print('compressImage error $e');
      return null;
    }
  }
}
