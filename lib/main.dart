import 'package:BCB/screens/SignInOne.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:BCB/generated/intl/messages_en.dart';



import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:BCB/screens/CreateAccount.dart';
import 'package:BCB/screens/dashboard.dart';
import 'package:BCB/screens/lisd.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: SignInone(),
    );
  }
}

class SignInone extends StatefulWidget {
  const SignInone({Key key}) : super(key: key);

  @override
  _SignInoneState createState() => _SignInoneState();
}

class _SignInoneState extends State<SignInone> {
  String errormsg, otpCode;
  bool error, showprogress;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  startLogin1() async {
    String apiurl =
        'https://getFuel.000webhostapp.com/RoboBank/login.php'; //api url
    print('This is your password ' + passwordController.text);

    var response = await http.post(Uri.parse(apiurl), body: {
      'customer_username': usernameController.text, //get the username text
      'customer_password': passwordController.text //get password text
    });

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["error"]) {
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"];
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: errormsg,
          );
          //usernameController.clear();
          //passwordController.clear();
        });
      } else {
        if (jsondata["success"]) {
          setState(() {
            error = false;
            showprogress = false;
          });

          //save the data returned from server
          //and navigate to home page

          String account_number = jsondata["account_number"];
          String account_balance = jsondata["account_balance"];
          String customer_first_name = jsondata["customer_first_name"];
          String customer_last_name = jsondata["customer_last_name"];
          String account_type = jsondata["account_type"];
          String customer_title = jsondata["customer_title"];
          String customer_created = jsondata["customer_created"];

          print('Login was successful');

          //user shared preference to save data
          //customer_email.clear();
          //password.clear();

          print('Account Type ' + account_type.toString());

          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => DashboardHome(
                account_number: account_number,
                account_balance: account_balance,
                customer_first_name: customer_first_name,
                customer_last_name: customer_last_name,
                account_type: account_type,
                customer_title: customer_title,
                customer_created: customer_created
              )));

          print("Welcome back " +
              customer_first_name +
              '  ' +
              customer_last_name +
              '\nPlease enter OTP you received through your phone number via an SMS');
        } else {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: errormsg,
          );
        }
      }
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: errormsg,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('Assets/image1.png'),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 270),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(18),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[

                  Row(
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: S.of(context).welcome_note,
                              style: TextStyle(
                                  fontFamily: 'SFUIDisplay',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: S.of(context).login,
                              style: TextStyle(
                                  fontFamily: 'SFUIDisplay',
                                  color: Color(0xffff2d55),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ]),
                      ),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        controller: usernameController,
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SFUIDisplay'),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: S.of(context).username,
                            prefixIcon: Icon(Icons.person_outline),
                            labelStyle: TextStyle(fontSize: 15)),
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xfff5f5f5),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'SFUIDisplay'),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: S.of(context).password,
                          prefixIcon: Icon(Icons.lock_outline),
                          labelStyle: TextStyle(fontSize: 15)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      onPressed: () {
                        startLogin1();
                      }, //since this is only a UI app
                      child: Text(
                        S.of(context).sign_in_text,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Color(0xffff2d55),
                      elevation: 0,
                      minWidth: 400,
                      height: 50,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ListTile(
                      leading: GestureDetector(
                        child: Text(
                          S.of(context).offline_bot,
                          style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              fontSize: 15,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => ChatHome()));
                          print('provy');
                        },
                      ),
                      trailing: GestureDetector(
                        child: Text(
                          S.of(context).forgot_password,
                          style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              fontSize: 15,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {

                        },
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                        child: GestureDetector(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: S.of(context).dont_have_account,
                                  style: TextStyle(
                                    fontFamily: 'SFUIDisplay',
                                    color: Colors.black,
                                    fontSize: 15,
                                  )),
                              TextSpan(
                                  text: S.of(context).create_account,
                                  style: TextStyle(
                                    fontFamily: 'SFUIDisplay',
                                    color: Color(0xffff2d55),
                                    fontSize: 15,
                                  ))
                            ]),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => CreateAccount()));
                          },
                        )),
                  ),
                  SizedBox(height: 40,),
                  Container(
                      //margin: EdgeInsets.only(left: 10, top: 480, right: 10, bottom: 10),
                      height: 60,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Icon(Icons.language_outlined, color: Colors.blue,),
                            ),
                            SizedBox(width: 20,),
                            GestureDetector(
                              child: Text('English'),
                              onTap: (){
                                setState(() {
                                  S.load(Locale('en', 'US'));
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 70),
                              child: Icon(Icons.language_outlined, color: Colors.blue,),
                            ),
                            SizedBox(width: 20,),
                            GestureDetector(
                              child: Text('Spanish'),
                              onTap: (){
                                setState(() {
                                  S.load(Locale('es', 'SP'));
                                });
                              },
                            )
                          ],
                        ),
                        //Text('Online Printers Available', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                      )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}




//import 'package:BCB/screens/SignInOne.dart';
//import 'package:BCB/screens/voiceReco.dart';
//import 'package:flutter/material.dart';
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: SignInone(),
//    );
//  }
//}
//

//import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:BCB/languages/locations.dart';
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      localizationsDelegates: [
//        const LocationsDelegate(),
//        GlobalMaterialLocalizations.delegate,
//        GlobalWidgetsLocalizations.delegate,
//        GlobalCupertinoLocalizations.delegate
//      ],
//      supportedLocales: [
//
//        const Locale('de', ''),
//        const Locale('en', ''),
//        const Locale('pl', '')
//      ],
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              Locations.of(context).translate('some_text'),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class RestartWidget extends StatefulWidget {
//  RestartWidget({this.child});
//
//  final Widget child;
//
//  static void restartApp(BuildContext context) {
//    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
//  }
//
//  @override
//  _RestartWidgetState createState() => _RestartWidgetState();
//}
//
//class _RestartWidgetState extends State<RestartWidget> {
//  Key key = UniqueKey();
//
//  void restartApp() {
//    setState(() {
//      key = UniqueKey();
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return KeyedSubtree(key: key, child: widget.child);
//  }
//}
//


