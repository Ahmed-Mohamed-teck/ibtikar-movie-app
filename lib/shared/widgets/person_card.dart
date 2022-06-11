import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ibtikartask/model/person_model.dart';
import 'package:sizer/sizer.dart';
import '../resourses/routes_manager.dart';
import 'custom_laoding_spinkit.dart';


class PersonCard extends StatelessWidget {
  final PersonModel personModel;
  final Color themeColor;
  final int? contentLoadedFromPage;

  const PersonCard({
    required this.personModel,
    required this.themeColor,
    this.contentLoadedFromPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.pushNamed(context, Routes.personDetailsScreen,arguments: personModel);
      },
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child:  Container(
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.2.w),
              child: CachedNetworkImage(
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Column(

                    children: [
                      SizedBox(
                        height: 20.h,
                        child: CustomLoadingSpinKitRing(
                            loadingColor: themeColor),
                      )
                    ],
                  ),
                  imageUrl: personModel.profilePath!,
                  errorWidget: (context, url, error) => Column(
                    children: [
                      SizedBox(
                          height: 20.h,
                          child: const CircularProgressIndicator()
                      )
                    ],
                  )),
            ),
          ),
          height: 30.h,
          width: 40.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.w),
            color: Colors.black,
          ),
        ),
        ),
      );
  }
}
