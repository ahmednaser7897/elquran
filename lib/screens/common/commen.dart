
import 'package:flutter/material.dart';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';


import '../../models/hime_page_model.dart';
import '../../shard/theme/app_text_styles.dart';

import '../hijri_calendar/prays_time.dart';
import '../azkar/azkar_screan.dart';
import '../azkar/hadithe.dart';
import '../other/allah_names.dart';
import '../other/praise.dart';
import '../quran/quran.dart';



void buildToast(BuildContext ctx, String text, {bool center = false}) {
  showToast(
    text,
    textStyle: GoogleAppTexeStyle.subtitle.copyWith(color: Colors.white),
    context: ctx,
    animation: StyledToastAnimation.scale,
    reverseAnimation: StyledToastAnimation.fade,
    position: center ? StyledToastPosition.center : StyledToastPosition.bottom,
    animDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
  );
}

Map monthName = const {
  "January": "يناير",
  "February": "فبراير",
  "March": "مارس",
  "April": "إبريل",
  "May": "مايو",
  "June": "يونيه",
  "July": "يوليه",
  "August": "أغسطس",
  "September": "سبتمبر",
  "October": "أكتوبر",
  "November": "نوفمبر",
  "December": "ديسمبر",
};
List<String> daysNames = [
  "الاثنين",
  "الثلاثاء",
  "الأربعاء",
  "الخميس",
  "الجمعة",
  "السبت",
  "الأحد",
];
List<String> monthNames = [
  "محرم",
  "صفر",
  "ربيع الأول",
  "ربيع الآخر",
  "جمادى الأولى",
  "جمادى الآخرة",
  "رجب",
  "شعبان",
  "رمضان",
  "شوال",
  "ذو القعدة",
  "ذو الحجة "
];
List<HomeModel> homePage = const [
  HomeModel(
      name: "القران",
      image: AssetImage(
        "assets/images/icons/quran3.png",
      ),
      widget: QuranScreen(
        title: "القران",
      )),
  HomeModel(
      name: "الاذكار",
      image: AssetImage(
        "assets/images/icons/islam.png",
      ),
      widget: AzkarScreen()),
  HomeModel(
      name: "الاربعين النووية",
      image: AssetImage(
        "assets/images/icons/i.jpg",
      ),
      widget: HadithScrean(
        title: "الاربعين النووية",
      )),
  HomeModel(
      name: "مواقيت الصلاه",
      image: AssetImage(
        "assets/images/icons/schedule.png",
      ),
      widget: PraysTime(title: "مواقيت الصلاه")),
  HomeModel(
    name: "سبحه",
    image: AssetImage(
      "assets/images/icons/rosary.png",
    ),
    widget: Praise(title: "سبحه"),
  ),
  HomeModel(
      name: "اسماء الله",
      image: AssetImage(
        "assets/images/icons/999.png",
      ),
      widget: AllahNamesScreen(
        title: "اسماء الله",
      )),
];
