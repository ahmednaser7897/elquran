import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/bloc/app_cubit/app_cubit.dart';
import 'package:quran_app/bloc/app_cubit/app_states.dart';

import '../../shard/theme/app_colors.dart';
import '../../shard/theme/app_text_styles.dart';
import 'cards.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late Function fun;
  @override
  void dispose() {
    fun();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var keyf = GlobalKey<FormState>();
        var searchC = TextEditingController();
        AppCubit cubit = AppCubit.get(context);
        fun = () {
          cubit.endSearchAzkar();
        };
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              title:const Text('ابحث عن ذكر', ),
            ),
            body: Column(
              children: [
                Form(
                  key: keyf,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        if (keyf.currentState!.validate()) {
                          cubit.searchAzkar(value);
                          searchC.text = value;
                        }
                      },
                      controller: searchC,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "اكتب شيا للبحث";
                        } else {
                          return null;
                        }
                      },
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "بحث",
                        counterStyle: const TextStyle(color: AppColors.black),
                        labelStyle: GoogleAppTexeStyle.body,
                        prefixIcon:
                            const Icon(Icons.search, color: AppColors.amber),
                        prefixStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: (cubit.foundAzar == null)
                        ? Container()
                        : (cubit.foundAzar!.isEmpty)
                            ? Center(
                                child: Text(
                                  "اعد البحث عن ذكر",
                                  style: GoogleAppTexeStyle.subheading,
                                ),
                              )
                            : foundAzarList(context))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget foundAzarList(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, indx) => ZekeCard(
              showCategory: true,
              zkar: cubit.foundAzar![indx],
              sound: true,
            ),
        separatorBuilder: (context, indx) => const SizedBox(height: 0),
        itemCount: cubit.foundAzar!.length);
  }
}
