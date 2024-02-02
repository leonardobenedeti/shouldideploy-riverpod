import 'package:flutter/material.dart';

class ShouldDidDeployErrorPage extends StatelessWidget {
  final VoidCallback? onTryAgain;

  const ShouldDidDeployErrorPage({
    required this.onTryAgain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oops, something unexpected happened',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: onTryAgain,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
