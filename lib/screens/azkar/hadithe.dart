import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/models/hadithe.dart';

import '../../bloc/app_cubit/app_cubit.dart';
import '../../bloc/app_cubit/app_states.dart';
import '../../shard/data/hadithedata.dart';
import '../../shard/theme/app_text_styles.dart';


import 'hadith_data_screen.dart';

class HadithScrean extends StatelessWidget {
  const HadithScrean({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
        
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(title: Text(title,),centerTitle:true ),
            body: ListView.separated(
              physics:const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  hadithWidget(HadithData.listhadiths[index], index,context),
              separatorBuilder: (context, indx) => const SizedBox(height: 0),
              itemCount: HadithData.listhadiths.length,
            ),
          ),
        );
      },
    );
  }

  Widget hadithWidget(Hadith hadith, int i,context) {
    return Card(
       elevation: 1,
      child: ListTile(
        onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) =>HadithDataScreen(hadith: hadith) ));
        },
        trailing:const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
        title: Text(
          (i + 1).toString() + " - " + hadith.nameHadith,
          style:  GoogleAppTexeStyle.subtitle.copyWith(color: Colors.black),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    );
  }
}
