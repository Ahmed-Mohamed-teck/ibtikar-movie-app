
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ibtikartask/modules/home/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../helper/dio_helper.dart';
import '../../shared/resourses/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    DioHelper.init();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 100), () async {
        await Provider.of<HomeViewModel>(context,listen: false).getPersonCards();
        Navigator.pushNamed(context, Routes.homeScreen);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   AppAssets.logo,
            //   width: MediaQuery.of(context).size.width * .6,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
