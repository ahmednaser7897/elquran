// ignore_for_file: public_member_api_docs, sort_constructors_first

// ignore_for_file: avoid_print

import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';

import 'package:quran_app/shard/services/my_positon.dart';



class AzanTime{

  late PrayerTimes prayerTimes;
  Future<List<AzanModel>> getAzanTimes() async {
    print('My Prayer Times');
    List<AzanModel> prayers=[];
    try {
      CurantPosition curantPosition=CurantPosition();
      await curantPosition.getMyPosition();
      final myCoordinates = Coordinates(
         curantPosition.position!.latitude, 
         curantPosition.position!.longitude,
         validate: true
      );
      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;
      prayerTimes = PrayerTimes.today(myCoordinates, params);
      print(
          "---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");
      prayers.add(AzanModel(id:0 ,date:prayerTimes.fajr ));
      prayers.add(AzanModel(id:1 ,date:prayerTimes.sunrise ));
      prayers.add(AzanModel(id:2 ,date:prayerTimes.dhuhr ));
      prayers.add(AzanModel(id:3 ,date:prayerTimes.asr ));
      prayers.add(AzanModel(id:4 ,date:prayerTimes.maghrib ));
      prayers.add(AzanModel(id:5 ,date:prayerTimes.isha ));
      print('-------------------');
      return prayers;
    } catch (e) {
      print("erorr from getAzanTimes is " + e.toString());
      return [];
    }
  }
  
  AzanModel getNextPray(){
    late DateTime date=DateTime.now().add(const Duration(seconds: 30));
    int i=-1;
    try{
    Prayer nextPray=prayerTimes.nextPrayer();
    //print("nextPray i is "+nextPray.index.toString());
    //print("nextPray.name " +nextPray.name);
    if(nextPray.name=="fajr"){
      date=prayerTimes.fajr;
      i=0;
    }else if(nextPray.name=="sunrise"){
      date=prayerTimes.sunrise;
      i=1;
    }else if(nextPray.name=="dhuhr"){
      date=prayerTimes.dhuhr;
      i=2;
    }else if(nextPray.name=="asr"){
      date=prayerTimes.asr;
      i=3;
    }else if(nextPray.name=="maghrib"){
      date=prayerTimes.maghrib;
      i=4;
    }else if(nextPray.name=="isha"){
      date=prayerTimes.isha;
      i=5;
    }else{
      date=prayerTimes.fajr;
      i=0;
    }
    return AzanModel(date: date,id: i );

    }catch (e) {
      print("erorr from getNextPray is " + e.toString());
      return  AzanModel(date: date,id: -1);
    }
    
  } 
}

class AzanModel {
  int id;
  late String title;
  late String image;
  late String icon;
  DateTime date;
  AzanModel({
    required this.date,
    required this.id,
  }){
    print("id is "+id.toString());
    if (id == 0) {
      title= "الفجر";
      image="assets/images/svg/praying_time/fgr.png";
      icon="assets/images/times/fjr.png";
    } else if (id == 1) {
      title= "الشروق";
      image="assets/images/svg/praying_time/fgr.png";
      icon="assets/images/times/fjr.png";
    } else if (id == 2) {
      title=DateTime.now().day!=5? "الظهر":"الجمعه";
       image="assets/images/svg/praying_time/dhr.png";
       icon="assets/images/times/dhr.png";
    } else if (id == 3) {
      title= "العصر";
       image="assets/images/svg/praying_time/asr.png";
       icon="assets/images/times/asr.png";
    }else if (id == 4) {
      title= "المغرب";
       image="assets/images/svg/praying_time/maghrb.png";
       icon="assets/images/times/m.png";
    }else if (id == 5){
       title= "العشاء";
       image="assets/images/svg/praying_time/isha.png";
       icon="assets/images/times/isha.png";
    }else {
       title= "خطاء اعد التحميل";
       image="";
       icon="";
    }
     print(id.toString()+"-"+ title+" date is "+DateFormat.jm().format(date));
  }
}
