

// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:quran_app/shard/database/database.dart';

class Azkar {
  late String name;
  List<Zekr> azkar=[];
  Azkar({
    required this.name,
  });
  //setName(String name)=>this.name=name;
  Azkar.fromJason(List l,this.name){
    int id=0;
    for (var item in l) {
      Zekr z=Zekr.fromMap(item);
      z.setid(id);
      if(name=="متنوع"){
        z.setMainCategory("متنوع");
      }
      azkar.add(z);
      id++;
    }
  }

 
  }


class Zekr {
  late int id;
  late String category;
  String? mainCategory;
  late int count;
  late String description;
  late String reference;
  late String zekr;
  int number=0;
  DataBase db=DataBase();
  bool isFavorite=false;
  Zekr({
    required this.category,
    required this.count,
    required this.description,
    required this.reference,
    required this.zekr,
    required this.id
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'count': count,
      'description': description,
      'reference': reference,
      'zekr': zekr,
      //'favorite':favorite
    };
  }
  Map<String, dynamic> toDB() {
    return <String, dynamic>{
      if(mainCategory==null)
      'category': category,
       if(mainCategory!=null)
       'category': mainCategory,
      'id':id
    };
  }

   Zekr.fromMap(Map<String, dynamic> map) {
    try{
      category= map['category'] as String;
      count=map['count'].toString().isEmpty?1: int.parse(map['count']) ;
      description= map['description'] as String;
      reference= map['reference'] as String;
      zekr= map['zekr'] as String;
      //favorite=map['favorite']as bool;

    }catch(e){
      print("erorr in  Zekr.fromMap is $e");
    }
      
  }

  void setid(int id) {
    this.id=id;
  }
  void setMainCategory(String mainCategory) {
    this.mainCategory=mainCategory;
  }
   addToFav()async{
    isFavorite=true;
    await db.insertFavZekr(this);
  }
   deletfromFav()async{
    isFavorite=false;
    await db.deletFavZekr(this);
  }

}
