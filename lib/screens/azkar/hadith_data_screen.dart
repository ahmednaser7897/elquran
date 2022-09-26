// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:flutter/material.dart';


import '../../models/hadithe.dart';
import '../../shard/theme/app_text_styles.dart';
import 'cards.dart';


class HadithDataScreen extends StatefulWidget {
  const HadithDataScreen({
    Key? key,
    required this.hadith,
  }) : super(key: key);
  final Hadith hadith;
  @override
  State<HadithDataScreen> createState() => _HadithDataScreenState();
}

class _HadithDataScreenState extends State<HadithDataScreen> {

  @override
  Widget build(BuildContext context) {
       return 
    Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            
            title: Text(widget.hadith.nameHadith),
            bottom:  TabBar(
              labelColor: Colors.amber,
              unselectedLabelColor: Colors.white ,
              indicatorColor: Colors.amber,
              labelStyle: GoogleAppTexeStyle.body.copyWith(color: Colors.white),
              tabs: const[
                     FittedBox(
                      child: Tab(
                        text: 'نص الحديث',

                      ),
                    ),
                    FittedBox(
                      child: Tab(
                        text: 'شرح الحديث',
                      ),
                    ),
                    FittedBox(
                      child: Tab(
                        text: 'ترجمة الراوي',
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(
              physics:const BouncingScrollPhysics(),
              children: [
              HadithCard(hadith: widget.hadith.textHadith,),
              HadithCard(hadith: widget.hadith.explanationHadith,),
              HadithCard(hadith: widget.hadith.translateNarrator,),
            ],),
        ),
      ),
    );
  
  }
}