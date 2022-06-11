import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibtikartask/model/person_model.dart';
import 'package:ibtikartask/shared/resourses/color_manager.dart';
import 'package:ibtikartask/shared/resourses/styles_manager.dart';

import '../../data/api_routes.dart';
import '../../model/known_for.dart';
import '../../shared/widgets/image_gallary.dart';


class PersonDetailsScreen extends StatefulWidget {
  final PersonModel personModel;



  const PersonDetailsScreen({Key? key,required this.personModel}) : super(key: key);

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {

  final PageController _pageController = PageController();

  final _scrollController = ScrollController();

  int _currentPage = 0;

  int _lastInteraction = 0;

  List<String?> _images =[];





  @override
  Widget build(BuildContext context) {
    _images = widget.personModel.knownFor!.map((e) => e.posterPath).toList();

    return SafeArea(
      bottom: false,
      top: true,
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              backgroundColor: Colors.transparent,
              elevation: 1.0,
              expandedHeight:
              MediaQuery.of(context).size.height*.4,
              pinned: true,
              floating: false,
              leading: Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              flexibleSpace:  LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Positioned.fill(
                          child: Listener(
                            onPointerDown: (_) => _updateLastInteraction(),
                            onPointerMove: (_) => _updateLastInteraction(),
                            onPointerHover: (_) => _updateLastInteraction(),
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: widget.personModel.knownFor?.length??0,
                              onPageChanged: (index) {
                                _currentPage = index;
                                setState(() {});
                              },
                              itemBuilder: (BuildContext context, int index) {

                                return GestureDetector(
                                  onTap: () => _onShowGallery(context, index),
                                  child: Hero(
                                    tag: 'slider_hero_tag_${_images[index]}',
                                    child:Image.network(
                                        '$kThemoviedbImageURL${_images[index]}'
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        if (_currentPage != 0 && true)
                          Align(
                            alignment: const Alignment(-1, 0.92),
                            child: GestureDetector(
                              onTap: () {
                                _pageController.goTo(0);
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white30,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(23.0),
                                    bottomRight: Radius.circular(23.0),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: const Icon(
                                  CupertinoIcons.arrow_left,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        Align(
                          alignment: const Alignment(0.95, 0.92),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(23.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Text(
                              '${_currentPage + 1}/${_images.length}',
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                },
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.black26
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.personModel.name??'',style: getBoldStyle(color: ColorManager.kBlackColor),),
                          Text(widget.personModel.knownForDepartment??'',style: getBoldStyle(color: ColorManager.kBlackColor),),
                        ],
                      ),

                    ),
                  ),

                ],
              ),
            ),
            ...getInfo(context,list: widget.personModel.knownFor??[])

          ],
        ),
      ),
    );
    // );
  }

   getInfo(context,{required List<KnownFor> list}){
    List<Widget>  temp =[];
    for(var item in list){
      temp.add(SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 16),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.black26
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.title??'',style: getBoldStyle(color: ColorManager.kBlackColor),),
                      Text(item.mediaType??'',style: getBoldStyle(color: ColorManager.kBlackColor),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(item.overview??''),
            ],
          ),
        ),
      ),);
    }
    return temp;
  }

  Future<void> nextImage() async {
    if (!mounted || !_pageController.hasClients) {
      return;
    }

    /// Cancel if the page is scrolling.
    if (_pageController.page?.round() != _pageController.page) {
      return;
    }

    /// Cancel if user has touched the gallery within 3 seconds.
    if (DateTime.now().millisecondsSinceEpoch - 3000 <= _lastInteraction) {
      return;
    }


    /// Next page if not ends..
    if (_currentPage + 1 < _images.length) {
      return _pageController.goTo(_currentPage + 1);
    }

    /// Go to first page.
    return _pageController.goTo(0);
  }

  void _updateLastInteraction() {
    _lastInteraction = DateTime.now().millisecondsSinceEpoch;
  }

  void _onShowGallery(BuildContext context, [index = 0]) {
    Navigator.push(
      context,
      PageRouteBuilder(pageBuilder: (context, __, ___) {
        return ImageGalery(
          images: _images,
          index:  index,
          heroTagPrefix: 'slider_hero_tag_',
        );
      }),
    );
  }


}
extension on PageController {
  Future<void> goTo(int page) {
    return animateToPage(
      page,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

}
