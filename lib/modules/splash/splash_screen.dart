import 'package:flutter/material.dart';

import '../../generated/l10n.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Center(
        child:  Text(S.of(context).splashMSG),
      ),
    );
  }
}