import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/screens/hijri_calendar/pray_time_widgets.dart';
import 'package:quran_app/shard/theme/app_colors.dart';




import '../../bloc/app_cubit/app_cubit.dart';
import '../../bloc/app_cubit/app_states.dart';
import 'dart:ui' as ui;

import '../../shard/theme/app_text_styles.dart';


class PraysTime extends StatefulWidget {
  const PraysTime({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<PraysTime> createState() => _PraysTimeState();
}

class _PraysTimeState extends State<PraysTime> {
  var date =  DateTime.now();
  @override
  Widget build(BuildContext context) {
    return 
       BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          if (state is ScGetPrayersTime){
            cubit.changenoInterNet(false);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(    
                centerTitle: true,
                title: Text(widget.title,),
                actions: [
                   IconButton(
                        onPressed: (){
                         setState(() {
                           date=DateTime.now();
                         });
                          cubit.getPrayersTime(month: date.month,year:date.year );
                        },
                         icon:  const Icon(Icons.refresh,size: 20,),
                         )
                ],
              ),
              body:!cubit.noInterNet&&( cubit.praysTimeModel==null || state is LoadingGetPrayersTime )
                  ? const Center(
                    child: CircularProgressIndicator(),
                  )
                  :cubit.noInterNet?
                  noInterNetWidget(cubit)
                  :
                   Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      child: Column(
                        children: [
                          headerRow(context),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(child: praysTimeWidget(context)),
                        ],
                      ),
                    ),
            ),
          );
        },
      );
  }

  Widget noInterNetWidget(AppCubit cubit) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.signal_wifi_connected_no_internet_4_outlined,size: 30,color: AppColors.red,),
          const SizedBox(height: 30,),
           Text("تاكد من الاتصال بالانترنت",style:
          GoogleAppTexeStyle.title.copyWith(fontSize: 22,color: AppColors.amber)
          ,
          textAlign:TextAlign.center ,),
          const SizedBox(height: 15,),
           IconButton(
            onPressed: (){
            setState(() {
             date=DateTime.now();
           });
            cubit.getPrayersTime(month: date.month,year:date.year );
            },
             icon:  const Icon(Icons.refresh,size: 30,color: AppColors.amber,),
             )
        ],
      ),
    );
  }

  Container headerRow(context) {
    AppCubit cubit = AppCubit.get(context);
    var today = cubit.getToday();
    return Container(
      color: AppColors.teal,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: (){
                var prevMonth =  DateTime(date.year, date.month - 1, date.day);
                //print("month1: ${prevMonth.month},year1: ${prevMonth.year}");
                cubit.getPrayersTime(month: prevMonth.month,year:prevMonth.year );
                setState(() {
                  date=prevMonth;
                });
                //print("month2: ${prevMonth.month},year2: ${prevMonth.year}");
              },
                icon:  const Icon(Icons.arrow_back_ios,size: 20,color: AppColors.amber,),
                ),
          Text(
            (today!=null)?
                  today.date!.hijri!.weekday!.ar! +
                    " " +
                    today.date!.hijri!.day! +
                    " " +
                    today.date!.hijri!.month!.ar! +
                    " " +
                    today.date!.hijri!.year! +
                    " هجري":
                    cubit.praysTimeModel!.data![15].date!.hijri!.month!.ar!
                    +" "
                    +cubit.praysTimeModel!.data![15].date!.hijri!.year!
                    +" هجري"
                    ,
            style:GoogleAppTexeStyle.body.copyWith(color: AppColors.amber),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          IconButton(
            onPressed: (){
              var nextMonth =  DateTime(date.year, date.month + 1, date.day);
              cubit.getPrayersTime(month: nextMonth.month,year:nextMonth.year );
              setState(() {
                  date=nextMonth;
                });
            },
              icon:  const Icon(Icons.arrow_forward_ios,size: 20,color: AppColors.amber,),
        )
        ],
      ),
    );
  }

}
