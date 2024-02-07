import 'package:http/http.dart' as http;

class ShouldDidDeployRepository {
  http.Client? httpClient;

  ShouldDidDeployRepository({
    http.Client? client,
  }) : httpClient = client ?? http.Client();

  Future<String> shouldDidDeployToday() async {
    final response = await httpClient!.get(
      Uri.https(
        'shouldideploy.today',
        '/api',
        {'tz': 'America/Sao_Paulo'},
      ),
    );

    return response.body;
  }
}
