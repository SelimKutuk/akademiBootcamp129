import 'dart:ffi';
import 'package:app_collectivity/HomePage/homepage.dart';
import 'package:app_collectivity/Profile/Profil_Edit.dart';
import 'package:app_collectivity/Sign/sign_in.dart';
import 'package:app_collectivity/modules/user.dart';
import 'package:app_collectivity/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../HomePage/firebase_example.dart';

/*berkebalci*/ 
class Profile_Screen extends StatefulWidget {
  Profile_Screen({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  //Profildeki post sayisi(Firebase'den gelcek)
  //**********************
  
  var user = Userpreferences.myUser;   //3
  
  
  //**********************
  @override
  Widget build(BuildContext context) {
    //Kodta !...! olanlar diğer takım arkadaşları tarafından gönderilip sonradan değiştirilecek.
    @override
    void initState() {
      super.initState();
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  //Ana sayfa >>> Profil Sayfasi
                  builder: (BuildContext context) => SignInMain(
),
                ),
                (route) => false,
              );
          },
          child: Icon(Icons.logout,)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop
        ,backgroundColor:
            colorMainBackGround, //Ekranin orta kısmının rengini buradan ayarlayabiliriz.

        body: Center(
          child: ListView(
                    children:[
                      Column(children: [
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
                                        etkinlikProfilIsimList:
                                            FirebaseExample.PostIsimler,
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
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  // Profil >>> Profil Editleme
                                  builder: (BuildContext context) => Profile_Edit(),
                                ),
                                (route) => false,
                              );
                              ; //Burası profil bilgileri değiştirme kısmı
                            }),
                            icon: Icon(Icons.edit, size: 25, color: Colors.blue),
                          ),
                        ),
                        Photo_Edit(user: user), //!API!

                        SizedBox(height: 15),
                        Text(
                          "${user.name}",
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                        ), // İsim

                        //Diğer Bilgiler
                        Text("${user.location}"),
                        Column(children: [
                          Text(
                            "Meslek: ${user.job}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Yaş: ${user.age}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ]),

                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: user.Postnumber,
                                  separatorBuilder: (context, _) => SizedBox(height: 5),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Etkinlik Saati:20.00",
                                                ),
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
                    ],
                  ),
          ),
              );
  }

  void Post_Arttir() {
    setState(() {
      user.Postnumber++;
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

class Photo_Edit extends StatelessWidget {  //Bu widget "Profile_Edit.dart"'da kullanıldı
  const Photo_Edit({
    Key? key,
    required this.user, //Tekrardan user almamızın sebebi
    //'user''ın fieldlarını değiştireceğiz o yüzden
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        // ignore: prefer_const_constructors
        InkWell(
          
            child: Ink(

              child: CircleAvatar(
                child: Container(child: 
                Align(
                  alignment: Alignment.bottomRight
                  ,child: 
                  Icon(Icons.camera_alt_sharp,color: Colors.white,
                  size: 30,)),),
                backgroundImage:
                    // ignore: prefer_const_constructors
                    NetworkImage(user.image_path), //Profil Fotoğrafı
                radius: 60,
              ),
            ),
            onTap: (){
              setState(){  //Buraya sonra bakılacak

              }
            },

            ),

        //Profil Editleme
      ],
    );
  }
}
