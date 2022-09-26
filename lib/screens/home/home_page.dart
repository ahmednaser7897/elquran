import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/bloc/app_cubit/app_cubit.dart';
import 'package:quran_app/bloc/app_cubit/app_states.dart';
import 'package:quran_app/shard/theme/app_colors.dart';


import '../../shard/services/size_config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SizeConfig().init(context);
        AppCubit cubit = AppCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              body: cubit.screens[cubit.indix],
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: AppColors.white,
                buttonBackgroundColor: Colors.teal,
                index: cubit.indix,
                items: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: cubit.indix == 0 ? Colors.white : Colors.black,
                      ),
                    ],
                  ),
                  bottomBar(cubit, 1, "assets/images/icons/quran.png"),
                  bottomBar(cubit, 2, "assets/images/icons/pray.png"),
                  bottomBar(cubit, 3, "assets/images/icons/decoration.png",
                      changedName: "احاديث"),
                  bottomBar(cubit, 4, "assets/images/icons/s.png",
                      changedName: "التقويم"),
                ],
                onTap: (index) {
                  cubit.changBottomBarIndix(index, context);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Column bottomBar(AppCubit cubit, int i, String image, {String? changedName}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          height: 25,
          image: AssetImage(image),
          color: cubit.indix == i ? Colors.white : Colors.black,
        )
      ],
    );
  }
}
