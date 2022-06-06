import 'package:get/get_connect/http/src/request/request.dart';

import '../utils/user_preferences.dart';

class User {
  String name;
  String location;
  String age;
  String job;           //1
  String image_path;
  int Postnumber;
  
  User(
      {required this.name ,
      required this.age,
      required this.job,
      required this.location,
      required this.image_path, 
      required this.Postnumber});
}

//JSON'a dönüştürme eklenecek.
