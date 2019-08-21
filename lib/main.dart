import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin{
  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
  String message = "";
  final msg = TextEditingController();
  Color uidc;

  RegExp uidvalidation = RegExp(r"^[a-z0-9_]{1,24}$", caseSensitive: false);
  int idlength = 16;
  Color countc = Color(0xff009e12);

  AnimationController _animationController;

  var genderSelect;
  @override
  void initState() {
    super.initState();
    genderSelect = 0;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 500),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _animationController.addListener(() {
      setState(() {});
    });
  }

  getGender(int val) {
    setState(() {
      genderSelect = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    ontapup(TapUpDetails details) {
      _animationController.reverse();
      if (idlength < 0) {
        setState(() {
          uidc = Colors.red;
          message = "! Username Should not increase 16 characters";
        });
      } else if (uidvalidation.hasMatch(msg.text) == false) {
        setState(() {
          uidc = Colors.red;
          message = "Cannot have White Spaces & special Characters Except '_' ";
        });
      } else {
        Scaffold.of(context).showSnackBar(snackBar);
      }
    }

    ontapdown(TapDownDetails details) {
      _animationController.forward();
    }
ontapcancel(){
      _animationController.reverse();
}
    double scrnH = MediaQuery.of(context).size.height;
    double scrnW = MediaQuery.of(context).size.width;

    var scale = 1 + _animationController.value;

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.purple,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Icon(Icons.arrow_back),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Literata',
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: scrnH/1.2,
                      width: scrnW/1.2,
                      color: Colors.transparent,
                    ),
                    Container(
                      height: scrnH/1.5,
                      width: scrnW/1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                          boxShadow: [
                            BoxShadow(blurRadius: 10, color: Colors.grey)
                          ]
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        height: scrnH/6,
                        width: scrnH/6,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                          image: DecorationImage(image: AssetImage('images/bean.jpg'),
                              fit: BoxFit.cover),
                            boxShadow: [
                                  BoxShadow(blurRadius: 10, color: Colors.grey)
                                ]
                        ),

                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Transform.scale(
                              scale: scale,
                              child: Container(
                                height: scrnH/7.5,
                                width: scrnH/7.5,
                                decoration: BoxDecoration(
                                  color: Colors.deepOrangeAccent,
                                  shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 6
                                    ),
                                    boxShadow: [BoxShadow(blurRadius: 6, color: Colors.brown)
                                  ]
                                ),
                                alignment: Alignment.center,
                                child: Text('Go', style: TextStyle(fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),),
                              ),
                            ),
                            onTapCancel: ontapcancel,
                            onTapUp: ontapup,
                            onTapDown: ontapdown,
                          ),
                          SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: scrnH/2.1,
                      width: scrnW/1.5,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10,),
                          Text('Welcome! Mr. Bean', style: TextStyle(fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Literata'),),
                                                  SizedBox(height: 35,),
                                                  Text(
                                'Create a Username',
                                style: TextStyle(
                                    fontFamily: 'Literata',
                                    fontWeight: FontWeight.w600),
                              ),
                          SizedBox(height: 15,),
                          Container(
                                height: 40,
                                width: scrnW / 2,
                                child: Stack(
                                  children: <Widget>[
                                    TextField(
                                      controller: msg,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 16),
                                      cursorColor: Colors.deepOrange,
                                      decoration: InputDecoration(
                                        hintText: '@username',
                                        contentPadding: EdgeInsets.only(
                                            left: 4, bottom: 8, top: 8, right: 20),
                                      ),
                                      onChanged: (String str) {
                                        setState(() {
                                          if (str == "") {
                                            message = "";
                                          } else if (uidvalidation.hasMatch(str)) {
                                            message = "";
                                            uidc = Color(0xff32CD32);
                                          } else {
                                            message =
                                            "Cannot have White Spaces & special Characters Except '_' ";
                                            uidc = Color(0xffFF4500);
                                          }
                                          idlength = 16 - str.length;
                                          if (idlength < 0) {
                                            countc = Color(0xffff4000);
                                          } else if (idlength >= 0) {
                                            countc = Color(0xff009e12);
                                          }
                                        });
                                      },
                                    ),

                                    Positioned(
                                      right: 2,
                                      bottom: 8,
                                      child: Text(
                                        '$idlength',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Literata',
                                          color: countc,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            alignment: Alignment.center,
                            width: scrnW / 2,
                            child: Text(
                              message,
                              style: TextStyle(fontSize: 12, color: uidc),
                            ),
                          ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Your Gender: ',
                              style: TextStyle(
                                  fontFamily: 'Literata',
                                  fontWeight: FontWeight.w600),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 1,
                                      groupValue: genderSelect,
                                      onChanged: (val) {
                                        getGender(val);
                                      },
                                    ),
                                    Text('Female',
                                        style: TextStyle(
                                            fontFamily: 'Literata',
                                            fontWeight: FontWeight.w600))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 2,
                                      groupValue: genderSelect,
                                      onChanged: (val) {
                                        getGender(val);
                                      },
                                    ),
                                    Text('Male',
                                        style: TextStyle(
                                            fontFamily: 'Literata',
                                            fontWeight: FontWeight.w600)),
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),


//          child: Container(
//            alignment: Alignment.center,
//            child: Container(
//              height: scrnH,
//              width: scrnW,
//              child: Stack(
//                alignment: Alignment.center,
//                children: <Widget>[
//                  Container(
//                    height: scrnH /1.5,
//                    width: scrnW / 1.2,
//                    decoration: BoxDecoration(
//                        gradient: LinearGradient(
//                          begin: Alignment.topCenter,
//                          end: Alignment.bottomCenter,
//                          colors: [Colors.white, Colors.grey.shade300]
//                        ),
//                        borderRadius: BorderRadius.only(
//                            topRight: Radius.circular(50),
//                            bottomLeft: Radius.circular(50)),
//                        boxShadow: [
//                          BoxShadow(
//                            blurRadius: 10,
//                            color: Colors.grey,
//                          )
//                        ]),
//                  ),
//                  Positioned(
//                    top: scrnH / 12,
//                    right: scrnH / 7,
//                    child: Text(
//                      'Welcome, Mr. Bean!',
//                      style: TextStyle(
//                          fontSize: 20,
//                          fontFamily: 'Literata',
//                          fontWeight: FontWeight.bold),
//                    ),
//                  ),
//                  Positioned(
//                    top: scrnH / 6,
//                    child: Column(
//                      children: <Widget>[
//                        Text(
//                          'Create a Username',
//                          style: TextStyle(
//                              fontFamily: 'Literata',
//                              fontWeight: FontWeight.w600),
//                        ),
//                        Container(
//                          height: 40,
//                          width: scrnW / 2,
//                          margin: EdgeInsets.only(top: 20),
//                          child: Stack(
//                            children: <Widget>[
//                              TextField(
//                                controller: msg,
//                                textAlign: TextAlign.left,
//                                style: TextStyle(fontSize: 16),
//                                cursorColor: Colors.deepOrange,
//                                decoration: InputDecoration(
//                                  hintText: '@username',
//                                  contentPadding: EdgeInsets.only(
//                                      left: 4, bottom: 8, top: 8, right: 20),
//                                ),
//                                onChanged: (String str) {
//                                  setState(() {
//                                    if (str == "") {
//                                      message = "";
//                                    } else if (uidvalidation.hasMatch(str)) {
//                                      message = "";
//                                      uidc = Color(0xff32CD32);
//                                    } else {
//                                      message =
//                                      "Cannot have White Spaces & special Characters Except '_' ";
//                                      uidc = Color(0xffFF4500);
//                                    }
//                                    idlength = 16 - str.length;
//                                    if (idlength < 0) {
//                                      countc = Color(0xffff4000);
//                                    } else if (idlength >= 0) {
//                                      countc = Color(0xff009e12);
//                                    }
//                                  });
//                                },
//                              ),
//                              Positioned(
//                                right: 2,
//                                bottom: 8,
//                                child: Text(
//                                  '$idlength',
//                                  style: TextStyle(
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.bold,
//                                    fontFamily: 'Literata',
//                                    color: countc,
//                                  ),
//                                ),
//                              )
//                            ],
//                          ),
//                        ),
//                        Container(
//                          alignment: Alignment.center,
//                          width: scrnW / 1.5,
//                          child: Text(
//                            message,
//                            style: TextStyle(fontSize: 12, color: uidc),
//                          ),
//                        ),
//                        Row(
//                          children: <Widget>[
//                            Text(
//                              'Your Gender: ',
//                              style: TextStyle(
//                                  fontFamily: 'Literata',
//                                  fontWeight: FontWeight.w600),
//                            ),
//                            Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Row(
//                                  children: <Widget>[
//                                    Radio(
//                                      value: 1,
//                                      groupValue: genderSelect,
//                                      onChanged: (val) {
//                                        getGender(val);
//                                      },
//                                    ),
//                                    Text('Female',
//                                        style: TextStyle(
//                                            fontFamily: 'Literata',
//                                            fontWeight: FontWeight.w600))
//                                  ],
//                                ),
//                                Row(
//                                  children: <Widget>[
//                                    Radio(
//                                      value: 2,
//                                      groupValue: genderSelect,
//                                      onChanged: (val) {
//                                        getGender(val);
//                                      },
//                                    ),
//                                    Text('Male',
//                                        style: TextStyle(
//                                            fontFamily: 'Literata',
//                                            fontWeight: FontWeight.w600)),
//                                  ],
//                                )
//                              ],
//                            )
//                          ],
//                        )
//                      ],
//                    ),
//                  ),
//                  /*************************Profile Image**************************/
//                  Positioned(
//                    top: 0,
//                    child: Container(
//                      height: scrnW / 3.5,
//                      width: scrnW / 3.5,
//                      decoration: BoxDecoration(
//                          color: Colors.yellow,
//                          shape: BoxShape.circle,
//                          image: DecorationImage(
//                            image: AssetImage(
//                                'images/bean.jpg'
//                            ),
//                            fit: BoxFit.cover
//                          ),
//                          boxShadow: [
//                            BoxShadow(blurRadius: 10, color: Colors.grey)
//                          ]),
//                    ),
//                  ),
//                  Positioned(
//                    bottom: 0,
//                    child: GestureDetector(
//                      onTapUp: ontapup,
//                      onTapDown: ontapdown,
//                      onTapCancel: ontapcancel,
//                      child: Transform.scale(
//                        scale: scale,
//                        child: Container(
//                          padding: EdgeInsets.only(bottom: 4),
//                          alignment: Alignment.center,
//                          height: scrnW / 5,
//                          width: scrnW / 5,
//                          decoration: BoxDecoration(
//                              color: Colors.deepOrange,
//                              shape: BoxShape.circle,
//                              boxShadow: [
//                                BoxShadow(blurRadius: 6, color: Colors.brown)
//                              ]),
//                          child: Text(
//                            'GO',
//                            style: TextStyle(
//                                fontSize: 26,
//                                fontFamily: 'Literata',
//                                fontWeight: FontWeight.bold,
//                                color: Colors.white),
//                          ),
//                        ),
//                      ),
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ),
          ),
        ),
      ),
    );
  }
}
