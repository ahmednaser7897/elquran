// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/screens/quran/quran_widgets.dart';


import 'package:quran_app/shard/services/size_config.dart';
import 'package:quran_app/screens/common/commen.dart';
import 'package:quran_app/shard/theme/app_colors.dart';
import '../../bloc/app_cubit/app_cubit.dart';
import '../../bloc/app_cubit/app_states.dart';

import 'package:quran/quran.dart' as quran;


class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  bool visible = false;
  late PageController pageController;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SizeConfig().init(context);
        AppCubit cubit=AppCubit.get(context);
        pageController = PageController(keepPage: true, initialPage:cubit.quranLastPage );
        print("lastPage ="+cubit.quranLastPage .toString());
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.quranBackGround,
              body: PageView.builder(
                physics: const PageScrollPhysics(),
                itemBuilder: (context, indx) =>
                    quranPageWidget(context, indx + 1),
                controller: pageController,
                itemCount: 604,
                onPageChanged: (page) {
                  cubit.changequranLastPage(page);
                  if (page + 1 == 602 || page + 1 == 2) {
                    return;
                  }
                  double p = ((page - 2 + 1) / 20);
                  print(p == p.roundToDouble());
                  if (p == p.roundToDouble()) {
                    buildToast(context, "الجزء : ${(p + 1).toInt()}",
                        center: true);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void saveVisible(bool v) {
    setState(() {
      visible = v;
      print("visible" + visible.toString());
    });
  }

  Widget quranPageWidget(context, int indx) {
    AppCubit cubit = AppCubit.get(context);
    var pageData = quran.getPageData(
      indx,
    );
    String surahName = quran.getSurahNameArabic(pageData[0]["surah"]);
    int juzeNumber =
        quran.getJuzNumber(pageData[0]["surah"], pageData[0]["start"]);
    return GestureDetector(
      onTap: () {
        saveVisible(!visible);
      },
      child: Stack(
        children: [
          Image.asset(
            "assets/images/quran-images/$indx.png",
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          //bookmark
          Visibility(
            visible: cubit.quranPageMarkedNumber == indx,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Opacity(
                  opacity: 0.4,
                  child: Image.asset(
                    "assets/images/icons/bookmark.png",
                    height: SizeConfig.screenHeight*0.13,
                    width: SizeConfig.screenWidth*0.08,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
          //page data
          Visibility(
            visible: visible,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 50,
                color: AppColors.blackwithOpacity,
                padding: const EdgeInsets.all(5),
                child: pageDataRow(juzeNumber, indx, surahName),
              ),
            ),
          ),
          
          Visibility(
            visible: visible,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: AppColors.blackwithOpacity,
                padding: const EdgeInsets.all(5),
                child: changeBookMarkRow(pageController,cubit, indx, context),
              ),
            ),
          )
        ],
      ),
    );
  }

 
 }
