/*

CanberkD tarafından yazıldı.

Kullanılan harici paketler:
  proste_bezier_curve
*/

import 'package:app_collectivity/HomePage/homepage.dart';
import 'package:app_collectivity/Sign/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../HomePage/firebase_example.dart';
import 'final_vars.dart';
import 'somestuff.dart';

class SignInMain extends StatelessWidget {
  const SignInMain({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Collectivity'e Giriş Yap",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: UsefulStuff.getMaterialColorFromHex("#0F49AC"),
      ),
      home: const RegisterMain(),
    );
  }
}

class RegisterMain extends StatefulWidget {
  const RegisterMain({Key? key,}) : super(key: key);


  @override
  State<RegisterMain> createState() => _RegisterMainState();
}

class _RegisterMainState extends State<RegisterMain> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        backgroundColor: darkCultured,
        body: ListView(
          children: [
            Column(
              children: [
                CurvedBackgroundWithText(text1: "COLLECTIVITY'e", text2: "Giriş", text3: "Yap", width: 400,),
              
                ContainerLogin()],
            ),
          ],
        )
    );
  }
}

class ContainerLogin extends StatelessWidget {
  ContainerLogin({
    Key? key,
  }) : super(key: key);

  final controller1 = TextEditingController();

  final controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color: UsefulStuff.getColorFromHex("#ECECF0"),
          boxShadow:[
            BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                blurRadius: 6
            )
          ]
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: SizedBox(
              width: 300,
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(color: darkCultured),
                    child: TextFormField(
                      controller: controller1,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                        hintText: 'e-mail',
                      ),

                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: darkCultured),
                    child: TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      controller: controller2,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                        hintText: 'şifre',
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                        decoration: BoxDecoration(gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              UsefulStuff.getColorFromHex("#5012A1"),
                              UsefulStuff.getColorFromHex("#0F49AC"),
                              UsefulStuff.getColorFromHex("#3CD2CD"),

                            ]
                        ),
                            borderRadius: BorderRadius.all(Radius.circular(4.0))),
                        child: SizedBox(
                          width: 120,
                          height: 45,
                          child: Center(child: Text("Giriş yap", style: TextStyle(color: darkCultured),)),
                        )
                    ),
                    onTap: () {
                      //Giriş yap clicked
                      LoginClicked(context);
                    }, )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: RichText(
              text: TextSpan(style: TextStyle(color: Colors.black),
                  text: 'Henüz üye değil misin?',
                  children: [
                    TextSpan(
                        style: TextStyle(color: colorPurpuse),
                        text: ' Üye ol',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //Üye ol Clicked
                            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  //Ana sayfa >>> Profil Sayfasi
                  builder: (BuildContext context) => SignUpMain(),
                ),
                (route) => false,
              );

                          }
                    ),
                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }

  void LoginClicked(BuildContext context) {
    //Giriş yap tıklandı.
     Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  //Ana sayfa >>> Profil Sayfasi
                  builder: (BuildContext context) => HomePage(
                    etkinlikAdlariList: FirebaseExample
                                            .PostEtkinlikAdlari, //Ana sayfaya geri dönme
                                        etkinlikProfilResim:
                                            FirebaseExample.PostProfileImgs,
                                        etkinlikProfilIsimList:
                                            FirebaseExample.PostIsimler,
                                        etkinlikResimList: FirebaseExample.PostImgs,
                                        etkinlikTarihList: FirebaseExample.PostTarihler,
                                        etkinlikKonumList: FirebaseExample.PostKonum
                  ),
                ),
                (route) => false,
              );

  }

}

