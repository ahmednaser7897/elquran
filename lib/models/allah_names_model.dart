

class AllahNameModel {
   late String name;
   late String text;

  AllahNameModel(this.name, this.text);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'text': text,
    };
  }
   AllahNameModel.fromMap(Map<String, dynamic> map) {
    name=  map['name'].toString();
    text=  map['text'].toString();
  }  
}
