import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shimmer/shimmer.dart';

import 'ApiData.dart';
import 'DataConstants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ZoomDrawerController _drawerController = ZoomDrawerController();
  // final _drawerController = ZoomDrawerController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentBookings();
  }

  currentBookings() async {
    await ApiData().fetchAlbum();
    setState(() {
      Dataconstants.showLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Dataconstants.whiteColor,

        // drawer: const Icon(Icons.menu,color: Colors.red),
        body: ZoomDrawer(
          controller: _drawerController,
          style: DrawerStyle.Style1,
          menuScreen: MenuScreen(),
          mainScreen: Home(
            
           
            zoomController: _drawerController,
          ),
          borderRadius: 5.0,
          showShadow: true,
          shadowLayer2Color: Dataconstants.whiteColor,
       
          shrinkMainScreen: true,
          angle: 0.0,
          backgroundColor: Dataconstants.whiteColor,
          slideWidth: MediaQuery.of(context).size.width * .60,

          openCurve: Curves.fastOutSlowIn,
          closeCurve: Curves.bounceIn,
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  final title;
  final zoomController;
  Home({Key? key, this.title, this.zoomController}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Dataconstants.whiteColor,
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: InkWell(
                  onTap: () {
                    widget.zoomController.toggle();
                  },
                  child: Icon(
                    Icons.menu,
                    color: Dataconstants.pinkColor,
                  )))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Dataconstants.pinkColor)),
                          child: ClipOval(
                              child: Image.asset(
                            "assets/nanny/emily.png",
                            width: 53,
                            fit: BoxFit.fitWidth,
                            height: 53,
                          ))),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                          color: Dataconstants.secondaryTextColor,
                          fontFamily: Dataconstants.fontFamily,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        "Emily Cyrus",
                        style: TextStyle(
                            fontFamily: Dataconstants.fontFamily,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Dataconstants.pinkColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              Stack(
                overflow: Overflow.visible,
                alignment: AlignmentDirectional.topCenter,
                fit: StackFit.loose,
                children: [
                  Container(
                    height: 190,
                    width: 400,
                    child: Padding(
                      padding: EdgeInsets.only(left: 25, top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nanny And \nBabysitting Services",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontFamily: Dataconstants.fontFamily,
                                color: Dataconstants.blueColor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 110,
                            child: Button(
                              buttonText: "Book Now",
                              color: Dataconstants.blueColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Dataconstants.pinkColor),
                        color: Dataconstants.pinkColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Positioned(
                    top: -50,
                    child: Image.asset(
                      "assets/nanny/nanny.png",
                      height: 270,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Text(
                "Your Current Booking",
                style: TextStyle(
                    fontFamily: Dataconstants.fontFamily,
                    color: Dataconstants.blueColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              SizedBox(height: 15),
              Expanded(
                  child: Dataconstants.showLoader
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 100.0,
                          child: Shimmer.fromColors(
                            baseColor: Dataconstants.whiteColor,
                            highlightColor: Dataconstants.pinkColor,
                            child: Card(
                              elevation: 1.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ))
                      : ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext, int index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Dataconstants
                                              .currentBookings['package_label'],
                                          style: TextStyle(
                                              fontFamily:
                                                  Dataconstants.fontFamily,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Dataconstants.pinkColor),
                                        ),
                                        SizedBox(
                                            width: 100,
                                            height: 30,
                                            child: Button(
                                              buttonText: "Start",
                                              color: Dataconstants.pinkColor,
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "From",
                                              style: TextStyle(
                                                  fontFamily:
                                                      Dataconstants.fontFamily,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color:
                                                      Dataconstants.greyColor),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                    "assets/nanny/calender.png"),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${Dataconstants.currentBookings['from_date']}",
                                                  style: TextStyle(
                                                      fontFamily: Dataconstants
                                                          .fontFamily,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Dataconstants
                                                          .greyColor),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                    "assets/nanny/time.png"),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${Dataconstants.currentBookings['from_time']}",
                                                  style: TextStyle(
                                                      fontFamily: Dataconstants
                                                          .fontFamily,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Dataconstants
                                                          .greyColor),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "To",
                                              style: TextStyle(
                                                  fontFamily:
                                                      Dataconstants.fontFamily,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color:
                                                      Dataconstants.greyColor),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                    "assets/nanny/calender.png"),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${Dataconstants.currentBookings['to_date']}",
                                                  style: TextStyle(
                                                      fontFamily: Dataconstants
                                                          .fontFamily,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Dataconstants
                                                          .greyColor),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                    "assets/nanny/time.png"),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${Dataconstants.currentBookings['to_time']}",
                                                  style: TextStyle(
                                                      fontFamily: Dataconstants
                                                          .fontFamily,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Dataconstants
                                                          .greyColor),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: 70,
                                            height: 30,
                                            child: Button(
                                              buttonText: "Rate Us",
                                              color: Dataconstants.blueColor,
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                            width: 100,
                                            height: 30,
                                            child: Button(
                                              buttonText: "Geolocation",
                                              color: Dataconstants.blueColor,
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                            width: 100,
                                            height: 30,
                                            child: Button(
                                              buttonText: "Survilience",
                                              color: Dataconstants.blueColor,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          })),
              SizedBox(
                height: 10,
              ),
              Text(
                "Packages",
                style: TextStyle(
                    fontFamily: Dataconstants.fontFamily,
                    color: Dataconstants.blueColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: 
                  Dataconstants.showLoader?SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 100.0,
                          child: Shimmer.fromColors(
                            baseColor:Dataconstants.pinkColor,
                            highlightColor: Dataconstants.whiteColor,
                            child: Card(
                              elevation: 1.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          )):
                  ListView.builder(
                      itemCount: Dataconstants.packages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              height: 140,
                              width: 400,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 12, top: 12, right: 12),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/nanny/bigCalender (1).png",
                                            color: index.isOdd?Colors.white:Color(0xffD84D90),
                                            width: 24.54,
                                            height: 24.54,
                                          ),
                                          const Spacer(),
                                           SizedBox(
                                            width: 100,
                                            height: 30,
                                            child: Button(
                                              buttonText: "Book Now",
                                              color:index.isOdd?Dataconstants.blueColor:
                                               Color(0xffE36DA6),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${Dataconstants.packages[index]['package_name']}",
                                            style: TextStyle(
                                                fontFamily:
                                                    Dataconstants.fontFamily,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Dataconstants.blueColor),
                                          ),
                                          Text(
                                            "\u{20B9} ${Dataconstants.packages[index]['price']}",
                                            style: TextStyle(
                                                fontFamily:
                                                    Dataconstants.fontFamily,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Dataconstants.blueColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: AutoSizeText(
                                              "${Dataconstants.packages[index]['description']}",
                                              maxLines: 2,
                                              textAlign: TextAlign.justify,
                                              overflow: TextOverflow.ellipsis,
                                              // textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontFamily:
                                                      Dataconstants.fontFamily,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10,
                                                  color:
                                                      Dataconstants.blueColor),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:index.isEven?
                                   Dataconstants.pinkColor:Color(0xff80ABDB)),
                                  color:index.isEven?
                                   Dataconstants.pinkColor:Color(0xff80ABDB),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(
                              height: 14,
                            )
                          ],
                        );
                      }))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Dataconstants.pinkColor,
        // fixedColor:Dataconstants.greyColor,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem( icon: Icon(Icons.home_max_sharp,color: Dataconstants.pinkColor,), label:"Home",backgroundColor: Dataconstants.whiteColor),
          BottomNavigationBarItem(icon: Icon(Icons.mail,color: Dataconstants.pinkColor), label: "Packages",),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: Dataconstants.pinkColor), label:"Message"),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: Dataconstants.pinkColor), label:"Profile"),
        ],),
    );
  }
}

