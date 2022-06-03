import 'package:app_collectivity/HomePage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../HomePage/firebase_example.dart';

//Ana Kod
class Profile_Screen extends StatefulWidget {
  String title;
  Profile_Screen({Key? key, required this.title}) : super(key: key);

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  int sayi = 0;
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
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(
                        etkinlikAdlariList: FirebaseExample
                            .PostEtkinlikAdlari, //Ana sayfaya geri dönme
                        etkinlikProfilResim: FirebaseExample.PostProfileImgs,
                        etkinlikProfilIsimList: FirebaseExample.PostIsimler,
                        etkinlikResimList: FirebaseExample.PostImgs,
                        etkinlikTarihList: FirebaseExample.PostTarihler,
                        etkinlikKonumList: FirebaseExample.PostKonum),
                  ),
                  (route) => false,
                );
              },
            )),
        body: Container(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: (() {
                  print("Berke"); //Burası profil bilgileri değiştirme kısmı
                }),
                icon: Icon(Icons.edit, size: 25, color: Colors.blue),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                CircleAvatar(
                  backgroundImage:
                      // ignore: prefer_const_constructors
                      NetworkImage(
                          "https://picsum.photos/200/300"), //Profil Fotoğrafı
                  radius: 60,
                ),

                //Profil Editleme
              ],
            ), //!API!

            SizedBox(height: 15),
            Text(
              "Berke Balci",
              style: TextStyle(fontSize: 25, fontStyle: FontStyle.normal),
            ), // İsim

            //Diğer Bilgiler
            Row(children: [Text("Deneme")]),
            ElevatedButton(
                onPressed: () {
                  Arttir();
                },
                child: Text("Artir"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepPurple))),
          ]),
        ));
  }

  void Arttir() {
    setState(() {
      sayi++;
    });
  }

  Object? ProfileInfo_Check(var obj) {
    if (obj != null) {
      return obj;
    } else {
      //Profildeki bilgilerin dolu olup olmadığına bakıyor.
      return "---";
    }
  }
}
