import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:askidayemek2/model/user.dart';
import 'package:askidayemek2/widgets/button.dart';
import 'package:flutter/material.dart';

enum Actions2 { register, update }

class yoneticiRegisterPage extends StatelessWidget {
  const yoneticiRegisterPage(
      {super.key,
      required this.usernameCtrl,
      required this.passwordCtrl,
      required this.emailCtrl,
      required this.phoneCtrl,
      required this.restoranCtrl,
      this.username = "",
      this.action = Actions2.register});

  final TextEditingController usernameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController restoranCtrl;

  final Actions2 action;
  final String username;

  bool _isPasswordValid(String password) {
    if (password.length < 6) {
      return false;
    }

    RegExp hasUpperCase = RegExp(r'[A-Z]');
    RegExp hasDigits = RegExp(r'\d');

    return hasUpperCase.hasMatch(password) && hasDigits.hasMatch(password);
  }

  bool _isEmailValid(String email) {
    if (email.isEmpty || !email.contains("@")) {
      return false;
    }

    List<String> emailParts = email.split("@");

    return emailParts.length == 2 &&
        emailParts.first.isNotEmpty &&
        emailParts.last.isNotEmpty;
  }

  bool _isPhoneValid(String phone) {
    RegExp regex = RegExp(r'^\d{10,11}$');
    return regex.hasMatch(phone);
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hata"),
          content: Text(message),
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
            child: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                      label: Text("Kullanıcı Adı"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: usernameCtrl,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                      label: Text("E-posta"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: emailCtrl,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                      label: Text("Telefon Numarası"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: phoneCtrl,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                      label: Text("Şifre"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
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
                          borderRadius: BorderRadius.circular(20))),
                  controller: restoranCtrl,
                ),
              ),
              button(
                  child: Text("Kayıt Ol"),
                  color: Color.fromRGBO(209, 209, 209, 1.0),
                  onPressed: () async {
                    var admin = UserAdminModel(
                        username: usernameCtrl.text,
                        phone: phoneCtrl.text,
                        email: emailCtrl.text,
                        password: passwordCtrl.text,
                        restoran: restoranCtrl.text);

                    var response = await FirebaseFirestore.instance
                        .collection("Users")
                        .where("username", isEqualTo: usernameCtrl.text)
                        .limit(1)
                        .get();

                    if (response.docs.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Hata"),
                            content: Text("Bu kullanıcı adı zaten var."),
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
                    if (!_isPasswordValid(admin.password)) {
                      _showErrorDialog(context,
                          "Geçersiz şifre. Şifre en az 6 karakter uzunluğunda olmalı, en az bir büyük harf ve bir rakam içermelidir.");
                      return;
                    }
                    if (!_isPhoneValid(admin.phone)) {
                      _showErrorDialog(context, "Geçersiz telefon numarası.");
                      return;
                    }
                    if (!_isEmailValid(admin.email)) {
                      _showErrorDialog(context, "Geçersiz e-posta adresi.");
                      return;
                    }
                    if (admin.username.isEmpty ||
                        admin.email.isEmpty ||
                        admin.password.isEmpty ||
                        admin.phone.isEmpty ||
                        admin.restoran.isEmpty) {
                      _showErrorDialog(
                          context, "Lütfen tüm alanları doldurun.");
                      return;
                    } else {
                      await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(admin.username)
                          .set(admin.toJson());
                      print(action);
                      Navigator.pop(context);
                    }
                  })
            ]),
          ),
        ),
      ),
    );
  }
}
