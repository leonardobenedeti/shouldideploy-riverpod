import 'package:flutter/material.dart';

class ShouldDidDeployLoadingPage extends StatelessWidget {
  const ShouldDidDeployLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your network connection is slow.\n Maybe it\'s a sign. 🫠\n'
                ' Wait for the result to make your decision!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              SizedBox(height: 24),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
