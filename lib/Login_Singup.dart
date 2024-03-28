import 'package:crud/ColorConst.dart';
import 'package:crud/Login_Login.dart';
import 'package:crud/Sing_up.dart';
import 'package:crud/imageconst.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';

class Login_Singup extends StatefulWidget {
  const Login_Singup({super.key});

  @override
  State<Login_Singup> createState() => _Login_SingupState();
}

class _Login_SingupState extends State<Login_Singup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset(ImageConst.loginscreening)
              ],
            ),
            Column(
              children: [
                Text("CRUD",style: TextStyle(fontWeight: FontWeight.w600,color: ColorConst.PrimaryColor,fontSize: w*0.06),),
                Text("Create, Read, Update ,Delete",style: TextStyle(color: ColorConst.PrimaryColor),),
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Login(),));
                    setState(() {

                    });
                  }, child: Container(
                  height: w* 0.10,
                  width: w* 0.6,
                  decoration: BoxDecoration(
                    color: ColorConst.PrimaryColor,
                    borderRadius: BorderRadius.circular(w* 0.3),
                  ),
                  child: Center(
                    child: Text("Login",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w800)),
                  ),
                ),
                ),
                SizedBox(height: w*0.040),
                InkWell(onTap:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Sing_up(),
                  )
                  );
                  setState(() {

                  });
                } ,
                  child: Container(
                    height: w* 0.10,
                    width: w* 0.6,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConst.PrimaryColor,width: w*0.003),
                      borderRadius: BorderRadius.circular(w* 0.3),

                    ),
                    child: Center(
                      child: Text("Sign up",style: TextStyle(color:ColorConst.PrimaryColor,fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );;
  }
}
