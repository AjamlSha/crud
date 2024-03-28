import 'package:crud/SplashScreen.dart';
import 'package:crud/firebase_options.dart';
import 'package:crud/food_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

var w;
var h;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(Crud());
}

class Crud extends StatefulWidget {
  const Crud({super.key});

  @override
  State<Crud> createState() => _CrudState();
}

class _CrudState extends State<Crud> {
  @override
  Widget build(BuildContext context) {
    w=MediaQuery.of(context).size.width;
    h=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Food_Page(),
        //theme: ThemeData(),
      ),
    );

  }
}