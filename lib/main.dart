import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [
    SystemUiOverlay.bottom
  ]);
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentindex = 0;

  PageController pageController = PageController();

  List<String> image_list = [
    "assets/image1.jpg",
    "assets/image2.jpg",
    "assets/image3.jpg",
  ];
  List<String> orange_text = [
    "Elevate Your Gaming Experience",
    "Get Updates on Latest Gaming News ",
    "Connect&Contest!",
  ];
  late OverlayEntry overlayEntry;
  @override
  void initState() {
    super.initState();
    overlayEntry = OverlayEntry(
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Scaffold(
            backgroundColor: Colors.black26,
            body: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withOpacity(.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                    )
                  ],
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notice",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "By continuing, you agree the terms and you can join any time.",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            SnackBar snackbar = SnackBar(
                              showCloseIcon: true,
                              content: Text(textAlign: TextAlign.center,
                                "You agreed Terms",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.deepOrange,
                              behavior: SnackBarBehavior.floating,
                              closeIconColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                            overlayEntry.remove();
                          },
                          child: Text(
                            "Agree",
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                        SizedBox(width: 20),
                        TextButton(
                          onPressed: () {
                            overlayEntry.remove();
                          },
                          child: Text(
                            "Decline",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizescreen = MediaQuery.sizeOf(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView.builder(
          itemBuilder: (context, value) {
            return Stack(
              children: [
                Container(
                  height: sizescreen.height,
                  width: sizescreen.width,
                  child: Image(
                    image: AssetImage(image_list[currentindex]),
                    fit: BoxFit.cover,
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Positioned.fill(
                    child: CustomPaint(
                      painter: Customshape(),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                orange_text[currentindex],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            // Subtitle
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: ShaderMask(
                                shaderCallback: (bounds) {
                                  return LinearGradient(
                                          colors: [Colors.red, Colors.green])
                                      .createShader(bounds);
                                },
                                child: Text(
                                  "Level up your gaming experience by using our top-rated services!",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: List.generate(3, (index) {
                                    if (index != currentindex) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.white.withOpacity(.9),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        width: 40,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrange,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      );
                                    }
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:110),
                                  child: Container(
                                    width: 80,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.deepOrange,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (currentindex <
                                              image_list.length - 1) {
                                            currentindex++;
                                            pageController.animateToPage(
                                              currentindex,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.ease,
                                            );
                                          }
                                          else if (currentindex == 2) {
                                            Overlay.of(context)
                                                .insert(overlayEntry);
                                          }
                                        });
                                      },

                                      // if(currentindex==2){
                                      //   AlertDialog alertDialog=AlertDialog(content: Text("Alert"),actions: [TextButton(onPressed: (){}, child: Text("Agree")),TextButton(onPressed: (){}, child:Text("Decline"))],);
                                      //   showDialog(context: context, builder: (context){return alertDialog;});
                                      // }

                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: 3,
          controller: pageController,
          physics: BouncingScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              currentindex = index;
            });
          },
        ),
      ),
    );
  }
}

class Customshape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.moveTo(0, size.height * 0.5);
    path.cubicTo(
      size.width * 0.25,
      size.height * 0.4,
      size.width * 0.75,
      size.height * 0.6,
      size.width,
      size.height * 0.5,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    paint.color = Colors.black;
    paint.style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
