import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/Add_User.dart';
import 'package:crud/ColorConst.dart';
import 'package:crud/Edit_User.dart';
import 'package:crud/Login_Singup.dart';
import 'package:crud/get_page.dart';
import 'package:crud/imageconst.dart';
import 'package:crud/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Home_Page2 extends StatefulWidget {
  const Home_Page2({super.key});

  @override
  State<Home_Page2> createState() => _Home_Page2State();
}

class _Home_Page2State extends State<Home_Page2> {
  // List home = [
  //   {
  //     "image":ImageConst.boy,
  //     "text":"Albert Flores",
  //     "text1":"1901 Thornridge Cir. Shiloh, Hawaii",
  //     "icon":ImageConst.editpen,
  //     "icon1":ImageConst.delete
  //   },
  //   {
  //     "image":ImageConst.boy,
  //     "text":"Albert Flores",
  //     "text1":"1901 Thornridge Cir. Shiloh, Hawaii",
  //     "icon":ImageConst.editpen,
  //     "icon1":ImageConst.delete
  //   },
  //   {
  //     "image":ImageConst.boy,
  //     "text":"Albert Flores",
  //     "text1":"1901 Thornridge Cir. Shiloh, Hawaii",
  //     "icon":ImageConst.editpen,
  //     "icon1":ImageConst.delete
  //   },
  //   {
  //     "image":ImageConst.boy,
  //     "text":"Albert Flores",
  //     "text1":"1901 Thornridge Cir. Shiloh, Hawaii",
  //     "icon":ImageConst.editpen,
  //     "icon1":ImageConst.delete
  //   },
  //   {
  //     "image":ImageConst.boy,
  //     "text":"Albert Flores",
  //     "text1":"1901 Thornridge Cir. Shiloh, Hawaii",
  //     "icon":ImageConst.editpen,
  //     "icon1":ImageConst.delete
  //
  //   },
  //   {
  //     "image":ImageConst.boy,
  //     "text":"Albert Flores",
  //     "text1":"1901 Thornridge Cir. Shiloh, Hawaii",
  //     "icon":ImageConst.editpen,
  //     "icon1":ImageConst.delete
  //
  //   },
  //   {
  //     "image":ImageConst.boy,
  //     "text":"Albert Flores",
  //     "text1":"1901 Thornridge Cir. Shiloh, Hawaii",
  //     "icon":ImageConst.editpen,
  //     "icon1":ImageConst.delete
  //   },
  //   {
  //     "image":ImageConst.boy,
  //     "text":"Albert Flores",
  //     "text1":"1901 Thornridge Cir. Shiloh, Hawaii",
  //     "icon":ImageConst.editpen,
  //     "icon1":ImageConst.delete
  //   },
  //
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 1,
        backgroundColor: ColorConst.white,
        title: Text(
          "Hello, User",
          style: TextStyle(color: ColorConst.Black,fontWeight: FontWeight.w600),
        ),
        actions: [
          Row(
            children: [
              Image.asset(ImageConst.profilepic,width: w*0.12),
              SizedBox(width: w*0.03),
              InkWell(
                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Singup(),));
                    setState(() {

                    });
                  },child: SvgPicture.asset(ImageConst.logout))

            ],
          )
        ],

      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Add_User(),));
        },
        child: CircleAvatar(
            backgroundColor: ColorConst.PrimaryColor,
            radius: 35,
            child: Icon(Icons.add,color: Colors.white,size: w*0.08,)
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(w * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Current Users",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: w * 0.05),
                  ),
                ],
              ),
            ),
            StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
                stream: FirebaseFirestore.instance.collection("users").doc("ajmalajuu323@gmail.com").snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }
                  var data=snapshot.data!.data();
                  return Column(
                    children: [
                      Text(data!["name"]),
                      Text(data["email"]),
                    ],
                  );
                },
            ),
            Container(
              height: w*2.2,
              width: w*1,
              child: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                stream: FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }
                  var data=snapshot.data!.docs;
                  return ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(padding: EdgeInsets.all(w*0.03),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => get_page(id: data[index].id,),));
                            },
                            child: Container(
                              height: w*0.2,
                              width: w*0.33,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(w*0.04),
                                  color: ColorConst.lightGrey
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: w*0.08,
                                  backgroundImage: NetworkImage(data[index]["image"]),
                                ),
                                title: Row(
                                  children: [
                                    Text(data[index]["name"],
                                      style: TextStyle(fontSize: w*0.03,
                                          fontWeight: FontWeight.w600
                                      ),
                                    )
                                  ],
                                ),
                                subtitle: Row( mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(data[index]["email"],style: TextStyle(fontSize: w*0.03),)
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          showCupertinoModalPopup(context: context, builder: (context) {
                                            return CupertinoAlertDialog(
                                              title: Text("Are you Sure\nYou Want to delete User ?"),
                                              actions: [
                                                Column(
                                                  children: [
                                                    CupertinoDialogAction(child: Text("yes",style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.red),)),
                                                    Divider(),
                                                    CupertinoDialogAction(child: Text("Cancel"),onPressed: (){
                                                      Navigator.pop(context);
                                                      setState(() {

                                                      });
                                                    }),
                                                  ],
                                                )
                                              ],
                                            );
                                          },);
                                        },
                                        child: SvgPicture.asset(ImageConst.delete)),
                                    SizedBox(width: w*0.02,),
                                    InkWell(onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>EditUser(
                                          userId: data[index]["email"],
                                          name: data[index]["name"],
                                          email: data[index]["email"],
                                          password: data[index]["password"],
                                          image:data[index]['image']
                                        ),));
                                      setState(() {

                                      });
                                    },child: SvgPicture.asset(ImageConst.editpen,width: w*0.05,))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: w*0.0001,
                        );
                      },
                      itemCount: data.length);
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
