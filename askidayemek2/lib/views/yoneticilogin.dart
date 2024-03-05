import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:askidayemek2/main.dart';
import 'package:askidayemek2/views/HomePage.dart';

import 'package:askidayemek2/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:askidayemek2/views/yoneticiregister.dart';

class YoneticiLoginPage extends StatelessWidget {
  YoneticiLoginPage({super.key});

  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController restoranCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(205, 193, 197, 1.0),
              Color.fromRGBO(139, 131, 134, 1.0)
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text("Kullanıcı Adı"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: usernameCtrl,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text("Şifre"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: passwordCtrl,
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text("Restoran Adı"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: restoranCtrl,
                  ),
                ),
                button(
                  child: Text("Giriş"),
                  color: Color.fromRGBO(209, 209, 209, 1.0),
                  onPressed: () async {
                    var response = await FirebaseFirestore.instance
                        .collection("Users")
                        .where("username", isEqualTo: usernameCtrl.text)
                        .where("password", isEqualTo: passwordCtrl.text)
                        .where("restoran", isEqualTo: restoranCtrl.text)
                        .where("admin", isEqualTo: true)
                        .limit(1)
                        .get();
                    if (response.docs.isNotEmpty) {
                      usernameGlobal = usernameCtrl.text;
                      restoranGlobal = restoranCtrl.text;
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Hata"),
                            content: Text(
                                "Kullanıcı Adı Ya da şifre hatalı tekrar deneyin."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Tamam"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => yoneticiRegisterPage(
                                  usernameCtrl: usernameCtrl,
                                  passwordCtrl: passwordCtrl,
                                  emailCtrl: TextEditingController(),
                                  phoneCtrl: phoneCtrl,
                                  restoranCtrl: TextEditingController(),
                                  action: Actions2.register,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Hesabınız yok mu ?? Buraya tıkla.",
                      style: TextStyle(fontSize: 15),
                    ),
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
