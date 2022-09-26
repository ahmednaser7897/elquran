class QuranModel {
  List<Surah>? surahs;
  QuranModel({this.surahs});
  QuranModel.fromJson(Map<String, dynamic> json) {
    if (json['surahs'] != null) {
      surahs = <Surah>[];
      json['surahs'].forEach((v) {
        surahs!.add(Surah.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (surahs != null) {
      data['surahs'] = surahs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Surah {
  int? id;
  String? name;
  List<Verses>? verses;

  Surah(
      {this.id,
      this.name,
      this.verses});

  Surah.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['verses'] != null) {
      verses = <Verses>[];
      json['verses'].forEach((v) {
        verses!.add( Verses.fromJson(v,this));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (verses != null) {
      data['verses'] = verses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Verses {
  int? id;
  String? text;
  Surah? surah;
  Verses({this.id, this.text,this.surah});
  Verses.fromJson(Map<String, dynamic> json,this.surah) {
    id = json['id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    return data;
  }
}
