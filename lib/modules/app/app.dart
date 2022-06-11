import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ibtikartask/modules/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';
import '../../shared/resourses/routes_manager.dart';
import '../../shared/resourses/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType)=> MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: getApplicationTheme(),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashScreen,
        ),
      ),
    );
  }
}
