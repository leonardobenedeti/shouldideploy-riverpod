import 'package:http/http.dart' as http;

class ShouldDidDeployRepository {
  http.Client? httpClient;

  ShouldDidDeployRepository({
    http.Client? client,
  }) : httpClient = client ?? http.Client();

  Future<String> shouldDidDeployToday() async {
    // return mockedError;
    // return mockedSuccess;

    final response = await httpClient!.get(
      Uri.https('shouldideploy.today', '/api', {'tz': 'America/Sao_Paulo'}),
    );

    return response.body;
  }
}

const mockedSuccess = '''
{
"timezone": "America/Sao_Paulo",
"date": "2024-02-02T16:51:07.000Z",
"shouldideploy": true,
"message": "Go Go Go!!"
}
''';

const mockedError = '''
{
"timezone": "America/Sao_Paulo",
"date": "2024-02-02T16:51:07.000Z",
"shouldideploy": false,
"message": "No no no no no no no no"
}
''';
