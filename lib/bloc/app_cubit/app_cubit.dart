// ignore_for_file: avoid_print

import 'package:dartarabic/dartarabic.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import 'package:quran_app/models/times.dart';
import 'package:quran_app/screens/home/home.dart';

import '../../models/azkar_model.dart';

import '../../models/quran_model.dart';
import '../../screens/azkar/azkar_screan.dart';
import '../../screens/azkar/hadithe.dart';
import '../../screens/hijri_calendar/prays_time.dart';
import '../../screens/quran/quran.dart';
import '../../shard/data/azkar_data.dart';
import '../../shard/data/quran_data.dart';
import '../../shard/database/database.dart';
import '../../shard/network/dio_helper.dart';
import '../../shard/services/azan_times.dart';
import '../../shard/services/my_positon.dart';

import '../../shard/services/shared_preferences.dart';
import 'app_states.dart';
import 'package:just_audio/just_audio.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitLogin());
  static AppCubit get(context) => BlocProvider.of(context);
  DataBase db = DataBase();
  List<Widget> screens = [
    const Home(),
    const QuranScreen(
      title: "القران",
    ),
    const AzkarScreen(),
    const HadithScrean(
      title: "الاربعين النووية",
    ),
    const PraysTime(title: "مواقيت الصلاه"),
  ];

  int indix = 0;
  Future<void> changBottomBarIndix(value, context) async {
    indix = value;
    print("indix is $indix");
    if (indix == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const QuranScreen(
            title: "القران",
          ),
        ),
      ).then((value) {
        return changBottomBarIndix(0, context);
      });
    }
    emit(ChangBottomBarIndix());
  }

  AudioPlayer player = AudioPlayer();
  void playSound({bool noSound = false}) async {
    await player.setAsset("assets/sound/click/click2.wav");
    if (noSound) {
      player.setVolume(0);
    } else {
      player.setVolume(1);
    }
    await player.play();
    //final AssetSource assetSource=AssetSource('sound/click/click2.wav');
    //await player.play(assetSource);
    emit(PlaySound());
  }

  int quranPageMarkedNumber = CachHelper.getData(key: "mark") ?? 0;
  Future<void> changeMarkNumber(int number) async {
    quranPageMarkedNumber = number;
    await CachHelper.setData(key: "mark", value: number);
    emit(ChangeMarkNumber());
  }
  
  int quranLastPage = CachHelper.getData(key: "lastpage") ?? 0;
  Future<void> changequranLastPage(int number) async {
    quranLastPage = number;
    await CachHelper.setData(key: "lastpage", value: quranLastPage);
    emit(ChangeMarkNumber());
  }

  QuranModel? quranModel;
  getQuranData() {
    try {
      quranModel = QuranModel.fromJson(quran);
      print(quranModel!.surahs![1].verses![1].text);
      emit(CreateQuranData());
    } catch (e) {
      print("erorr  from ErrorQuranData is " + e.toString());
      emit(ErrorQuranData());
    }
  }

  List<Verses>? foundAyat;
  void searchAyat(String value) {
    emit(LoadingSearchAyat());
    foundAyat = [];
    for (var s in quranModel!.surahs!) {
      foundAyat!.addAll(s.verses!.where((element) {
        String text=DartArabic.stripTashkeel(element.text!);
        if (text.contains(value)) {
          return true;
        }
        return false;
      }).toList());
    }
    print("foundAyat l is "+foundAyat!.length.toString());
    for (var element in foundAyat!) {
      print(element.text);
      
    }
    emit(SCSearchAyat());
  }

  void endSearchAyat() {
    foundAyat = null;
    emit(EndSearchAyat());
  }

  List<Azkar> azkar = [];
  Azkar? praise;
  createAzkarData() async {
    try {
      azkar = [];
      myAzkarData.forEach((key, value) {
        Azkar az = Azkar.fromJason(value, key);
        azkar.add(az);
        if (key == "تسابيح") {
          praise = Azkar.fromJason(value, key);
        }
      });
      for (var e in praise!.azkar) {
        e.count = 0;
      }
      getFavAZekr();
      print("azkar loaded");
      emit(CreateAzkarData());
    } catch (e) {
      print("erorr  from ErrorAzkarData is " + e.toString());
      emit(ErrorAzkarData());
    }
  }

  List favoriteAzkar = [];
  void getFavAZekr() async {
    emit(LoadingGetFavZekr());
    favoriteAzkar = [];
    try {
      List fav = await db.getFavZekr();
      for (var item in fav) {
        Azkar z =
            azkar.firstWhere((element) => element.name == item["category"]);
        Zekr i = z.azkar.firstWhere((element) => element.id == item["id"]);
        i.isFavorite = true;
        favoriteAzkar.add(i);
      }
      emit(ScGetFavZekr());
    } catch (e) {
      print("error getFavZekr: $e");
      emit(ErrorGetFavZekr());
    }
  }

  Future<void> changeFavorite(Zekr zkar) async {
    if (zkar.isFavorite) {
      await zkar.deletfromFav();
      favoriteAzkar.remove(zkar);
    } else {
      await zkar.addToFav();
      favoriteAzkar.add(zkar);
    }
    emit(ChangeFavorite());
  }

  List? foundAzar;
  void searchAzkar(String value) {
    emit(LoadingSearchAzkar());
    foundAzar = [];
    for (var item in azkar) {
      foundAzar!.addAll(item.azkar.where((element) {
        if (DartArabic.stripTashkeel(element.zekr).contains(value) ||
            DartArabic.stripTashkeel(element.category).contains(value)) {
          return true;
        }
        return false;
      }).toList());
    }
    emit(SCSearchAzkar());
  }

  void endSearchAzkar() {
    foundAzar = null;
    emit(EndSearchAzkar());
  }

  CurantPosition curantPosition = CurantPosition();
  PraysTimeModel? praysTimeModel;
  Future<void> getPrayersTime({int? month, int? year}) async {
    changenoInterNet(false);
    emit(LoadingGetPrayersTime());
    await curantPosition.getMyPosition();
    try {
      var value = await DioHelper.getData(querys: {
        "latitude": curantPosition.position!.latitude,
        "longitude": curantPosition.position!.longitude,
        "method": 5,
        "month": month ?? DateTime.now().month,
        "year": year ?? DateTime.now().year,
        "adjustment":1,
      });
      praysTimeModel = PraysTimeModel.fromJson(value.data);
      emit(ScGetPrayersTime());
    } catch (e) {
      changenoInterNet(true);
      print(noInterNet);
      print("erorr from getPrayersTime is " + e.toString());
      emit(ErrorGetPrayersTime());
    }
  }

  MainData? getToday() {
    try {
      List days = praysTimeModel!.data!.where((element) {
        return (DateTime.now().year ==
                int.parse(element.date!.gregorian!.year!) &&
            DateTime.now().month == element.date!.gregorian!.month!.number! &&
            DateTime.now().day == int.parse(element.date!.gregorian!.day!));
      }).toList();
      return days.isEmpty ? null : days[0];
    } catch (e) {
      print("erorr from getToday is " + e.toString());
      changenoInterNet(false);
      return null;
    }
  }

  String prayTime12hFormat(String time) {
    final dateTime = DateFormat('h:mm').parse(time);
    return DateFormat.jm().format(dateTime).toString();
  }

  String whichPray(int dayIndex, int prayNumber) {
    return prayNumber == 0
        ? prayTime12hFormat(
            praysTimeModel!.data![dayIndex].timings!.fajr!.substring(0, 5))
        : prayNumber == 1
            ? prayTime12hFormat(
                praysTimeModel!.data![dayIndex].timings!.dhuhr!.substring(0, 5))
            : prayNumber == 2
                ? prayTime12hFormat(praysTimeModel!
                    .data![dayIndex].timings!.asr!
                    .substring(0, 5))
                : prayNumber == 3
                    ? prayTime12hFormat(praysTimeModel!
                        .data![dayIndex].timings!.maghrib!
                        .substring(0, 5))
                    : prayTime12hFormat(praysTimeModel!
                        .data![dayIndex].timings!.isha!
                        .substring(0, 5));
  }

  bool isToday(int dayIndex) {
    return (DateTime.now().year ==
            int.parse(praysTimeModel!.data![dayIndex].date!.gregorian!.year!) &&
        DateTime.now().month ==
            praysTimeModel!.data![dayIndex].date!.gregorian!.month!.number! &&
        DateTime.now().day ==
            int.parse(praysTimeModel!.data![dayIndex].date!.gregorian!.day!));
  }

  bool noInterNet = false;
  void changenoInterNet(bool value) {
    noInterNet = value;
    emit(ChangenoInterNet());
  }

  AzanTime azan = AzanTime();
  AzanModel? nextPrayer;
  List<AzanModel>? prayers;
  Future<void> getAzanTimes() async {
    nextPrayer = null;
    emit(LoadingAzanTimes());
    print('My Prayer Times');
    try {
      prayers = await azan.getAzanTimes();
      nextPrayer = azan.getNextPray();
      emit(ScAzanTimes());
    } catch (e) {
      prayers = [];
      emit(ErrorAzanTimes());
      print("erorr from getAzanTimes is " + e.toString());
    }
  }

  bool prayNow = false;
  void changeprayNow(bool value) {
    prayNow = value;
    emit(ChangeprayNow());
  }
}
