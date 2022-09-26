import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quran_app/bloc/app_cubit/app_cubit.dart';
import 'package:quran_app/bloc/app_cubit/app_states.dart';
import 'dart:ui' as ui;
import 'package:quran_app/shard/theme/app_colors.dart';

import '../../shard/services/size_config.dart';

import '../../shard/theme/app_text_styles.dart';

import '../common/commen.dart';
import 'home_widgets.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SizeConfig().init(context);
        AppCubit cubit = AppCubit.get(context);
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              body: Builder(builder: (context) {
                return Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      if (cubit.nextPrayer != null)
                      Container(
                            width: double.infinity,
                            height: SizeConfig.screenHeight * 0.45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: cubit.nextPrayer!.id == -1
                                  ? null
                                  : DecorationImage(
                                      image:
                                          AssetImage(cubit.nextPrayer!.image),
                                      fit: BoxFit.cover,
                                    ),
                            )),
                      Container(
                        width: double.infinity,
                        height: SizeConfig.screenHeight * 0.45,
                        color: cubit.nextPrayer != null
                            ? cubit.nextPrayer!.id != -1
                                ? Colors.black.withOpacity(0.6)
                                : Colors.teal
                            : Colors.teal,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.33,
                            child: Container(
                              child: firstPartBody(context, cubit),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                padding: const EdgeInsets.all(10),
                                child: praysTimesWidget(context, state)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  Widget firstPartBody(BuildContext context, AppCubit cubit) {
    return LayoutBuilder(builder: (context, size) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            height: size.maxHeight * 0.2,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Image(
                  height: 30,
                  width: 30,
                  image: AssetImage("assets/images/icons/istanbul.png"),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    "وَذَكِّرْ فَإِنَّ ٱلذِّكْرَىٰ تَنفَعُ ٱلْمُؤْمِنِينَ",
                    style: GoogleAppTexeStyle.body
                        .copyWith(color: AppColors.amber),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.maxHeight * 0.15, child: headerRow(context)),
          SizedBox(
            height: size.maxHeight * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                homeWidget2(homePage[4], context),
                homeWidget2(homePage[5], context),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.maxHeight * 0.03),
            child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                height: size.maxHeight * 0.15,
                child: prayCountDown(cubit)),
          )
        ],
      );
    });
  }

  Widget praysTimesWidget(ctx, state) {
    AppCubit cubit = AppCubit.get(ctx);
    return cubit.prayers == null || cubit.nextPrayer == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : cubit.prayers!.isEmpty
            ? (state is LoadingAzanTimes)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.amber,
                          ),
                          onPressed: () async {
                            await cubit.getAzanTimes();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "شي خطاء حدث اعد تحميل الصفحه",
                          style: GoogleAppTexeStyle.title,
                        )
                      ],
                    ),
                  )
            : RefreshIndicator(
                color: Colors.amber,
                onRefresh: () async {
                  await cubit.getAzanTimes();
                },
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    
                    itemBuilder: (context, index) => ListTile(
                          leading: Image(
                            image: AssetImage(cubit.prayers![index].icon),
                            height: 30,
                            width: 30,
                            color:
                                cubit.prayers![index].id == cubit.nextPrayer!.id
                                    ? Colors.amber
                                    : Colors.grey,
                          ),
                          title: Text(
                            cubit.prayers![index].title,
                            style: GoogleAppTexeStyle.title.copyWith(
                                color: cubit.prayers![index].id ==
                                        cubit.nextPrayer!.id
                                    ? Colors.amber
                                    : Colors.black),
                          ),
                          trailing: Text(
                            DateFormat.jm()
                                .format(cubit.prayers![index].date)
                                .replaceFirst("AM", "ص")
                                .replaceFirst("PM", "م"),
                            style: GoogleAppTexeStyle.subtitle.copyWith(
                                color: cubit.prayers![index].id ==
                                        cubit.nextPrayer!.id
                                    ? Colors.amber
                                    : Colors.black),
                          ),
                        ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: cubit.prayers!.length),
              );
  }
}




