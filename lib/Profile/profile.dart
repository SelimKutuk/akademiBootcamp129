import 'dart:ffi';

import 'package:app_collectivity/HomePage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../HomePage/firebase_example.dart';

//Ana Kod
class Profile_Screen extends StatefulWidget {
  String name = "---";
  String? age = "---";
  String? job = "---";
  String city = "---";
  Profile_Screen(
      {Key? key, required this.name, required this.city, this.age, this.job})
      : super(key: key);

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  int post_number = 4; //Profildeki post sayisi(Firebase'den gelcek)

  @override
  Widget build(BuildContext context) {
    //Kodta !...! olanlar diğer takım arkadaşları tarafından gönderilip sonradan değiştirilecek.
    @override
    void initState() {
      super.initState();
    }

    return Scaffold(
        backgroundColor: colorMainBackGround
            , //Ekranin orta kısmının rengini buradan ayarlayabiliriz.

        body: Container(
          child: Column(children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.keyboard_backspace,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomePage(
                            etkinlikAdlariList: FirebaseExample
                                .PostEtkinlikAdlari, //Ana sayfaya geri dönme
                            etkinlikProfilResim:
                                FirebaseExample.PostProfileImgs,
                            etkinlikProfilIsimList: FirebaseExample.PostIsimler,
                            etkinlikResimList: FirebaseExample.PostImgs,
                            etkinlikTarihList: FirebaseExample.PostTarihler,
                            etkinlikKonumList: FirebaseExample.PostKonum),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
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
              "${widget.name}",
              style: TextStyle(fontSize: 25, fontStyle: FontStyle.normal),
            ), // İsim

            //Diğer Bilgiler
            Text("${widget.city}"),
            Row(children: [
              Expanded(child: Text("${widget.job}")),
              Expanded(child: Text("${widget.age}"))
            ]),
            ElevatedButton(
                onPressed: () {
                  Post_Arttir();
                },
                child: Text("Artir"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepPurple))),
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: post_number,
                      separatorBuilder: (context, _) => SizedBox(height: 5),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Column(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Etkinlik Saati:20.00"),
                                    Text("Etkinlik Yeri:İstanbul"),
                                    Text("Tarih: 21.06.2022")
                                  ]),
                              SizedBox(
                                  child: Image.network(
                                'https://previews.123rf.com/images/captainvector/captainvector1703/captainvector170301312/73848230-logo-universit%C3%A9.jpg',
                                height: 330,
                              )),
                              Divider(
                                thickness: 5,
                                indent: 20,
                                endIndent: 20,
                                color: Colors.black,
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            )
          ]),
        ));
  }

  void Post_Arttir() {
    setState(() {
      post_number++;
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
