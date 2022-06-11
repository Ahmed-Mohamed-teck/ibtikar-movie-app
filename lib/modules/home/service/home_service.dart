import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../data/api_routes.dart';
import '../../../helper/dio_helper.dart';
import '../../../model/known_for.dart';
import '../../../model/person_model.dart';
import '../../../shared/widgets/person_card.dart';

class HomeService{



  Future<List<PersonCard>> getPersonCards({required int pageNumber}) async {

    List<PersonCard> temp =[];
    var data = await DioHelper.getData(
        url:
        'person/popular?api_key=a89849feb4e9307f018bcdf8c716bec0&page=$pageNumber&query=%27%27');

    var res =jsonDecode(data.data);
    for (var item in res["results"]) {
      List<KnownFor> knownForList =[];
      for(var k in item['known_for']){
        knownForList.add(KnownFor.fromJson(k));
      }
      temp.add(
        PersonCard(
          personModel: PersonModel(
            id: item['id'],
            adult: item['adult'],
            gender: item['gender'],
            knownFor: knownForList,
            knownForDepartment:item['known_for_department'],
            name: item['name'],
            popularity: double.parse(item['popularity'].toString()),
            profilePath: (item["profile_path"]!=null)?"$kThemoviedbImageURL${item["profile_path"]}":"https://i.redd.it/mn9c32es4zi21.png",
          ),
          themeColor: Colors.red,
        ),
      );
    }
    return Future.value(temp);
  }

}