import 'package:askidayemek2/views/ilanlar.dart';
import 'package:askidayemek2/views/login_page.dart';
import 'package:askidayemek2/widgets/button.dart';
import 'package:flutter/material.dart';

class KullaniciHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(162, 181, 205, 1.0),
              Color.fromRGBO(110, 123, 139, 1.0),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button(
                color: Color.fromRGBO(209, 209, 209, 1.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ilanlar()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: Color.fromRGBO(55, 66, 89, 1.0),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Yemek İlanlarını Gör',
                      style: TextStyle(
                        color: Color.fromRGBO(55, 66, 89, 1.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              button(
                color: Color.fromRGBO(209, 209, 209, 1.0),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Color.fromRGBO(55, 66, 89, 1.0),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'ÇIKIŞ YAP',
                      style: TextStyle(
                        color: Color.fromRGBO(55, 66, 89, 1.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
