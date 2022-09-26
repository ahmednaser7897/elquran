import 'package:flutter/material.dart';

import '../../bloc/app_cubit/app_cubit.dart';
import '../../shard/theme/app_colors.dart';
import '../../shard/theme/app_text_styles.dart';
import '../common/commen.dart';

Widget prayName(String text) {
  return Container(
    height: 40,
    alignment: Alignment.center,
    child: Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.fade,
      style: GoogleAppTexeStyle.subbody.copyWith(color: AppColors.amber,
      height: 1.5,),
    ),
  );
}


Widget praysTimeWidget(context) {
  AppCubit cubit = AppCubit.get(context);
  return SingleChildScrollView(
    physics:const BouncingScrollPhysics(),
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Table(
          border: TableBorder.symmetric(
            outside: BorderSide.none,
            inside: const BorderSide(
                width: 1, color: AppColors.teal, style: BorderStyle.solid),
          ),
          children: [
            TableRow(
                decoration: const BoxDecoration(
                  color: AppColors.teal,
                ),
                children: [
                  prayName("اليوم"),
                  prayName("ميلادي"),
                  prayName("هجري"),
                  prayName("الفجر"),
                  prayName("الضهر"),
                  prayName("العصر"),
                  prayName("المغرب"),
                  prayName("العشاء"),
                ]),
            ...List.generate(cubit.praysTimeModel!.data!.length, (index1) {
              return TableRow(
                  decoration: BoxDecoration(
                      color: cubit.isToday(index1)
                          ? AppColors.teal
                          : index1.isEven
                              ? AppColors.white
                              : AppColors.gray400),
                  children: [
                    tableCell(
                        cubit.praysTimeModel!.data![index1].date!.hijri!
                            .weekday!.ar!
                            .toString(),
                        context,
                        index1,
                        tobay: cubit.isToday(index1)),
                    tableCell(
                        cubit.praysTimeModel!.data![index1].date!.hijri!
                            .weekday!.ar!
                            .toString(),
                        context,
                        index1,
                        date: true,
                        tobay: cubit.isToday(index1)),
                    tableCell(
                        cubit.praysTimeModel!.data![index1].date!.hijri!
                            .weekday!.ar!
                            .toString(),
                        context,
                        index1,
                        date: true,
                        hijri: true,
                        tobay: cubit.isToday(index1)),
                    ...List.generate(5, (index2) {
                      return tableCell("", context, index1,
                          prayInDay: index2, tobay: cubit.isToday(index1));
                    })
                  ]);
            }),
          ]),
    ),
  );
}

TableCell tableCell(String text, context, int dayInMonth,
    {int? prayInDay, bool? tobay, bool date = false, bool hijri = false}) {
  AppCubit cubit = AppCubit.get(context);
  return TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: prayInDay == null
        ? date
            ? tableCellText(
                text1: hijri
                    ? cubit.praysTimeModel!.data![dayInMonth].date!.hijri!.day!
                    : cubit.praysTimeModel!.data![dayInMonth].date!.gregorian!
                        .day!,
                text2: hijri
                    ? cubit.praysTimeModel!.data![dayInMonth].date!.hijri!
                        .month!.ar!
                    : monthName[cubit.praysTimeModel!.data![dayInMonth].date!
                        .gregorian!.month!.en!],
                tobay: tobay,
              )
            : FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FittedBox(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: GoogleAppTexeStyle.subheading.copyWith(
                          color: tobay! ? AppColors.amber : AppColors.teal),
                    ),
                  ),
                ),
              )
        : Padding(
            padding: const EdgeInsets.all(4.0),
            child: tableCellText(
              text1: cubit.whichPray(dayInMonth, prayInDay).split(" ")[0],
              text2:prayInDay==1? int.tryParse(
                cubit.whichPray(dayInMonth, prayInDay).split(" ")[0].split(":")[0]
              )!>11?"م":"ص":
               cubit.whichPray(dayInMonth, prayInDay).split(" ")[1].replaceFirst("AM", "ص").replaceFirst("PM", "م"),
              tobay: tobay,
            ),
          ),
  );
}

Widget tableCellText({required text1, required text2, required bool? tobay}) {
  return FittedBox(
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Text(
            text1,
            textAlign: TextAlign.center,
            style: GoogleAppTexeStyle.subbody
                .copyWith(color: tobay! ? AppColors.amber : AppColors.teal),
          ),
          Text(
            text2,
            textAlign: TextAlign.center,
            style: GoogleAppTexeStyle.subbody
                .copyWith(color: tobay ? AppColors.amber : AppColors.teal),
          ),
        ],
      ),
    ),
  );
}
