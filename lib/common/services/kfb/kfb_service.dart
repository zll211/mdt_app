import 'dart:convert';

import 'package:com.hzztai.mdt/common/services/http_service.dart';
import 'package:flutter_map/flutter_map.dart';

class KFBService {
  static Future<HttpFinalResult<KFBInfo>> getInfo(String filePath) async {
    final response = await HttpService.get('/kfb/info', params: {
      'file': filePath
    }, needAuth: true);
    if (response.error.isEmpty) {
      print(response.data);
      print(jsonDecode(response.data));
      return HttpFinalResult(response.error, KFBInfo.fromJson(jsonDecode(response.data)));
    } else {
      return HttpFinalResult(response.error, null);
    }
  }
}
