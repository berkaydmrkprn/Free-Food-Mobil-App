import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:askidayemek2/model/user.dart';
import 'package:askidayemek2/widgets/button.dart';
import 'package:flutter/material.dart';

enum Actions1 { register, update }

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    Key? key,
    required this.usernameCtrl,
    required this.passwordCtrl,
    required this.emailCtrl,
    this.username = "",
    this.action = Actions1.register,
  }) : super(key: key);

  final TextEditingController usernameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;

  final Actions1 action;
  final String username;

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
              Color.fromRGBO(162, 181, 205, 1.0),
              Color.fromRGBO(110, 123, 139, 1.0),
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
                      label: Text("E-posta"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: emailCtrl,
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
                button(
                  child: Text("Kayıt Ol"),
                  color: Color.fromRGBO(209, 209, 209, 1.0),
                  onPressed: () async {
                    var user = UserModel(
                      username: usernameCtrl.text,
                      email: emailCtrl.text,
                      password: passwordCtrl.text,
                    );

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
                    if (user.username.isEmpty ||
                        user.email.isEmpty ||
                        user.password.isEmpty) {
                      _showErrorDialog(
                          context, "Lütfen tüm alanları doldurun.");
                      return;
                    } else {
                      await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(user.username)
                          .set(user.toJson());
                      print(action);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
