// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran_app/shard/theme/app_colors.dart';


import '../../shard/theme/app_text_styles.dart';

class QuranIndex extends StatefulWidget {
  const QuranIndex({ Key? key }) : super(key: key);

  @override
  State<QuranIndex> createState() => _QuranIndexState();
}

class _QuranIndexState extends State<QuranIndex> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: ListView.separated(
          physics:const BouncingScrollPhysics(),
          itemBuilder:(context,i)=> indexItem(i+1),
          separatorBuilder:(context,i)=>const SizedBox(height: 5,),
          itemCount: quran.totalSurahCount,
        ) ,
      ),
    );
  }

  Widget indexItem(int surahNumber) {
    Surah surah=Surah(surahNumber: surahNumber);
    String path=surah.surahPlace=="Makkah"?
    "assets/images/icons/kaaba.png"
    :"assets/images/icons/Medina.png";
    return  Material(
      elevation: 1,
      child: ListTile(
          onTap: () {
            Navigator.pop(context,surah.surahPage);
          },
          trailing: Image(image: AssetImage(path),height: 30,width: 30,),
          leading: Stack(
            alignment:Alignment.center,
            children: [
              SizedBox(
                height: 40,width: 40,
                child: FittedBox(child: Image.asset("assets/images/icons/Subtraction7.png",color: AppColors.amber))),
              Text(surahNumber.toString()
              ,style: const TextStyle(fontSize: 13),
              )
            ],
            ),
          title: Text(
            surah.surahName,
            style: GoogleAppTexeStyle.title,
          ),
          subtitle:  Text(
            " اياتها " +surah.surahNumberofverses.toString()
            +" - "+" صفحه "+surah.surahPage.toString(),
            style: GoogleAppTexeStyle.subtitle.copyWith(color: AppColors.cyan),
          ),
        ),
    );
    
  }
}

class Surah {
  late int surahNumber;
  late int surahPage;
  late String surahName;
  late String surahPlace;
  late int surahNumberofverses;

  Surah({
    required this.surahNumber,
  }){
    surahPage=quran.getSurahPages(surahNumber)[0];
    surahName=quran.getSurahNameArabic(surahNumber);
    surahNumberofverses=quran.getVerseCount(surahNumber);
    surahPlace=quran.getPlaceOfRevelation(surahNumber);
  }

}
