import 'package:app_collectivity/Sign/sign_up.dart';

import 'HomePage/homepage.dart';
import 'package:flutter/material.dart';
import 'Sign/sign_in.dart';
import 'HomePage/firebase_example.dart';

void main() {
  runApp(HomePageMain(
    etkinlikAdlariList: FirebaseExample.PostEtkinlikAdlari,
    etkinlikKonumList: FirebaseExample.PostKonum,
    etkinlikProfilIsimList: FirebaseExample.PostIsimler,
    etkinlikProfilResimlerList: FirebaseExample.PostProfileImgs,
    etkinlikResimList: FirebaseExample.PostImgs,
    etkinlikTarihList: FirebaseExample.PostTarihler,
  ));
}
