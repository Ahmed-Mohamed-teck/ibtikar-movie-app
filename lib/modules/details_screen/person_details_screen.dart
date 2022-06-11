import 'package:flutter/material.dart';
import 'package:ibtikartask/model/person_model.dart';


class PersonDetailsScreen extends StatelessWidget {
  final PersonModel personModel;
  const PersonDetailsScreen({Key? key,required this.personModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("this is details screen"),),
    );
  }
}
