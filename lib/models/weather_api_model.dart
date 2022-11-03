class weatherModel {
  Location? location;
  Current? current;

  weatherModel({this.location, this.current});

  weatherModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
    current =
        json['current'] != null ?  Current.fromJson(json['current']) : null;
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? tzId;
  int? localtimeEpoch;
  String? localtime;

  Location(
      {this.name,
      this.region,
      this.country,
      this.lat,
      this.lon,
      this.tzId,
      this.localtimeEpoch,
      this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    tzId = json['tz_id'];
    localtimeEpoch = json['localtime_epoch'];
    localtime = json['localtime'];
  }
}

class Current {
  double? tempC;
  Condition? condition;
  double? uv;

  Current({this.tempC, this.condition, this.uv});

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    condition = json['condition'] != null
        ?  Condition.fromJson(json['condition'])
        : null;
    uv = json['uv'];
  }
}

class Condition {
  String? text;
  String? icon;

  Condition({this.text, this.icon});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }
}

