import 'dart:developer';

import 'package:http/http.dart' as http;

class ShouldDidDeployRepository {
  Future<String> shouldDidDeployToday() async {
    final response = await http.get(
      Uri.https('shouldideploy.today', '/api', {'tz': 'America/Sao_Paulo'}),
    );
    log(response.body);

    return response.body;
  }
}
