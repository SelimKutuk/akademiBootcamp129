import 'package:app_collectivity/modules/user.dart';

class Userpreferences {
  static String name = "Goktug Arslan";
  static String age = "20";
  static String image_path = "https://picsum.photos/200/300";
  static String location = "Istanbul"; //2
  static String job = "Developer";
  static int Postnumber = 4;

  static var myUser = User(
    name: Userpreferences.name,
    age: Userpreferences.age,
    image_path: Userpreferences.image_path,
    location: Userpreferences.location,
    job: Userpreferences.job,
    Postnumber: Userpreferences.Postnumber,
  );
  static void Change_variable(String degisken, int index) {
    if (index == 1) {
      myUser.name = degisken;
    }
    else if(index == 2){
      myUser.age = degisken;
    }
     else if(index == 3){
      myUser.job = degisken;
    }
     else if(index == 4){
      myUser.location = degisken;
    }
    }
}
