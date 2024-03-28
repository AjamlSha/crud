import 'package:carousel_slider/carousel_slider.dart';
import 'package:crud/Api.dart';
import 'package:crud/Banner_Page.dart';
import 'package:crud/ColorConst.dart';
import 'package:crud/Home_Page2.dart';
import 'package:crud/Login_Singup.dart';
import 'package:crud/Profile.dart';
import 'package:crud/imageconst.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home_Page1 extends StatefulWidget {
  const Home_Page1({super.key});

  @override
  State<Home_Page1> createState() => _Home_Page1State();
}

class _Home_Page1State extends State<Home_Page1> {
  var a;
  call() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    a= prefs.get("name");
  }
  @override
  void initState() {
    call();
    // TODO: implement initState
    super.initState();
    }
    int initialindex = 0;

    List images = [
      {
        "image": ImageConst.homepage1,
        "image": ImageConst.homepage1,
        "image": ImageConst.homepage1,
      },
      {
        "image": ImageConst.homepage1,
        "image": ImageConst.homepage1,
        "image": ImageConst.homepage1,
      },
      {
        "image": ImageConst.homepage1,
        "image": ImageConst.homepage1,
        "image": ImageConst.homepage1,
      }
    ];
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: ColorConst.white,
            title: Text(
              "Hello, $a",
              style:
              TextStyle(color: ColorConst.Black, fontWeight: FontWeight.w600),
            ),
            actions: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Profile(),
                            ));
                      },
                      child: Image.asset(
                          ImageConst.profilepic, width: w * 0.12)),
                  SizedBox(width: w * 0.03),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login_Singup(),
                            ));
                        setState(() {});
                      },
                      child: SvgPicture.asset(ImageConst.logout))
                ],
              )
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: w * 0.05),
                child: CarouselSlider(
                  items: List.generate(
                    images.length,
                        (index) =>
                        Container(
                            height: w * 0.5,
                            width: w * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.red,

                              borderRadius: BorderRadius.circular(w * 0.04),

                              // boxShadow: [
                              //   BoxShadow(
                              //     blurStyle: BlurStyle.normal,
                              //     color: Colors.black.withOpacity(0.15),
                              //     offset: Offset(0, 4),
                              //     spreadRadius: 15,
                              //     blurRadius: 15,
                              //   )
                              //
                              // ]
                            ),
                            child: Image(
                              image: AssetImage(images[index]['image']),
                              fit: BoxFit.fill,
                            )),
                  ),
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    onPageChanged: (index, reason) {
                      initialindex = index;
                      setState(() {});
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(w * 0.03),
                child: AnimatedSmoothIndicator(
                  activeIndex: initialindex,
                  count: 3,
                  effect: SlideEffect(
                      dotWidth: w * 0.02,
                      dotHeight: w * 0.02,
                      activeDotColor: ColorConst.Black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home_Page2(),
                          ));
                    },
                    child: Container(
                      height: w * 0.45,
                      width: w * 0.4,
                      decoration: BoxDecoration(
                          color: ColorConst.white,
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.normal,
                              color: Colors.black.withOpacity(0.15),
                              offset: Offset(0, 4),
                              spreadRadius: 15,
                              blurRadius: 15,
                            )
                          ],
                          borderRadius: BorderRadius.circular(w * 0.04)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Image.asset(
                                ImageConst.homepage2,
                                width: w * 0.13,
                              )),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Text(
                            "CRUD",
                            style: TextStyle(fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BannerPage(),
                          ));
                    },
                    child: Stack(children: [
                      Container(
                        height: w * 0.45,
                        width: w * 0.4,
                        decoration: BoxDecoration(
                            color: ColorConst.white,
                            boxShadow: [
                              BoxShadow(
                                blurStyle: BlurStyle.normal,
                                color: Colors.black.withOpacity(0.15),
                                offset: Offset(0, 4),
                                spreadRadius: 15,
                                blurRadius: 15,
                              )
                            ],
                            borderRadius: BorderRadius.circular(w * 0.04)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(children: [
                              Center(
                                  child: Image.asset(
                                    ImageConst.homepage2,
                                    width: w * 0.13,
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: w * 0.08,
                                  left: w * 0.22,
                                ),
                                child: CircleAvatar(
                                  radius: w * 0.04,
                                  backgroundColor: Colors.grey,
                                  child: Center(
                                    child: Icon(
                                      Icons.photo,
                                      color: ColorConst.white,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Cloud Storage",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey),
                                ),
                                Text(
                                  "for firebase",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(w * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Api(),
                            ));
                      },
                      child: Container(
                        height: w * 0.45,
                        width: w * 0.4,
                        decoration: BoxDecoration(
                            color: ColorConst.white,
                            boxShadow: [
                              BoxShadow(
                                blurStyle: BlurStyle.normal,
                                color: Colors.black.withOpacity(0.15),
                                offset: Offset(0, 4),
                                spreadRadius: 15,
                                blurRadius: 15,
                              )
                            ],
                            borderRadius: BorderRadius.circular(w * 0.04)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Image.asset(
                                  ImageConst.homepage4,
                                  width: w * 0.25,
                                )),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Text(
                              "API ",
                              style: TextStyle(fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ));
    }
  }
