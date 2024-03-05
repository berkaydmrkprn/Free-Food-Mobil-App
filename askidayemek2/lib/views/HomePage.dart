import 'package:askidayemek2/main.dart';
import 'package:askidayemek2/views/ilanver.dart';
import 'package:askidayemek2/views/yoneticiIlanlari.dart';
import 'package:flutter/material.dart';
import 'package:askidayemek2/views/yoneticilogin.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(205, 193, 197, 1.0),
                Color.fromRGBO(139, 131, 134, 1.0),
              ],
            ),
          ),
          padding: EdgeInsets.all(50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ilan1()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    fixedSize: Size(250, 100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.announcement,
                        size: 30,
                        color: Color.fromRGBO(109, 130, 153, 1.0),
                      ),
                      Text(
                        'Yemek İlanı Ver',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(109, 130, 153, 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestoranBelgeleriSayfasi(
                          targetRestoranAdi: restoranGlobal,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    fixedSize: Size(250, 100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book,
                        size: 30,
                        color: Color.fromRGBO(109, 130, 153, 1.0),
                      ),
                      Text(
                        'İlanlarım',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(109, 130, 153, 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YoneticiLoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    fixedSize: Size(250, 100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        size: 30,
                        color: Color.fromRGBO(109, 130, 153, 1.0),
                      ),
                      Text(
                        'Çıkış Yap',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(109, 130, 153, 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
