import 'package:askidayemek2/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:askidayemek2/firebase_options.dart';
import 'package:askidayemek2/services/auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var usernameGlobal = "";
var restoranGlobal = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
