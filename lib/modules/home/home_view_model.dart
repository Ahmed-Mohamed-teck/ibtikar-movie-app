
import 'package:flutter/material.dart';
import 'package:ibtikartask/helper/base_notifier.dart';
import 'package:ibtikartask/modules/home/service/home_service.dart';
import 'package:ibtikartask/shared/widgets/person_card.dart';




class HomeViewModel extends BaseNotifier {

  final HomeService _service = HomeService();

  int pageNumber =1;

  List<PersonCard> personCards =[];

  var scrollController = ScrollController();

  bool loadingMoreCards =false;





  Future<void> loadMorePersonCard() async {
    if ((scrollController.position.pixels ==
        scrollController.position.maxScrollExtent)) {
      loadingMoreCards = true;
      setState();
      pageNumber += 1;
      await getPersonCards().then((value) {
        loadingMoreCards = false;
      });
    }
    setState();
  }



  Future<List<PersonCard>> getPersonCards() async {
   personCards += await _service.getPersonCards(pageNumber: pageNumber);
    setState();
    return personCards;
  }




}
