import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CreateAccount.dart';
import 'dashboard.dart';
import 'lisd.dart';

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

          print('Login was successful');

          //user shared preference to save data
          //customer_email.clear();
          //password.clear();

          print('Account Type ' + account_type.toString());

          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Dashboard(
                    account_number: account_number,
                    account_balance: account_balance,
                    customer_first_name: customer_first_name,
                    customer_last_name: customer_last_name,
                    account_type: account_type,
                    customer_title: customer_title,
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
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Welcome back on RoboBank",
                          style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " Sign In",
                          style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Color(0xffff2d55),
                              fontSize: 15,
                              fontWeight: FontWeight.bold))
                    ]),
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
                            labelText: 'Username',
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
                          labelText: 'Password',
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
                        'SIGN IN',
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
                          'Talk to Mimi?',
                          style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              fontSize: 15,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => ListV()));
                          print('provy');
                        },
                      ),
                      trailing: GestureDetector(
                        child: Text(
                          'Forgot your password?',
                          style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              fontSize: 15,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => MainPage()));
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                        child: GestureDetector(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                              )),
                          TextSpan(
                              text: "Create Account",
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AddItemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddItemPageState();
  }
}

class AddItemPageState extends State<AddItemPage> {
  TextEditingController nameController = TextEditingController();
  String response = "NULL";
  createItem() async {
    var dataStr = jsonEncode({
      "command": "add_item",
      "name": nameController.text,
    });
    var url = "http://192.168.8.100/flutter_php/index.php?data=" + dataStr;
    var result = await http.get(url);
    setState(() {
      this.response = result.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: this.nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          RaisedButton(
            onPressed: createItem,
            child: Text("Create"),
          ),
          Text(this.response),
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class Item {
  String id;
  String name;
  DateTime timestamp;
  Item(this.id, this.name, this.timestamp);
}

class MainPageState extends State<MainPage> {
  List<Item> data = [];
  showAddItemPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddItemPage();
    }));
  }

  refreshData() async {
    var dataStr = jsonEncode({
      "command": "get_items",
    });
    var url = "http://192.168.8.100/flutter_php/index.php?data=" + dataStr;
    var result = await http.get(url);
    setState(() {
      data.clear();
      var jsonItems = jsonDecode(result.body) as List<dynamic>;
      jsonItems.forEach((item) {
        this.data.add(Item(item['id'] as String, item['name'] as String,
            DateTime.parse(item['timestamp'] as String)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: showAddItemPage,
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: refreshData,
            child: Text("Refresh"),
          ),
          Column(
            children: data.map((item) => Text(item.name)).toList(),
          ),
        ],
      ),
    );
  }
}
