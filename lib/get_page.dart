import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/ColorConst.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';

class get_page extends StatefulWidget {
  final String id;
  const get_page({super.key, required this.id});

  @override
  State<get_page> createState() => _get_pageState();
}

class _get_pageState extends State<get_page> {
  List getcollection=[];
  Map<String,dynamic> getdocument={};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    QuerySnapshot<Map<String,dynamic>> getdata= await FirebaseFirestore.instance.collection("users").get();
                    getcollection=getdata.docs;

                    DocumentSnapshot<Map<String,dynamic>> docdata= await FirebaseFirestore.instance.collection("users").doc(widget.id).get();
                    getdocument = docdata.data()!;


                    setState(() {

                    });
                  },
                  child: Container(
                    height: w * 0.12,
                    width: w * 0.3,
                    decoration: BoxDecoration(
                        color: ColorConst.white,
                        borderRadius: BorderRadius.circular(w * 0.06),
                        border: Border.all(
                            color: ColorConst.PrimaryColor, width: w * 0.005)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get",
                          style: TextStyle(
                              color: ColorConst.PrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

              ],

            ),
            Container(
              height: w*0.2,
              width: w*1,
              color: Colors.greenAccent,
              child: Column(
                children: [
                  Text(getdocument["name"]?? ""),
                  Text(getdocument["email"]?? ""),
                ],
              ),
            ),
            Container(
              height: w*1.7,
              width: w*1,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:  EdgeInsets.all(w*0.03,),
                      child: Container(
                          height: w * 0.2,
                          width: w * 0.33,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(w*0.04),
                              color: ColorConst.lightGrey
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getcollection[index]["name"]),
                              Text(getcollection[index]["name"]),

                            ],
                          )
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: w * 0.0001,

                    );
                  },
                  itemCount: getcollection.length),
            ),
          ],
        ),


      )

    );
  }
}
