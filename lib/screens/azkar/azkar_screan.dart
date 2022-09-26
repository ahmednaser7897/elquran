import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/models/azkar_model.dart';
import 'package:quran_app/screens/azkar/search.dart';


import '../../bloc/app_cubit/app_cubit.dart';
import '../../bloc/app_cubit/app_states.dart';
import '../../shard/data/azkar_data.dart';
import '../../shard/theme/app_text_styles.dart';
import 'azkar_data_screen.dart';
import 'cards.dart';


class AzkarScreen extends StatelessWidget {
  const AzkarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: DefaultTabController(
            length: 2,
            child: Scaffold(

               backgroundColor: Colors.white,
                appBar: AppBar(
                  actions:[ 
                     Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:  IconButton(
                    icon:const Icon(Icons.refresh,),
                    onPressed: () {
                      cubit.createAzkarData();
                    },
                  )
                  ),
                     Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:  IconButton(
                    icon:const Icon(Icons.search,),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Search()));
                    },
                  )
                  ),
                ],
                  title:const Text('الاذكار'),
                  bottom:  TabBar(
                    labelStyle: GoogleAppTexeStyle.body,
                    labelColor: Colors.amber,
                    unselectedLabelColor: Colors.white ,
                    indicatorColor: Colors.amber,
                    tabs:const [
                    Tab(
                      text: 'الاذكار',
                      icon:Image(
                        image: AssetImage("assets/images/icons/islam.png"),
                        height: 25,
                        width: 25,
                      ), 
                    ),
                    Tab(
                      text: 'المفضله',
                      icon:Image(
                        image: AssetImage("assets/images/icons/bookmark.png"),
                        height: 25,
                        width: 25,
                      ), 
                    )
                  ]),
                ),
                body: TabBarView(
                   physics:const BouncingScrollPhysics(),
                  children: [
                    ListView.separated(
                      clipBehavior: Clip.none,
                       physics:const BouncingScrollPhysics(),
                      itemBuilder: (context,indx)=> azkarBody(cubit.azkar[indx],context,indx),
                       separatorBuilder:(context,indx)=> const SizedBox(height: 10),
                        itemCount: myAzkarData.length),
                        cubit.favoriteAzkar.isEmpty?
                         Center(
                          child: Text("اضف بعض الاذكار",style: GoogleAppTexeStyle.heading,),
                        )
                        :ListView.separated(
                           physics:const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,indx)=> ZekeCard(showCategory: true,zkar: cubit.favoriteAzkar[indx],sound: true),
                       separatorBuilder:(context,indx)=> const SizedBox(height: 0),
                        itemCount: cubit.favoriteAzkar.length),
                  ],
                )),
          ),
        );
      },
    );
  }

  Widget azkarBody(Azkar azkar,context,int i) {
    return Card(
      elevation: 1,
      child: ListTile(
        onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) =>AzkarData(azkar) ));
        },
        trailing: const Icon(Icons.arrow_forward_ios,size: 15,),
        title: Text(
          (i + 1).toString() + " - " + azkar.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: GoogleAppTexeStyle.subtitle.copyWith(color: Colors.black)),
      ),
    );
  }

  Widget favoriteBody(Azkar azkar, BuildContext context) {
    return ListView.separated(
       physics: const ClampingScrollPhysics(), 
                        shrinkWrap: true,
              itemBuilder: (context,indx) {
                if(azkar.azkar[indx].isFavorite){
                    return ZekeCard(zkar: azkar.azkar[indx],
              showCategory:azkar.name=="متنوع"?true:false ,sound: true,
              );
                }else{
                  return Container();
                }
              
              },
              separatorBuilder:(context,indx)=> const SizedBox(height: 10),
               itemCount: azkar.azkar.length,
            );

  }
}
