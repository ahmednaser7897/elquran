// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:quran_app/shard/theme/app_colors.dart';
import 'package:quran_app/shard/theme/app_text_styles.dart';

import 'bloc/app_cubit/app_cubit.dart';
import 'bloc/app_cubit/app_states.dart';
import 'bloc/observer.dart';
import 'screens/home/home_page.dart';
import 'shard/services/shared_preferences.dart';

import 'shard/database/database.dart';
import 'shard/network/dio_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DataBase db = DataBase();
  await db.createDB();
  await CachHelper.inti();
  DioHelper.inti();
  BlocOverrides.runZoned(() {
    runApp(
      const MyApp(),
    );
  }, blocObserver: MyBlocObserver());
  Bloc.observer;
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (ctx) => AppCubit()
                ..playSound(noSound: true)
                ..createAzkarData()
                ..getPrayersTime()
                ..getAzanTimes(),
              ),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                navigatorKey: navigatorKey,
                themeMode: ThemeMode.light,
                theme: ThemeData(
                    primaryColorLight: Colors.amber,
                    cardTheme: const CardTheme(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5,
                        margin: EdgeInsetsDirectional.all(5),
                        color: Colors.white),
                    primaryColor: AppColors.white,
                    appBarTheme: AppBarTheme(
                        backgroundColor: AppColors.appBarColor,
                        titleTextStyle: GoogleAppTexeStyle.subtitle
                            .copyWith(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)
                            .copyWith(color: AppColors.white),
                        elevation: 0)),
                title: 'Quran App',
                debugShowCheckedModeBanner: false,
                home: const Directionality(
                    textDirection: TextDirection.rtl, child: HomePage()
                    //QuranScreen(title: "القران",)
                    ));
          },
        ),
      );
  }
}
