/*

CanberkD ve berkebalci tarafından yazıldı.

Kullanılan harici paketler:
  cached_network_image: ^3.2.0

*/
import 'package:app_collectivity/HomePage/firebase_example.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Profile/Profile.dart';


class HomePageMain extends StatelessWidget {
  List<String> etkinlikAdlariList;
  List<String> etkinlikProfilResimlerList;
  List<String> etkinlikProfilIsimList;
  List<String> etkinlikResimList;
  List<String> etkinlikTarihList;
  List<String> etkinlikKonumList;

  HomePageMain({
    Key? key,
    required this.etkinlikAdlariList,
    required this.etkinlikProfilResimlerList,
    required this.etkinlikProfilIsimList,
    required this.etkinlikResimList,
    required this.etkinlikTarihList,
    required this.etkinlikKonumList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collectivity Homepage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: HomePage(
          etkinlikAdlariList: etkinlikAdlariList,
          etkinlikProfilResim: etkinlikProfilResimlerList,
          etkinlikProfilIsimList: etkinlikProfilIsimList,
          etkinlikResimList: etkinlikResimList,
          etkinlikTarihList: etkinlikTarihList,
          etkinlikKonumList: etkinlikKonumList),

      //Berke Balci
      /*onGenerateInitialRoutes: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return  HomePage();
            break;
          case '/second':
            return SlideRightRoute(widget: SecondHome());
            break;
        }
      }*/
    );
  }
}

//RENKLER
Color colorMainBackGround = const Color(0xFFA0B9C6);

Color colorEtiket = const Color(0xFF0F49AC);

Color colorPostBackGround = const Color(0xFFA0B9C6);

class HomePage extends StatefulWidget {
  late final List<String> etkinlikAdlariList;

  late final List<String> etkinlikProfilResim;

  late final List<String> etkinlikProfilIsimList;

  late final List<String> etkinlikResimList;

  late final List<String> etkinlikTarihList;

  late final List<String> etkinlikKonumList;

  HomePage({
    Key? key,
    required this.etkinlikAdlariList,
    required this.etkinlikProfilResim,
    required this.etkinlikProfilIsimList,
    required this.etkinlikResimList,
    required this.etkinlikTarihList,
    required this.etkinlikKonumList,
  }) : super(key: key);
  
 
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMainBackGround,
      body: Column(
        children: [
          /* ETİKET BARI. SONRA EKLENMESİ DURUMUNDA KULLANILACAK.
          SizedBox(
            height: 70,
            child: Expanded(child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(color: colorEtiket, borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text('estiket' + index.toString(), style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  );
                }
              )
            ),
          ),

           */
          Expanded(
            child: RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: FirebaseExample.PostIsimler.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      //ETKİNLİĞE TIKLANDI.
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(widget.etkinlikAdlariList[index] +
                            ' İsimli Etkinlik Tıklandı.'),
                      ));
                    },
                    child: Container(
                      height: 535,
                      decoration: BoxDecoration(color: colorPostBackGround),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircleAvatar(
                                    child: ClipOval(
                                        child: CachedNetworkImage(
                                      imageUrl:
                                          widget.etkinlikProfilResim[index],
                                      fit: BoxFit.cover,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 18.0,
                                  ),
                                  child: Text(
                                    widget.etkinlikProfilIsimList[index],
                                    style: const TextStyle(
                                        color: CupertinoColors.black,
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ETKİNLİK: ' +
                                            widget.etkinlikAdlariList[index],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                          'TARİH: ' +
                                              widget.etkinlikTarihList[index],
                                          style: const TextStyle(fontSize: 18)),
                                      Text(
                                          'YER: ' +
                                              widget.etkinlikKonumList[index],
                                          style: const TextStyle(fontSize: 18)),
                                    ]),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 372,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                    imageUrl: widget.etkinlikResimList[index]),
                              )),
                          const Divider(
                            thickness: 3,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        ElevatedButton(
          
          child: Icon(Icons.manage_accounts_outlined,size: 30),
          onPressed: () {
            Go_Profile();
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            )
        )
      ]),
    );
  }

  Future<void> refresh() async {
    setState(() {
      widget.etkinlikAdlariList = FirebaseExample.PostEtkinlikAdlari;
      widget.etkinlikResimList = FirebaseExample.PostImgs;
      widget.etkinlikKonumList = FirebaseExample.PostKonum;
      widget.etkinlikTarihList = FirebaseExample.PostTarihler;
      widget.etkinlikProfilIsimList = FirebaseExample.PostIsimler;
      widget.etkinlikProfilResim = FirebaseExample.PostProfileImgs;
    });
  }

  
  Future? Go_Profile() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(  //Ana sayfa >>> Profil Sayfasi
        builder: (BuildContext context) => Profile_Screen(),
      ),
      (route) => false,
    );
  }
}

