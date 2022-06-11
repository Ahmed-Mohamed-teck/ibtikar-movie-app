import 'package:flutter/material.dart';
import 'package:ibtikartask/modules/home/home_view_model.dart';
import 'package:ibtikartask/shared/widgets/base_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget<HomeViewModel>(
        model: HomeViewModel(),
        initState: (m) {
          m.getPersonCards();
          m.scrollController.addListener(m.loadMorePersonCard);
        },
        builder: (context, model, _) => Column(
          children: [
            Expanded(
              child : GridView.builder(
                shrinkWrap: true,
                controller: model.scrollController,
                itemCount: model.personCards.length,
                itemBuilder: (context, indx) => model.personCards[indx],
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:.75 ,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
              ),
            ),
            (model.loadingMoreCards)?const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(),),
            ):const SizedBox()
          ],
        ),
      ),
    );
  }
}
