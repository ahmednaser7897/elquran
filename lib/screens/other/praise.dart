import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/screens/other/praise_widgets.dart';

import '../../bloc/app_cubit/app_cubit.dart';
import '../../bloc/app_cubit/app_states.dart';
import '../../shard/services/size_config.dart';

class Praise extends StatefulWidget {
  const Praise({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  //final Azkar? azkar;

  @override
  State<Praise> createState() => _PraiseState();
}

List<int> numbers = const [33, 99, 100, 3, 10, 70];

class _PraiseState extends State<Praise> {
  int zekrIndx = 0;
  bool sound = true;
 
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SizeConfig().init(context);
        AppCubit cubit = AppCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    widget.title,
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        cubit.createAzkarData();
                      },
                      icon: const Icon(
                        Icons.refresh,
                        size: 20,
                      ),
                    )
                  ],
                ),
                body: cubit.praise == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          carouselSlider(context),
                          praiseBotton(() {
                            ontapPraiseBotton(cubit);
                          }),
                          optionRow(
                            text: numbers[cubit.praise!.azkar[zekrIndx].number]
                                .toString(),
                            sound: sound,
                            onTap1: () {
                              setState(() {
                                if (cubit.praise!.azkar[zekrIndx].number ==
                                    numbers.length - 1) {
                                  cubit.praise!.azkar[zekrIndx].number = 0;
                                } else {
                                  cubit.praise!.azkar[zekrIndx].number++;
                                }
                              });
                            },
                            onTap2: () {
                              setState(() {
                                sound = !sound;
                              });
                            },
                            onTap3: () {
                              setState(() {
                                cubit.praise!.azkar[zekrIndx].count = 0;
                                cubit.praise!.azkar[zekrIndx].number = 0;
                              });
                            },
                          ),
                        ],
                      ))
        
        );
      },
    );
  }

  void ontapPraiseBotton(AppCubit cubit) {
    //e.count <= zekeCount - 1
    if (sound &&
        cubit.praise!.azkar[zekrIndx].count <=
            numbers[cubit.praise!.azkar[zekrIndx].number] - 1) {
      cubit.playSound();
    }
    if (cubit.praise!.azkar[zekrIndx].count <=
        numbers[cubit.praise!.azkar[zekrIndx].number] - 1) {
      setState(() {
        cubit.praise!.azkar[zekrIndx].count++;
      });
    }
  }

  Widget carouselSlider(ctx) {
    AppCubit cubit = AppCubit.get(ctx);
    return CarouselSlider(
        items: cubit.praise!.azkar.map<Widget>((e) {
          int zekeCount = numbers[e.number];
          return zekeCard(e, zekeCount, sound, () {
            //e.count <= zekeCount - 1
            if (sound && e.count <= zekeCount - 1) {
              cubit.playSound();
            }
            if (e.count <= zekeCount - 1) {
              setState(() {
                e.count++;
              });
            }
          });
        }).toList(),
        options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                zekrIndx = index;
              });
            },
            initialPage: 0,
            enableInfiniteScroll: true,
            height: SizeConfig.screenHeight * 0.4,
            autoPlayAnimationDuration: const Duration(milliseconds: 500),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: 0.85));
  }
}
