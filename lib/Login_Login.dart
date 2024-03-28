import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/ColorConst.dart';
import 'package:crud/Home_Page1.dart';
import 'package:crud/Phone.dart';
import 'package:crud/Sing_up.dart';
import 'package:crud/google_sing_in.dart';
import 'package:crud/imageconst.dart';
import 'package:crud/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_Login extends StatefulWidget {
  const Login_Login({super.key});

  @override
  State<Login_Login> createState() => _Login_LoginState();
}

class _Login_LoginState extends State<Login_Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  googleSignInFunction() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    var userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    User? user= userCredential.user;

    print(user!.email);
    print(user!.displayName);
    print(user!.photoURL);

    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => Home_Page1(),));

  }

  Future<User?> _handleSignIn() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential authResult = await _auth.signInWithCredential(credential);
      User? user = authResult.user;

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  void _handleSignOut() async {
    await googleSignIn.signOut();
    print("User signed out");
  }

  get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", username.text);
  }

  // final validatePassword= RegExp(r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{8,}$');
  TextEditingController username = TextEditingController();
  bool a = true;
  bool b = false;
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SafeArea(
              child: Column(children: [
            Padding(
              padding: EdgeInsets.all(w * 0.03),
              child: Row(
                children: [
                  Text(
                    "CRUD",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: w * 0.05),
                  ),
                ],
              ),
            ),
            Column(
              children: [Image.asset(ImageConst.loginscreen2)],
            ),
            Padding(
              padding: EdgeInsets.all(w * 0.03),
              child: Column(children: [
                TextFormField(
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   if (emailValidation.hasMatch(value!)) {
                  //     return null;
                  //   } else {
                  //     return "Enter a Valid Email";
                  //   }
                  // },
                  controller: username,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text("Username",
                        style: TextStyle(color: ColorConst.Black)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.04),
                        borderSide: BorderSide(
                          color: ColorConst.PrimaryColor,
                        )),
                    hintText: ("username"),
                  ),
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   if(validatePassword.hasMatch(value!)){
                  //     return null;
                  //   }
                  //   else{
                  //     return "Password must contain \n1 Uppercase\n1 Lowercase\n1 Number\n1 Special character";
                  //   }
                  // },
                  controller: password,

                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          a = !a;
                          setState(() {});
                        },
                        child: Icon(a
                            ? Icons.visibility_off_sharp
                            : Icons.remove_red_eye_rounded)),
                    label: Text("Password"),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.04),
                        borderSide: BorderSide(
                          color: ColorConst.PrimaryColor,
                        )),
                    hintText: ("Type"),
                  ),
                  obscureText: a,
                  obscuringCharacter: "*",
                ),
              ]),
            ),
            SizedBox(
              height: w * 0.10,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () async {
                    get();

                    var data = await FirebaseFirestore.instance
                        .collection('users')
                        .where('email', isEqualTo: username.text)
                        .get();
                    print(data.docs);
                    if (data.docs.isNotEmpty) {
                      if (data.docs[0]["password"] == password.text) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home_Page1(),
                            ),
                            (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Passwords do not match")));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("No account found")));
                    }

                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home_Page1(),), (route) => false);
                  },
                  child: Container(
                    height: w * 0.13,
                    width: w * 0.7,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(w * 0.06),
                        border: Border.all(color: ColorConst.PrimaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.lock_outline_rounded),
                        Text(
                          "login",
                          style: TextStyle(
                              color: ColorConst.PrimaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: w * 0.04,
                ),
                InkWell(

                  onTap: () async {
                    googleSignInFunction();

                    // User? user = await _handleSignIn();
                    // if (user != null) {
                    //   print("Signed in: ${user.displayName}");
                    // }
                  },
                  child:
                Container(

                  height: w * 0.13,
                  width: w * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(w * 0.06),
                      border: Border.all(color: ColorConst.PrimaryColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(ImageConst.Googleimage),
                      Text(
                        " Sign in with Google",
                        style: TextStyle(
                            color: ColorConst.PrimaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                ),
                SizedBox(
                  height: w * 0.04,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Phone(),
                        ));
                    setState(() {});
                  },
                  child: Container(
                    height: w * 0.13,
                    width: w * 0.7,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(w * 0.06),
                        border: Border.all(color: ColorConst.PrimaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.call_outlined),
                        Text(
                          "OTP sign in",
                          style: TextStyle(
                              color: ColorConst.PrimaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
               ],
            ),
            SizedBox(height: w * 0.20),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Sing_up(),
                    ));
              },
              child: Container(
                height: w * 0.06,
                width: w * 0.70,
                //color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account ?",
                      style: TextStyle(color: ColorConst.PrimaryColor),
                    ),
                    Text(
                      "Create Now",
                      style: TextStyle(
                          color: ColorConst.PrimaryColor,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            )
          ]))),
    );
  }
}
