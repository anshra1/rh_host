import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rh_host/src/features/import.dart';

class PasscodePage extends StatelessWidget {
  const PasscodePage({super.key});

  static const String routeName = '/passcode-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passcode Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go(HomePage.routeName);
          },
          child: const Text('Go To Shell Page'),
        ),
      ),
    );
  }
}
