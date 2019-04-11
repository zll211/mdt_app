import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:com.hzztai.mdt/common/services/user/user_service.dart';
import 'package:dio/dio.dart';

import './config.dart';

class HttpFinalResult<T> {
  String error = '';
  T data;
  HttpFinalResult(this.error, this.data);
}

class HttpResult {
  String error = '';
  dynamic data = {};

  HttpResult(this.error, this.data);

  static String defaultError = '出了一点小意外';

  static String unauthorized = '请先登录';

  static String forbidden = '未授权，无法访问';

  static String decodeError = '服务器连接失败';

  static String timeoutError = '连接超时，请重试';
}

enum HttpMethod { get, post, delete, put, patch, formPost, uploadFile }

final _userService = new UserService();

class _HttpRequest {
  static Future<HttpResult> request(String url, HttpMethod method, {dynamic body, Map<String, dynamic> params = const {},  bool needAuth = true}) async {
    try {
      BaseOptions options = BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: timeoutLimit,
        receiveTimeout: timeoutLimit,
      );
      Dio dio = Dio(options);
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
        client.badCertificateCallback=(X509Certificate cert, String host, int port){
          return true;
        };
      };
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      if (needAuth) {
        String _token = '';
        _token = await UserService.getToken();
        print('_token $_token');
        headers['Authorization'] = _token;
      }
      Response res;
      print('body');
      print(body);
      switch (method) {
        case HttpMethod.get:
          print(HttpMethod.get);
          print(params);
          res = await dio.get(url, queryParameters: params, options: Options(headers: headers));
          break;
        case HttpMethod.post:
          assert(body != null && body is Map);
          print(HttpMethod.post);
          res = await dio.post(url, data: body, options: Options(headers: headers));
          break;
        case HttpMethod.put:
          assert(body != null && body is Map);
          print(HttpMethod.put);
          res = await dio.put(url, data: jsonEncode(body), options: Options(headers: headers));
          break;
        case HttpMethod.delete:
          print(HttpMethod.delete);
          res = await dio.delete(url, options: Options(headers: headers));
          break;
        case HttpMethod.patch:
          print(HttpMethod.patch);
          res = await dio.patch(url, options: Options(headers: headers));
          break;
        case HttpMethod.formPost:
          assert(body != null && body is String);
          headers['Content-Type'] = "application/x-www-form-urlencoded; charset=UTF-8";
          res = await dio.post(url, data: body, options: Options(headers: headers));
          break;
        case HttpMethod.uploadFile:
          assert(body != null && body is Map);
          headers['Content-Type'] = 'multipart/form-data';
          res = await dio.post(url, data: body, options: Options(headers: headers));
          break;
      }

      print('${res.request.baseUrl}${res.request.path} ${res.statusCode}');
      String error = '';
      dynamic data = {};
      final _unauthorized = res.statusCode == 401;
      final _forbidden = res.statusCode == 403;
      if (_unauthorized || _forbidden) {
        error = '请登录';
        // TODO: 重新获取token
        _userService.logout();
      }
      data = res.data;
      print(data);
      return new HttpResult(error, data);
    } catch (e) {
      String errorStr = HttpResult.defaultError;
      if (e is DioError) {
        print('DioError');
        print('${e.request.method} ${e.request.baseUrl}${e.request.path}');
        if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
          errorStr = HttpResult.timeoutError;
        }
        if (e.type == DioErrorType.RESPONSE) {
          if (e.response.statusCode == 401) {
            errorStr = HttpResult.unauthorized;
            _userService.logout();
          }
          if (e.response.statusCode == 403) {
            errorStr = HttpResult.forbidden;
          }
        }
      }
      return new HttpResult(errorStr, {});
    }
  }
}

class HttpService {
  static Future<HttpResult> get(url, {bool needAuth = true,  Map<String, dynamic> params}) =>
      _HttpRequest.request(url, HttpMethod.get, params: params, needAuth: needAuth);

  static Future<HttpResult> post(String url, Map<String, dynamic> body, {bool needAuth}) =>
      _HttpRequest.request(url, HttpMethod.post, body: body, needAuth: needAuth);

  static Future<HttpResult> put(String url, Map<String, dynamic> body) =>
      _HttpRequest.request(url, HttpMethod.put, body: body, needAuth: true);

  static Future<HttpResult> delete(String url, Map<String, dynamic> body) =>
      _HttpRequest.request(url, HttpMethod.delete, body: body, needAuth: true);

  static Future<HttpResult> patch(String url, Map<String, dynamic> body) =>
      _HttpRequest.request(url, HttpMethod.patch, body: body, needAuth: true);
}
