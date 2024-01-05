import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int counter = ref.watch(counterProvider);
    final AsyncValue<ShouldDidDeployToday> response =
        ref.watch(shouldDidDeployTodayProvider);

    final textStyle = Theme.of(context)
        .textTheme
        .headlineMedium
        ?.copyWith(color: Colors.white);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Column(
                children: [
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () =>
                            ref.read(counterProvider.notifier).decrement(),
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        '$counter',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      IconButton(
                        onPressed: () =>
                            ref.read(counterProvider.notifier).increment(),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => ref.read(counterProvider.notifier).build(),
                    child: const Text('Reiniciar contagem'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Center(
                child: switch (response) {
                  AsyncData(:final value) => Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            value.shouldideploy ? Colors.grey : Colors.red[300],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Should did deploy today?',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                          Text(
                            value.message,
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                          TextButton(
                            onPressed: () => ref
                                .refresh(shouldDidDeployTodayProvider.future),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    ),
                  AsyncLoading() =>
                    const Center(child: CircularProgressIndicator()),
                  AsyncError() => Text(
                      'Oops, something unexpected happened',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  _ => const CircularProgressIndicator(),
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

@riverpod
class Counter extends _$Counter {
  @override
  int build() => state = 0;

  void increment() => state++;

  void decrement() => state--;
}

@riverpod
Future<ShouldDidDeployToday> shouldDidDeployToday(
    ShouldDidDeployTodayRef ref) async {
  final response = await http.get(
      Uri.https('shouldideploy.today', '/api', {'tz': 'America/Sao_Paulo'}));
  log(response.body);
  return ShouldDidDeployToday.fromJson(response.body);
}

class ShouldDidDeployToday {
  String timezone;
  DateTime date;
  bool shouldideploy;
  String message;

  ShouldDidDeployToday({
    required this.timezone,
    required this.date,
    required this.shouldideploy,
    required this.message,
  });

  factory ShouldDidDeployToday.fromMap(Map<String, dynamic> map) {
    return ShouldDidDeployToday(
      timezone: map['timezone'] as String,
      date: DateTime.parse(map['date']),
      shouldideploy: map['shouldideploy'] as bool,
      message: map['message'] as String,
    );
  }

  factory ShouldDidDeployToday.fromJson(String source) =>
      ShouldDidDeployToday.fromMap(json.decode(source) as Map<String, dynamic>);
}
