import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/ColorConst.dart';
import 'package:crud/imageconst.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

class Food_Page extends StatefulWidget {
  const Food_Page({super.key});

  @override
  State<Food_Page> createState() => _Food_PageState();
}


List a = [
  {
    "list1": ImageConst.momos,
    "list2": "momos",
    "list3": ImageConst.fourstar,
    "list4": 150,
    "Qty": 0,
  },
  {
    "list1": ImageConst.shawaya,
    "list2": "shawaya",
    "list3": ImageConst.fourstar,
    "list4": 150,
    "Qty": 0,
  },
  {
    "list1": ImageConst.shawarma,
    "list2": "shawarma",
    "list3": ImageConst.fourstar,
    "list4": 150,
    "Qty": 0,
  },
  {
    "list1": ImageConst.burger,
    "list2": "burger",
    "list3": ImageConst.fourstar,
    "list4": 150,
    "Qty": 0,
  }
];
int total = 0;

class _Food_PageState extends State<Food_Page> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? getCollection;
  int total=0;

  getdata() async {
    await
    FirebaseFirestore.instance.collection("foods").snapshots().listen((event) {
      getCollection = event.docs;
      print(event.docs);
      total=0;
      for (int i = 0; i < getCollection!.length; i++) {
        total = getCollection![i]["Qty"] * getCollection![i]["list4"] + total;
        setState(() {});
      }
    });

  }

  adddata() {
    for (var data in a) {
      FirebaseFirestore.instance.collection("foods").add(data);
    }
  }

  @override
  void initState() {
    getdata();
    // adddata();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: ColorConst.white,
        title: Text(
          "Food Order",
          style: TextStyle(
              color: ColorConst.Black,
              fontSize: w * 0.08,
              fontWeight: FontWeight.w800),
        ),
        actions: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(w * 0.03),
                child: Text(
                  "Total Price:₹ $total",
                  style: TextStyle(color: Colors.green, fontSize: w * 0.07),
                ),
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(w * 0.04),
          child: Column(
            children: [
              Text(
                "Itmes",
                style: TextStyle(
                    color: ColorConst.Black,
                    fontSize: w * 0.08,
                    fontWeight: FontWeight.w600),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("foods").snapshots(),
                builder: (context, snapshot) {
                  var data=snapshot.data!.docs;
                  return Container(
                      height: w * 2,
                      width: w * 1,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  height: w * 0.35,
                                  width: w * 1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: w * 0.30,
                                        width: w * 0.30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(w * 0.03),
                                            image: DecorationImage(
                                                image:
                                                AssetImage(data![index]["list1"]),
                                                fit: BoxFit.fill)),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            data![index]["list2"],
                                            style: TextStyle(
                                                fontSize: w * 0.05,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  child: Image(
                                                    image:
                                                    AssetImage(data![index]["list3"]),
                                                    height: w * 0.12,
                                                  )),
                                              Text(
                                                data![index]["list4"].toString(),
                                                style: TextStyle(
                                                    fontSize: w * 0.05,
                                                    fontWeight: FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      data![index]["Qty"] != 0
                                          ? Container(
                                        height: w * 0.13,
                                        width: w * 0.25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(w * 0.03),
                                          color: Colors.black,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                FirebaseFirestore.instance.collection("foods").
                                                doc(data![index].id).update({
                                                  "Qty": data![index]["Qty"]-1
                                                });
                                                setState(() {});
                                              },
                                              child: CircleAvatar(
                                                radius: w * 0.04,
                                                backgroundColor: Colors.grey,
                                                child: Icon(Icons.remove),
                                              ),
                                            ),
                                            Text(
                                              data![index]["Qty"].toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                FirebaseFirestore.instance.collection("foods").
                                                doc(data![index].id).update({
                                                  "Qty": data![index]["Qty"]+1
                                                });
                                                setState(() {});
                                              },
                                              child: CircleAvatar(
                                                radius: w * 0.04,
                                                backgroundColor: Colors.grey,
                                                child: Icon(Icons.add),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                          : InkWell(
                                        onTap: () {
                                          FirebaseFirestore.instance.collection("foods").
                                          doc(data![index].id).update({
                                            "Qty": data![index]["Qty"]+1
                                          });
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: w * 0.13,
                                          width: w * 0.25,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                w * 0.03),
                                            color: Colors.black,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Add Item",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: w * 0.03,
                            );
                          },
                          itemCount: data!.length));
                },

              )
            ],
          ),
        ),
      ),
      backgroundColor: ColorConst.white,
    ));
  }
}
