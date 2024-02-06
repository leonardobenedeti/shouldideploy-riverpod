import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktailx/mocktailx.dart';
import 'package:shouldideploy/should_did_deploy/data/repository/shouldideploy_repository.dart';

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client _http;
  late ShouldDidDeployRepository _repository;

  setUpAll(() {
    _http = MockClient();
    registerFallbackValue(FakeUri());
    _repository = ShouldDidDeployRepository(client: _http);
  });

  group('Quando o método shouldDidDeployToday for chamado deve retornar: ', () {
    test('Que é recomendado fazer o deploy com uma mensagem positiva.',
        () async {
      when(
        () => _http.get(any()),
      ).thenAnswer((_) async => http.Response(mockedSuccess, 200));

      final response = await _repository.shouldDidDeployToday();
      final parsedResponse = jsonDecode(response) as Map<String, dynamic>;
      final shouldideploy = parsedResponse['shouldideploy'];
      expect(shouldideploy, isTrue);
    });

    test('Que NÃO é recomendado fazer o deploy com uma mensagem negativa.',
        () async {
      when(
        () => _http.get(any()),
      ).thenAnswer((_) async => http.Response(mockedError, 200));

      final response = await _repository.shouldDidDeployToday();
      final parsedResponse = jsonDecode(response) as Map<String, dynamic>;
      final shouldideploy = parsedResponse['shouldideploy'];
      expect(shouldideploy, isFalse);
    });
  });
}
