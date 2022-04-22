import 'package:flutter/material.dart';
import 'package:common/ui/theme/theme.dart';
import 'package:mobile_cv/ui/page/root.dart';

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Szunyogh Tamas - CV',
      theme: customTheme,
      home: const Root(),
      navigatorKey: globalNavigatorKey,
    );
  }
}
