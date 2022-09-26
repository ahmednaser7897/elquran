import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


import '../../models/azkar_model.dart';
import '../../shard/services/size_config.dart';
import '../../shard/theme/app_colors.dart';
import '../../shard/theme/app_text_styles.dart';

InkWell button(
    {required Function onTap,
    required double radius,
    required String text,
    required double fontSize}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.teal,
        child: Text(text,
            style: GoogleAppTexeStyle.subtitle
                .copyWith(fontSize: fontSize, color: AppColors.amber))),
  );
}

Padding praiseBotton(Function onTap) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.2),
    child: InkWell(
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.amber),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Image.asset(
            "assets/images/icons/rosary.png",
            fit: BoxFit.contain,
            width: 40,
            height: 40,
          )),
      onTap: () {
        onTap();
      },
    ),
  );
}

Row optionRow({
  required String text,
  required bool sound,
  required Function onTap1,
  required Function onTap2,
  required Function onTap3,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      button(
          fontSize: 20,
          radius: 20,
          text: text,
          onTap: () {
            onTap1();
          }),
      IconButton(
        onPressed: () {
          onTap2();
        },
        icon:
            !sound ? const Icon(Icons.volume_up) : const Icon(Icons.volume_off),
        color: AppColors.teal,
        iconSize: 35,
      ),
      IconButton(
        onPressed: () {
          onTap3();
        },
        icon: const Icon(Icons.restart_alt),
        color: AppColors.teal,
        iconSize: 35,
      ),
    ],
  );
}



Widget zekeCard(Zekr e, int zekeCount, bool sound, Function onTap) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    margin: const EdgeInsetsDirectional.all(5),
    color: AppColors.white,
    child: GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: HexColor("#fdf4e3"),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: SizeConfig.screenWidth * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 2, color: Colors.amber),
                      top: BorderSide(width: 2, color: Colors.amber),
                    ),
                  ),
                  child: Text(e.zekr,
                      textAlign: TextAlign.center,
                      style:
                          GoogleAppTexeStyle.title.copyWith(fontSize: 16)),
                ),
                const SizedBox(
                  height: 40,
                ),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: e.count <= zekeCount - 1
                      ? AppColors.amber
                      : AppColors.black,
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 20,
                    child: Text(
                      e.count <= zekeCount - 1 ? e.count.toString() : "تم",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
