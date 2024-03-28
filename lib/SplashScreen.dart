import 'package:crud/ColorConst.dart';
import 'package:crud/Home_Page1.dart';
import 'package:crud/Login_Singup.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool login=false;
  void initState() {
    Future.delayed(Duration(seconds: 4)).then((value) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login==true?Login_Singup():Home_Page1()), (route) => false);
    });
    // TODO: implement initState

    super.initState();
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: ColorConst.PrimaryColor,
        body: Center(
          child: Text("CRUD", style: TextStyle(color: Colors.white,
              fontSize: w * 0.3,
              fontWeight: FontWeight.w600),
          ),
        ),
      );
    }
  }
