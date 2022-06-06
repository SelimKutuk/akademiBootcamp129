import 'package:app_collectivity/Profile/Profile.dart';
import 'package:app_collectivity/Sign/sign_up.dart';
import 'package:app_collectivity/utils/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../modules/user.dart';
/*berkebalci*/

class Profile_Edit extends StatefulWidget {
  Profile_Edit({Key? key}) : super(key: key);

  @override
  State<Profile_Edit> createState() => _Profile_EditState();
}

class _Profile_EditState extends State<Profile_Edit> {
  User user = Userpreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA0B9C6),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  //Ana sayfa >>> Profil Sayfasi
                  builder: (BuildContext context) => Profile_Screen(),
                ),
                (route) => false,
              );
            }),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 30),
        children: [
          Photo_Edit(user: user), // 'Profile.dart' da olan widget
          SizedBox(
            height: 25,
          ),
          TextFieldWidget(
            label: "İsim,Soyisim",
            text: "${user.name}",
            index: 1,
            IsChanged: (name) {}, 
          ),
          SizedBox(
            height: 25,
          ),
          TextFieldWidget(
            label: "Lokasyon(Şehir/Ülke)",
            text: "${user.location}",
            index: 4,
            IsChanged: (location) {},
          ),
          SizedBox(
            height: 25,
          ),
          TextFieldWidget(
            label: "Yaş",
            text: "${user.age}",
            index: 2,
            IsChanged: (age) {}, //Burası API kısmı olcak.Api'ye istek aticaz.
          ),
          SizedBox(
            height: 25,
          ),
          TextFieldWidget(
            label: "Meslek",
            text: "${user.job}",
            index: 3,
            IsChanged: (job) {},
          ),
        ],
      ),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  String text; //Girilecek text
  ValueChanged<String> IsChanged; //Değer değiştiği zaman işimize yarar.
  String label; //Başlık(İsim,yaş,....)
   //Gelecek fonksiyon
  int index;
  TextFieldWidget(
      {Key? key,
      required this.IsChanged,
      required this.text,
      required this.label,
      required this.index})
      : super(key: key);
  late TextEditingController controller;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose(); //Başka sayfaya geçtiğimzde bunları silecek.
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.label}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextField(
          onChanged: (value) {
            setState(() {
              Userpreferences.Change_variable(value,widget.index);
            });
          },
          controller: widget.controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
        )
      ],
    );
  }
}
