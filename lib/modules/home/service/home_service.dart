import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../data/api_routes.dart';
import '../../../helper/dio_helper.dart';
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
            profilePath: (item["profile_path"]!=null)?"$kThemoviedbImageURL${item["profile_path"]}":"https://i0.wp.com/smawatan.com/wp-content/uploads/2022/06/%D9%85%D9%86-%D9%87%D9%8A-%D8%A7%D9%84%D8%AF%D9%83%D8%AA%D9%88%D8%B1%D8%A9-%D8%B3%D9%86%D9%8A%D8%A9-%D8%AD%D8%A8%D9%91%D9%88%D8%A8.jpg?resize=780%2C470&ssl=1",
          ),
          themeColor: Colors.red,
        ),
      );
    }
    return Future.value(temp);
  }

}