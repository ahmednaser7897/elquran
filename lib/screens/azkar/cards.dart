// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_cubit/app_cubit.dart';
import '../../bloc/app_cubit/app_states.dart';
import '../../models/azkar_model.dart';
import '../../shard/theme/app_colors.dart';
import '../../shard/theme/app_text_styles.dart';

class ZekeCard extends StatefulWidget {
  final Zekr zkar;
  final bool showCategory;
  bool sound;
  ZekeCard(
      {Key? key,
      required this.zkar,
      required this.showCategory,
      required this.sound})
      : super(key: key);

  @override
  State<ZekeCard> createState() => _ZekeCardState();
}

class _ZekeCardState extends State<ZekeCard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return GestureDetector(
            onTap: widget.zkar.count > 0
                ? () {
                    if (widget.sound) {
                      cubit.playSound();
                    }
                    setState(() {
                      widget.zkar.count--;
                    });
                  }
                : null,
            child: Card(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Column(children: [
                      if (widget.showCategory)
                        Text(widget.zkar.category,
                            textAlign: TextAlign.center,
                            style: GoogleAppTexeStyle.subheading
                                .copyWith(color: AppColors.black)),
                      if (widget.showCategory)
                        const SizedBox(
                          height: 10,
                        ),
                      Text(widget.zkar.zekr,
                          textAlign: TextAlign.center,
                          style: GoogleAppTexeStyle.subtitle
                              .copyWith(color: Colors.black, height: 1.5)),
                      if (widget.zkar.description.isNotEmpty)
                        const SizedBox(
                          height: 10,
                        ),
                      if (widget.zkar.description.isNotEmpty)
                        Text(widget.zkar.description,
                            textAlign: TextAlign.center,
                            style: GoogleAppTexeStyle.body
                                .copyWith(color: AppColors.cyan)),
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: widget.zkar.isFavorite
                                      ? AppColors.red
                                      : AppColors.black,
                                ),
                                onPressed: () {
                                  cubit.changeFavorite(widget.zkar);
                                },
                              )),
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: widget.zkar.count > 0
                                ? AppColors.amber
                                : AppColors.black,
                            child: CircleAvatar(
                              backgroundColor: AppColors.white,
                              radius: 20,
                              child: Text(
                                widget.zkar.count > 0
                                    ? widget.zkar.count.toString()
                                    : "تم",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: RotatedBox(
                          quarterTurns: 2,
                          child: Image.asset(
                            "assets/images/decor/3.png",
                            height: 60,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class HadithCard extends StatefulWidget {
  const HadithCard({
    Key? key,
    required this.hadith,
  }) : super(key: key);
  final String hadith;
  @override
  State<HadithCard> createState() => _HadithCardState();
}

class _HadithCardState extends State<HadithCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: RichText(
            text: TextSpan(
                text: widget.hadith,
                style: GoogleAppTexeStyle.subtitle
                    .copyWith(color: Colors.black, height: 1.5)),
          )),
    );
  }
}
