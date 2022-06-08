/*

CanberkD tarafından yazıldı.

Kullanılan harici paketler:
  proste_bezier_curve
*/

import 'package:app_collectivity/Sign/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'final_vars.dart';
import 'somestuff.dart';

class SignUpMain extends StatelessWidget {

  const SignUpMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Collectivity'e üye ol",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: UsefulStuff.getMaterialColorFromHex("#0F49AC")
      ),
      home: RegisterHomePage(),
    );
  }
}

class RegisterHomePage extends StatefulWidget {
  @override
  _RegisterHomePageState createState() => _RegisterHomePageState();
}

final controller1 = TextEditingController();

final controller2 = TextEditingController();

final controller3 = TextEditingController();

final controller4 = TextEditingController();

bool texterror = false;
bool passerror = false;

class _RegisterHomePageState extends State<RegisterHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkCultured,
      body: ListView(
        children: [
          CurvedBackgroundWithText(text1: 'Hesap', text2:"oluştrur.", text3: "", width: 300),
          Container(
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
                    height: 310,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: darkCultured),
                          child: TextFormField(
                            controller: controller1,
                            onChanged: (text) {
                              if(text.length > 8){
                                setState(() {
                                  texterror = true;
                                });
                              }
                              else {
                                setState(() {
                                  texterror = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                                hintText: 'İsim',
                                errorText: validateKullanici()
                            ),

                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: darkCultured),
                          child: TextFormField(
                            controller: controller2,
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
                            onChanged: (text) {
                              if(text.contains("'") && !text.contains("=")){
                                setState(() {
                                  passerror = true;
                                });
                              }
                              else {
                                setState(() {
                                  passerror = false;
                                });
                              }
                              if(text.length <=6){
                                setState(() {
                                  passerror = true;
                                });
                              }
                              else {
                                setState(() {
                                  passerror = false;
                                });
                              }
                            },
                            obscureText: true,
                            enableSuggestions: false,
                            controller: controller3,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline),
                              border: OutlineInputBorder(),
                              hintText: 'şifre',
                              errorText: validatePassword(),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: darkCultured),
                          child: TextFormField(
                            controller: controller4,
                            obscureText: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline),
                              border: OutlineInputBorder(),
                              hintText: 'şifre tekrar',
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
                                child: Center(child: Text("Üye ol", style: TextStyle(color: darkCultured),)),
                              )
                          ),
                          onTap: () {
                            //Giriş yap clicked
                            RegisterClicked();
                          }, )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: RichText(
                    text: TextSpan(style: TextStyle(color: Colors.black),
                        text: 'Zaten üye misin?',
                        children: [
                          TextSpan(
                              style: TextStyle(color: colorPurpuse),
                              text: ' Giriş yap',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //Giriş yapmak istiyor.
                                  Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  //Ana sayfa >>> Profil Sayfasi
                  builder: (BuildContext context) => SignInMain(),
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
          )
        ],
      ),
    );
  }

  void RegisterClicked() {
    print(" 1" + controller1.text);
    print(" 2" + controller2.text);
    print(" 3" + controller3.text);
    print(" 4" + controller4.text);
  }

  String? validateKullanici() {
    if (texterror) {
      return "Kullanıcı adı max 8 karakter olmalı.";
    }
    return null;
  }
  String? validatePassword() {
    if (passerror) {
      return "Şifre hatalı. Minimum 6 karakter olmalı.";
    }
    return null;
  }

}
