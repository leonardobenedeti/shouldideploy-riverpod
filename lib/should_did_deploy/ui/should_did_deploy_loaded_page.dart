import 'package:flutter/material.dart';
import 'package:shouldideploy/should_did_deploy/data/model/should_did_deploy_model.dart';

class ShouldDidDeploySuccessPage extends StatelessWidget {
  final ShouldDidDeployToday data;
  final VoidCallback? onTryAgain;

  const ShouldDidDeploySuccessPage({
    required this.data,
    required this.onTryAgain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          data.shouldideploy ? Colors.lightGreen[200] : Colors.red[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Should did deploy today?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: data.shouldideploy
                            ? Colors.blueGrey[900]
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      data.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        color: data.shouldideploy
                            ? Colors.blueGrey[900]
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: onTryAgain,
                style: ElevatedButton.styleFrom(
                  foregroundColor:
                      data.shouldideploy ? Colors.blueGrey[900] : Colors.white,
                  backgroundColor: data.shouldideploy
                      ? Colors.lightGreen[300]
                      : Colors.red[400],
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
