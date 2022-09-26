import 'package:flutter/material.dart';

import 'package:quran_app/screens/quran/quran_index.dart';

import '../../bloc/app_cubit/app_cubit.dart';
import '../../shard/theme/app_colors.dart';
import '../../shard/theme/app_text_styles.dart';
import '../common/commen.dart';

Row pageDataRow(int juzeNumber, int indx, String surahName) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("الجزء : $juzeNumber",
          style: GoogleAppTexeStyle.subtitle.copyWith(color: AppColors.white)),
      Text(
        (indx).toString(),
        style: GoogleAppTexeStyle.subtitle.copyWith(color: AppColors.white),
      ),
      Text(
        surahName,
        style: GoogleAppTexeStyle.subtitle.copyWith(color: AppColors.white),
      ),
    ],
  );
}

Widget changeBookMarkRow(PageController p, AppCubit cubit, int indx, context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextButton(
        child: Text("حفظ علامه",
            style:
                GoogleAppTexeStyle.subtitle.copyWith(color: AppColors.white)),
        onPressed: () {
          cubit.changeMarkNumber(indx);
        },
      ),
      TextButton(
        child: Text("انتقال الي علامه",
            style:
                GoogleAppTexeStyle.subtitle.copyWith(color: AppColors.white)),
        onPressed: () async {
          if (cubit.quranPageMarkedNumber == 0) {
            buildToast(context, "لا يوجد صفحه محفوظه");
          } else {
            p.jumpToPage(cubit.quranPageMarkedNumber - 1);
          }
        },
      ),
      TextButton(
        child: Text("الفهرس",
            style:
                GoogleAppTexeStyle.subtitle.copyWith(color: AppColors.white)),
        onPressed: () async {
          final r = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuranIndex(),
              ));
          if (r != null) {
            //print(r);
            p.jumpToPage(r - 1);
          }
        },
      ),
    ],
  );
}