class Button extends StatelessWidget {
  final buttonText;
  final color;
  const Button({Key? key, this.buttonText, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: color)))),
        onPressed: () {},
        child: Text(
          buttonText,
          style: TextStyle(
              fontFamily: Dataconstants.fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 11),
        ));
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 85, left: 77, right: 224),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Dataconstants.pinkColor)),
                  child: Image.asset(
                    "assets/nanny/emily.png",
                    width: 72,
                    fit: BoxFit.fitWidth,
                    height: 72,
                  )),
              Padding(
                padding: EdgeInsets.only(left: 77, right: 226),
                child: Text(
                  "Emily Cyrus",
                  style: TextStyle(
                    color: Dataconstants.pinkColor,
                    fontFamily: Dataconstants.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 38,
          ),
          subItem(title: "Home"),
          subItem(title: "Book A Nanny"),
          subItem(title: "How It Works"),
          subItem(title: "Why Nanny Vanny"),
          subItem(title: "My Booking"),
          subItem(title: "My Profile"),
          subItem(title: "Support")
        ],
      ),
    ));
  }
}

class subItem extends StatelessWidget {
  final title;

  const subItem({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:200),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title,
              style: TextStyle(
                color:Dataconstants.blueColor,
                fontFamily: Dataconstants.fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              )),
          SizedBox(
            height: 14.5,
          ),
          Divider(
            color: Dataconstants.pinkColor,
            indent: 28,
          )
        ],
      ),
    );
  }
}
