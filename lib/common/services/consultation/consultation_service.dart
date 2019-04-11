import 'dart:async';

import 'package:com.hzztai.mdt/common/services/consultation/consultation.dart';
import 'package:com.hzztai.mdt/common/services/consultation/operate_history.dart';
import 'package:com.hzztai.mdt/common/services/http_service.dart';
import 'package:com.hzztai.mdt/common/services/pagination/pagination.dart';

class ConsultationService {
  /// 获取会诊列表
  static Future<PaginationData<Consultation>> getList(
      {int page = 1, int pageSize = 15, bool history = false, String keyword: ''}) async {
    Map<String, dynamic> params = {
      'keyword': keyword,
      'interface_type': 'plan',
      'invitee': 1,
      'order': [
        ['reservation_at', 'asc']
      ]
    };
    if (history) {
      params['page'] = page;
      params['page_size'] = pageSize;
      params['status'] = ['已结束', '报告待审核', '报告未通过', '报告已审核'];
    } else {
      params['get_all'] = 1;
      params['status'] = ['已通过'];
    }
    final response = await HttpService.get('/consultation', params: params, needAuth: true);
    if (response.error.isEmpty) {
      final List<dynamic> data = response.data['data'];
      return PaginationData(
          data: data.map((i) => Consultation.fromJson(i)).toList(),
          pagination:
              response.data['meta'] == null ? Pagination() : Pagination.fromJson(response.data['meta']['pagination']));
    } else {
      return PaginationData(data: [], pagination: Pagination());
    }
  }

  /// 获取单个会诊详情
  static Future<HttpFinalResult<Consultation>> getDetail(int id) async {
    final response = await HttpService.get('/consultation_allinfo/$id', needAuth: true);
    if (response.error.isEmpty) {
      return HttpFinalResult(response.error, Consultation.fromJson(response.data));
    } else {
      return HttpFinalResult(response.error, Consultation());
    }
  }

  /// 获取会诊操作历史
  static Future<HttpFinalResult<List<OperateHistory>>> getOperateHistory(int id) async {
    final response = await HttpService.get('/consultation_action/$id', params: {'include': 'user'}, needAuth: true);
    if (response.error.isEmpty) {
      final List<dynamic> data = response.data['data'];
      List<OperateHistory> _list = [];
      if (data != null) {
        _list = data.map((i) => OperateHistory.fromJson(i)).toList();
      }
      return HttpFinalResult(response.error, _list);
    } else {
      return HttpFinalResult(response.error, []);
    }
  }

  /// 获取会诊记录
  static Future<HttpFinalResult<Consultation>> getConsultationRecords(int id) async {
    final response = await HttpService.get('/consultation_option/$id', params: {'include': 'case'}, needAuth: true);
    if (response.error.isEmpty) {
      return HttpFinalResult(response.error, Consultation.fromJson(response.data));
    } else {
      return HttpFinalResult(response.error, Consultation());
    }
  }

  /// 获取会诊报告
  static Future<HttpFinalResult<Consultation>> getConsultationReport(int id) async {
    final response = await HttpService.get('/consultation_report/$id', needAuth: true);
    if (response.error.isEmpty) {
      return HttpFinalResult(response.error, Consultation.fromJson(response.data));
    } else {
      return HttpFinalResult(response.error, Consultation());
    }
  }
}
