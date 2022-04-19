import 'package:common/logic/auth_logic.dart';
import 'package:common/ui/theme/theme.dart';
import 'package:common/ui/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              'CV - Szunyogh Tamás',
              style: Theme.of(context).textTheme.headline1,
            ),
            const Spacer(),
            Card(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Bejelentkezés',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/google_logo.png',
                      width: 70,
                      height: 70,
                    ),
                    const SizedBox(height: 20),
                    CustomButton.primary(
                      child: const Text('Bejelentkezés'),
                      onTap: () {
                        ref.read(authenticationLogic.notifier).login();
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
