import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_app/models/allah_names_model.dart';
import 'package:quran_app/shard/services/size_config.dart';
import 'package:quran_app/shard/theme/app_text_styles.dart';
import '../../shard/data/allah_names.dart';
import '../../shard/theme/app_colors.dart';


class AllahNamesScreen extends StatelessWidget {
  const AllahNamesScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            title, 
          ),
        ),
        body: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  "assets/images/svg/bismillah.svg",
                  fit: BoxFit.fitWidth,
                  height: 40,
                ),
              ),
              Text(
                  "\"وَلِلَّهِ الْأَسْمَاءُ الْحُسْنَى فَادْعُوهُ بِهَا وَذَرُوا الَّذِينَ يُلْحِدُونَ فِي أَسْمَائِهِ سَيُجْزَوْنَ مَا كَانُوا يَعْمَلُونَ\"",
                  textAlign: TextAlign.center,
                  style: GoogleAppTexeStyle.subtitle.copyWith(height: 1.5,color: Colors.black)),
              Text(
                "(سورة الأعراف، الآية 180)",
                textAlign: TextAlign.center,
                style: GoogleAppTexeStyle.body
                    .copyWith(color: AppColors.cyan, fontSize: 16),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) => allahNameWidget(
                      context, AllahNameData.allahNames[i], i),
                  separatorBuilder: (context, i) => const SizedBox(
                        height: 0,
                      ),
                  itemCount: AllahNameData.allahNames.length),
            ],
          ),
        ),
      ),
    );
  }

  Widget allahNameWidget(BuildContext context, AllahNameModel allahNam, int i) {
    return Card(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
             width: SizeConfig.screenWidth*0.25,
             padding: const EdgeInsets.only(bottom: 10,top: 10),
              decoration: const BoxDecoration(
              border:  Border(
            bottom: BorderSide(width: 2, color: Colors.amber),
            top: BorderSide(width: 2, color: Colors.amber),
            
          ),
            ),
              child: Text(allahNam.name,
              textAlign:TextAlign.center ,
                style: GoogleAppTexeStyle.heading.copyWith(fontSize:16)),
            ),
           
            const SizedBox(
          width: 10,
        ),
         Expanded(
           child: Container(
            padding: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
              border:  Border(
            right: BorderSide(width: 2, color: Colors.teal),
            
          ),
            ),
             child: Text(
              allahNam.text,
              textAlign: TextAlign.start,
              style: GoogleAppTexeStyle.body
                  .copyWith(color: AppColors.cyan, fontSize: 16),
                       ),
           ),
         ),
          
          ],
        ),
      ),
    );
  }
}
