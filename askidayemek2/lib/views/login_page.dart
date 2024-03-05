import 'package:askidayemek2/views/KullaniciHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:askidayemek2/main.dart';
import 'package:rive/rive.dart' as rive;
import 'package:askidayemek2/views/register_page.dart';
import 'package:askidayemek2/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  var animationLink = 'assets/images/loginbear.riv';
  rive.SMITrigger? failTrigger, successTrigger;
  rive.SMIBool? isHandsUp, isChecking;
  rive.SMINumber? lookNum;
  rive.StateMachineController? stateMachineController;
  rive.Artboard? artboard;

  void initState() {
    rootBundle.load(animationLink).then((value) {
      final file = rive.RiveFile.import(value);
      final art = file.mainArtboard;
      stateMachineController =
          rive.StateMachineController.fromArtboard(art, "Login Machine");

      if (stateMachineController != null) {
        art.addController(stateMachineController!);

        stateMachineController!.inputs.forEach((element) {
          if (element.name == "isChecking") {
            isChecking = element as rive.SMIBool;
          } else if (element.name == "isHandsUp") {
            isHandsUp = element as rive.SMIBool;
          } else if (element.name == "trigSuccess") {
            successTrigger = element as rive.SMITrigger;
          } else if (element.name == "trigFail") {
            failTrigger = element as rive.SMITrigger;
          } else if (element.name == "numLook") {
            lookNum = element as rive.SMINumber;
          }
        });
      }
      setState(() => artboard = art);
    });
    super.initState();
  }

  void lookAround() {
    isChecking?.change(true);
    isHandsUp?.change(false);
    lookNum?.change(0);
  }

  void moveEyes(value) {
    lookNum?.change(value.length.toDouble());
  }

  void handsUpOnEyes() {
    isHandsUp?.change(true);
    isChecking?.change(false);
  }

  void loginClick() {
    isChecking?.change(false);
    isHandsUp?.change(false);

    failTrigger?.fire();

    setState(() {});
  }

  void loginClick1() {
    isChecking?.change(false);
    isHandsUp?.change(false);

    successTrigger?.fire();
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
                if (artboard != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0, top: 0),
                    child: SizedBox(
                      width: 200,
                      height: 300,
                      child: rive.Rive(artboard: artboard!),
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onTap: lookAround,
                          onChanged: moveEyes,
                          decoration: InputDecoration(
                            label: Text("Kullanıcı Adı"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          controller: usernameCtrl,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: TextFormField(
                    onTap: handsUpOnEyes,
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
                  child: Text(
                    "Giriş",
                    style: TextStyle(color: Color.fromRGBO(55, 66, 89, 1.0)),
                  ),
                  color: Color.fromRGBO(209, 209, 209, 1.0),
                  onPressed: () async {
                    var response = await FirebaseFirestore.instance
                        .collection("Users")
                        .where("username", isEqualTo: usernameCtrl.text)
                        .where("password", isEqualTo: passwordCtrl.text)
                        .where("admin", isEqualTo: false)
                        .limit(1)
                        .get();
                    if (response.docs.isNotEmpty) {
                      loginClick1();
                      Future.delayed(Duration(seconds: 1), () {
                        usernameGlobal = usernameCtrl.text;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KullaniciHomePage(),
                          ),
                        );
                      });
                    } else {
                      loginClick();
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
                        builder: (context) => RegisterPage(
                          usernameCtrl: usernameCtrl,
                          passwordCtrl: passwordCtrl,
                          emailCtrl: TextEditingController(),
                          action: Actions1.register,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Hesabınız yok mu ?? Buraya tıkla.",
                      style: TextStyle(
                          fontSize: 15, color: Color.fromRGBO(60, 70, 89, 1.0)),
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
