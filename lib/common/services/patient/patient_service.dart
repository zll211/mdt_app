import 'package:com.hzztai.mdt/common/services/http_service.dart';
import 'package:com.hzztai.mdt/common/services/patient/patient.dart';

class PatientService {
  static Future<HttpFinalResult<Patient>> getPatientInfo(String id) async {
    final response = await HttpService.get('/case/$id', params: {'include': 'case_hospital,ext'}, needAuth: true);
    if (response.error.isEmpty) {
      return HttpFinalResult(response.error, Patient.fromJson(response.data));
    } else {
      return HttpFinalResult(response.error, Patient());
    }
  }
}
