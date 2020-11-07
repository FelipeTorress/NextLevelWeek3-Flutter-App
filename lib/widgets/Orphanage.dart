class Orphanage {
  int  id;
  String lat;
  String lng;
  String name;
  String about;
  String whatsapp;
  String images;
  String instructions;
  String opening_hour;
  String open_on_weekends;

  Orphanage();

  Orphanage.fromMap(Map map){
    id = map['id'];
    lat = map['lat'];
    lng = map['lng'];
    name = map['name'];
    about = map['about'];
    whatsapp = map['whatsapp'];
    images = map['images'];
    instructions = map['instructions'];
    opening_hour = map['opening_hour'];
    open_on_weekends = map['open_on_weekends'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'lat':lat,
      'lng':lng,
      'name':name,
      'about':about,
      'whatsapp':whatsapp,
      'images':images,
      'instructions':instructions,
      'opening_hour':opening_hour,
      'open_on_weekends':open_on_weekends
    };
    if (id != null && id != 0){
      map['id'] = id;
    }
    return map;
  }

}