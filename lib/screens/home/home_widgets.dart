import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:hijri/hijri_calendar.dart';
import 'dart:ui' as ui;
import '../../bloc/app_cubit/app_cubit.dart';
import '../../models/hime_page_model.dart';
import '../../shard/theme/app_colors.dart';
import '../../shard/theme/app_text_styles.dart';
import '../common/commen.dart';


Widget homeWidget(HomeModel home, context) {
  //AppCubit cubit = AppCubit.get(context);
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => home.widget!));
    },
    child: LayoutBuilder(builder: (context, constraints) {
      double widgetH = constraints.maxHeight;
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            SizedBox(
              height: widgetH * 0.4,
              width: widgetH * 0.4,
              child: Image(
                image: home.image,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: widgetH * 0.2,
              child: FittedBox(
                child: Text(home.name,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleAppTexeStyle.title),
              ),
            ),
            SizedBox(
              height: widgetH * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text("اذهب الي", style: GoogleAppTexeStyle.subbody),
                  ),
                  const FittedBox(
                      child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ))
                ],
              ),
            )
          ],
        ),
      );
    }),
  );
}

Widget homeWidget2(HomeModel home, context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => home.widget!));
    },
    child: LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Image(
                image: home.image,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              child: FittedBox(
                child: Text(home.name,
                    overflow: TextOverflow.ellipsis,
                    style:
                        GoogleAppTexeStyle.body.copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      );
    }),
  );
}

Widget headerRow(context) {
  var today = HijriCalendar.now();
  return FittedBox(
    child: Text(
      daysNames[today.weekDay() - 1] +
          " " +
          today.hDay.toString() +
          " " +
          monthNames[today.hMonth - 1] +
          " " +
          today.hYear.toString() +
          " هجري"
          +"\n"+ DateTime.now().day.toString() +
          " " +
          monthName[monthName.keys.toList()[DateTime.now().month - 1]] +
          " " +
          DateTime.now().year.toString() +
          " ميلادي"
      ,style: GoogleAppTexeStyle.body.copyWith(color: AppColors.amber),
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      maxLines: 2,
    ),
  );
}

Widget prayCountDown(AppCubit cubit) {
  return cubit.nextPrayer == null
        ?  Container(
          alignment: AlignmentDirectional.center,
            child:const LinearProgressIndicator(),
          )
        : cubit.nextPrayer!.id == -1
            ? 
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      cubit.nextPrayer!.title,
                      style: GoogleAppTexeStyle.subtitle
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints:const BoxConstraints(),
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.amber,
                    ),
                    //iconSize: 20,
                    onPressed: () async {
                      await cubit.getAzanTimes();
                    },
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cubit.nextPrayer!.title + " بعد",
                    style:
                        GoogleAppTexeStyle.title.copyWith(color: Colors.white),
                  ),
                  countdownWidget(cubit),
                ],
              );
  
}

Directionality countdownWidget(AppCubit cubit) {
  return Directionality(
    textDirection: ui.TextDirection.ltr,
    child: CountdownTimer(
      endTime: (cubit.nextPrayer!.date.isBefore(DateTime.now()))
          ? cubit.nextPrayer!.date
              .add(const Duration(days: 1))
              .millisecondsSinceEpoch
          : cubit.nextPrayer!.date.millisecondsSinceEpoch,
      endWidget: Expanded(
        child: Text(
          "حان الان موعد صلاه" " " + cubit.nextPrayer!.title,
          style: GoogleAppTexeStyle.title.copyWith(color: Colors.white),
        ),
      ),
      textStyle: GoogleAppTexeStyle.title.copyWith(color: Colors.white),

      onEnd: () {
        Future.delayed(const Duration(seconds: 5)).then((value) async {
          await cubit.getAzanTimes();
        });
      },
    ),
  );
}
