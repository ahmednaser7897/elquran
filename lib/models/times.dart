
class PraysTimeModel {
  int? code;
  String? status;
  List<MainData>? data;

  PraysTimeModel({code, status, data});

  PraysTimeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = <MainData>[];
      json['data'].forEach((v) {
        data!.add( MainData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    // ignore: unnecessary_null_comparison
    if (data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainData {
  Timings? timings;
  Date? date;
  Meta? meta;

  MainData({timings, date, meta});

  MainData.fromJson(Map<String, dynamic> json) {
    timings =
        json['timings'] != null ?  Timings.fromJson(json['timings']) : null;
    date = json['date'] != null ?  Date.fromJson(json['date']) : null;
    meta = json['meta'] != null ?  Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (timings != null) {
      data['timings'] = timings!.toJson();
    }
    if (date != null) {
      data['date'] = date!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Timings {
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? imsak;
  String? midnight;
  String? firstthird;
  String? lastthird;

  Timings(
      {fajr,
      sunrise,
      dhuhr,
      asr,
      sunset,
      maghrib,
      isha,
      imsak,
      midnight,
      firstthird,
      lastthird});

  Timings.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    sunrise = json['Sunrise'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    sunset = json['Sunset'];
    maghrib = json['Maghrib'];
    isha = json['Isha'];
    imsak = json['Imsak'];
    midnight = json['Midnight'];
    firstthird = json['Firstthird'];
    lastthird = json['Lastthird'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Fajr'] = fajr;
    data['Sunrise'] = sunrise;
    data['Dhuhr'] = dhuhr;
    data['Asr'] = asr;
    data['Sunset'] = sunset;
    data['Maghrib'] = maghrib;
    data['Isha'] = isha;
    data['Imsak'] = imsak;
    data['Midnight'] = midnight;
    data['Firstthird'] = firstthird;
    data['Lastthird'] = lastthird;
    return data;
  }
}

class Date {
  String? readable;
  String? timestamp;
  Gregorian? gregorian;
  Hijri? hijri;

  Date({readable, timestamp, gregorian, hijri});

  Date.fromJson(Map<String, dynamic> json) {
    readable = json['readable'];
    timestamp = json['timestamp'];
    gregorian = json['gregorian'] != null
        ?  Gregorian.fromJson(json['gregorian'])
        : null;
    hijri = json['hijri'] != null ?  Hijri.fromJson(json['hijri']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['readable'] = readable;
    data['timestamp'] = timestamp;
    if (gregorian != null) {
      data['gregorian'] = gregorian!.toJson();
    }
    if (hijri != null) {
      data['hijri'] = hijri!.toJson();
    }
    return data;
  }
}

class Gregorian {
  String? date;
  String? format;
  String? day;
  EnWeekday? weekday;
  EnMonth? month;
  String? year;
  Designation? designation;

  Gregorian(
      {date,
      format,
      day,
      weekday,
      month,
      year,
      designation});

  Gregorian.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    format = json['format'];
    day = json['day'];
    weekday =
        json['weekday'] != null ?  EnWeekday.fromJson(json['weekday']) : null;
    month = json['month'] != null ?  EnMonth.fromJson(json['month']) : null;
    year = json['year'];
    designation = json['designation'] != null
        ?  Designation.fromJson(json['designation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['date'] = date;
    data['format'] = format;
    data['day'] = day;
    if (weekday != null) {
      data['weekday'] = weekday!.toJson();
    }
    if (month != null) {
      data['month'] = month!.toJson();
    }
    data['year'] = year;
    if (designation != null) {
      data['designation'] = designation!.toJson();
    }
    return data;
  }
}

class EnWeekday {
  String? en;

  EnWeekday({en});

  EnWeekday.fromJson(Map<String, dynamic> json) {
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['en'] = en;
    return data;
  }
}

class EnMonth {
  int? number;
  String? en;

  EnMonth({number, en});

  EnMonth.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['number'] = number;
    data['en'] = en;
    return data;
  }
}

class Designation {
  String? abbreviated;
  String? expanded;

  Designation({abbreviated, expanded});

  Designation.fromJson(Map<String, dynamic> json) {
    abbreviated = json['abbreviated'];
    expanded = json['expanded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['abbreviated'] = abbreviated;
    data['expanded'] = expanded;
    return data;
  }
}

class Hijri {
  String? date;
  String? format;
  String? day;
  Weekday? weekday;
  Month? month;
  String? year;
  Designation? designation;
  List<String>? holidays;

  Hijri(
      {date,
      format,
      day,
      weekday,
      month,
      year,
      designation,
      holidays});

  Hijri.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    format = json['format'];
    day = json['day'];
    weekday =
        json['weekday'] != null ?  Weekday.fromJson(json['weekday']) : null;
    month = json['month'] != null ?  Month.fromJson(json['month']) : null;
    year = json['year'];
    designation = json['designation'] != null
        ?  Designation.fromJson(json['designation'])
        : null;
    holidays = json['holidays'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['date'] = date;
    data['format'] = format;
    data['day'] = day;
    if (weekday != null) {
      data['weekday'] = weekday!.toJson();
    }
    if (month != null) {
      data['month'] = month!.toJson();
    }
    data['year'] = year;
    if (designation != null) {
      data['designation'] = designation!.toJson();
    }
    data['holidays'] = holidays;
    return data;
  }
}

class Weekday {
  String? en;
  String? ar;

  Weekday({en, ar});

  Weekday.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['en'] = en;
    data['ar'] = ar;
    return data;
  }
}

class Month {
  int? number;
  String? en;
  String? ar;

  Month({number, en, ar});

  Month.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['number'] = number;
    data['en'] = en;
    data['ar'] = ar;
    return data;
  }
}

class Meta {
  double? latitude;
  double? longitude;
  String? timezone;
  Method? method;
  String? latitudeAdjustmentMethod;
  String? midnightMode;
  String? school;
  //Offset? offset;

  Meta(
      {latitude,
      longitude,
      timezone,
      method,
      latitudeAdjustmentMethod,
      midnightMode,
      school,
      offset});

  Meta.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    timezone = json['timezone'];
    method =
        json['method'] != null ?  Method.fromJson(json['method']) : null;
    latitudeAdjustmentMethod = json['latitudeAdjustmentMethod'];
    midnightMode = json['midnightMode'];
    school = json['school'];
    //offset =json['offset'] != null ?  Offset.fromJson(json['offset']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['timezone'] = timezone;
    if (method != null) {
      data['method'] = method!.toJson();
    }
    data['latitudeAdjustmentMethod'] = latitudeAdjustmentMethod;
    data['midnightMode'] = midnightMode;
    data['school'] = school;
    /*if (offset != null) {
      data['offset'] = offset!.toJson();
    }*/
    return data;
  }
}

class Method {
  int? id;
  String? name;
  Params? params;
  Location? location;

  Method({id, name, params, location});

  Method.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    params =
        json['params'] != null ?  Params.fromJson(json['params']) : null;
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (params != null) {
      data['params'] = params!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Params {
  double? fajr;
  String? isha;

  Params({fajr, isha});

  Params.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    isha = json['Isha'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Fajr'] = fajr;
    data['Isha'] = isha;
    return data;
  }
}

class Location {
  double? latitude;
  double? longitude;

  Location({latitude, longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
/*
class Offset {
  int? imsak;
  int? fajr;
  int? sunrise;
  int? dhuhr;
  int? asr;
  int? maghrib;
  int? sunset;
  int? isha;
  int? midnight;

  Offset(
      {imsak,
      fajr,
      sunrise,
      dhuhr,
      asr,
      maghrib,
      sunset,
      isha,
      midnight});

  Offset.fromJson(Map<String, dynamic> json) {
    imsak = json['Imsak'];
    fajr = json['Fajr'];
    sunrise = json['Sunrise'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    maghrib = json['Maghrib'];
    sunset = json['Sunset'];
    //isha = json['Isha'];
    midnight = json['Midnight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Imsak'] = imsak;
    data['Fajr'] = fajr;
    data['Sunrise'] = sunrise;
    data['Dhuhr'] = dhuhr;
    data['Asr'] = asr;
    data['Maghrib'] = maghrib;
    data['Sunset'] = sunset;
    //data['Isha'] = isha;
    data['Midnight'] = midnight;
    return data;
  }
}*/