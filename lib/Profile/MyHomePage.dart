import 'package:app_collectivity/HomePage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../HomePage/firebase_example.dart';
import 'Strore_Controller.dart';

//Ana Kod
class MyHomePage extends StatelessWidget {
  String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final controller = Get.put(Controller_Sayfasi());

  @override
  Widget build(BuildContext context) {
    //Kodta !...! olanlar diğer takım arkadaşları tarafından gönderilip sonradan değiştirilecek.
    return Scaffold(
        backgroundColor: Colors
            .white, //Ekranin orta kısmının rengini buradan ayarlayabiliriz.

        appBar: AppBar(
          title: const Text('ProfilePage'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: Icon(Icons.keyboard_backspace),
              
              onPressed: () {
                Get.to(HomePage(
                etkinlikAdlariList: FirebaseExample.PostEtkinlikAdlari, 
                etkinlikProfilResim: FirebaseExample.PostProfileImgs, 
                etkinlikProfilIsimList: FirebaseExample.PostIsimler, //Tekrar ana sayfaya dönmek.
                etkinlikResimList: FirebaseExample.PostImgs, 
                etkinlikTarihList: FirebaseExample.PostTarihler, 
                etkinlikKonumList: FirebaseExample.PostKonum));
              },
            )
          ],
        ),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                CircleAvatar(
                  backgroundImage:
                      // ignore: prefer_const_constructors
                      NetworkImage("https://picsum.photos/200/300"),   //Profil Fotoğrafı
                  radius: 50,
                ),
              
              //Profil Editleme
              ElevatedButton(onPressed: (() {
                
              }), child: Icon(Icons.edit))
              ],
            ), //!API!

            Text("Berke Balci",style: TextStyle(fontSize: 25,fontStyle: FontStyle.normal),), // İsim
            ElevatedButton(
                onPressed: () {
                  controller.increment();
                },
                child: Text("Artir"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepPurple))),

            ElevatedButton(
                onPressed: () {
                  Get.toNamed('/profile/'); //Get.toNamed ile oluyor mu?
                },
                child: Text("Sayfaya gec"))
          ]),
        ));
  }
}
