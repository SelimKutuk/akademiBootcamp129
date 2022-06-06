import 'package:app_collectivity/HomePage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../HomePage/firebase_example.dart';
import '../Profile/Profile.dart';

//Post atma yeri
class Post extends StatelessWidget {
  const Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFA0B9C6)
      ,appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    //Profil_Edit >>> Profil Sayfasi
                    builder: (BuildContext context) => HomePage(
                        etkinlikAdlariList: FirebaseExample
                            .PostEtkinlikAdlari,  //Ana sayfaya geri dönme
                        etkinlikProfilResim: FirebaseExample.PostProfileImgs,
                        etkinlikProfilIsimList: FirebaseExample.PostIsimler,
                        etkinlikResimList: FirebaseExample.PostImgs,
                        etkinlikTarihList: FirebaseExample.PostTarihler,
                        etkinlikKonumList: FirebaseExample.PostKonum),
                  ),
                  (route) => false,
                );
              })),
      body: ListView(
        
      ),
    );
  }
}
class TextFieldWidget2 extends StatefulWidget {
  TextFieldWidget2({Key? key}) : super(key: key);

  @override
  State<TextFieldWidget2> createState() => _TextFieldWidget2State();
}

class _TextFieldWidget2State extends State<TextFieldWidget2> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        

      ],
);
  }
}
