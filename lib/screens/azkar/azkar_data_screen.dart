// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


import '../../models/azkar_model.dart';
import '../../shard/theme/app_colors.dart';
import 'cards.dart';



class  AzkarData extends StatefulWidget {
  
  AzkarData(this.azkar,{ Key? key }) : super(key: key);
  Azkar azkar;
  @override
  State<AzkarData> createState() => _AzkarDataState();
}

class _AzkarDataState extends State<AzkarData> {
  bool sound=true;
  @override
  Widget build(BuildContext context) {
    return 
    Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    sound=!sound;
                  });
                },
                icon:!sound?const Icon(Icons.volume_up): const Icon(Icons.volume_off),
                color: AppColors.white,
                iconSize: 25,
              ),
          ],
          
          title: Text(widget.azkar.name,),),
          body: ListView.separated(
             physics:const BouncingScrollPhysics(),
            itemBuilder: (context,indx)=> ZekeCard(zkar: widget.azkar.azkar[indx],
            showCategory:widget.azkar.name=="متنوع"?true:false ,
            sound: sound,
            ),
            separatorBuilder:(context,indx)=> const SizedBox(height: 10),
             itemCount: widget.azkar.azkar.length,
          ),
      ),
    );
  }

}