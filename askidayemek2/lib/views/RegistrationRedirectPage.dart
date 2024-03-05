import 'package:askidayemek2/views/login_page.dart';
import 'package:askidayemek2/views/yoneticilogin.dart';
import 'package:flutter/material.dart';

class RegistrationRedirectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(175, 200, 173, 1.0),
              Color.fromRGBO(79, 111, 82, 1.0)
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/foodicon2.jpg',
                width: 400,
                height: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      ),
                      child: Column(children: [
                        Icon(
                          Icons.person_sharp,
                          size: 30,
                          color: Color.fromRGBO(109, 130, 153, 1.0),
                        ),
                        Text(
                          'Kullanıcı Girişi',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(109, 130, 153, 1.0)),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => YoneticiLoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      ),
                      child: Column(children: [
                        Icon(Icons.admin_panel_settings,
                            size: 30,
                            color: Color.fromRGBO(109, 130, 153, 1.0)),
                        Text(
                          'Restoran Girişi',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(109, 130, 153, 1.0)),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
