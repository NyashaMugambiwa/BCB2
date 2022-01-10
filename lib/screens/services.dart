import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart' as random;
import 'package:toggle_switch/toggle_switch.dart';

class Services extends StatefulWidget {
  const Services({Key key, this.account_number}) : super(key: key);
  final String account_number;
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  bool isVisible1 = true;
  bool isVisible2 = false;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';
  String errormsg;
  bool error, showprogress;
  final List<Map<String, dynamic>> _banks = [
    {
      'value': 'BancABC Zimbabwe (ABC Holdings Ltd)',
      'label': 'BancABC Zimbabwe (ABC Holdings Ltd)',
    },
    {
      'value': 'CBZ',
      'label': 'CBZ',
    },
    {
      'value': 'FBC Bank',
      'label': 'FBC Bank',
    },
    {
      'value': 'Steward Bank',
      'label': 'Steward Bank',
    },
    {
      'value': 'Cabs Bank',
      'label': 'Cabs Bank',
    },
    {
      'value': 'AFC',
      'label': 'Agricultural Finance Corporation',
    },
    {
      'value': 'Barclays Bank',
      'label': 'Barclays Bank',
    },
    {
      'value': 'POSB',
      'label': 'Peoples Own Saving Bank (POSB)',
    },
    {'value': 'ZB', 'label': 'ZB Bank Limited of Zimbabwe'},
    {
      'value': 'Standard Chartered Bank Zimbabwe',
      'label': 'Standard Chartered Bank Zimbabwe'
    },
    {'value': 'First Capital Bank', 'label': 'First Capital Bank'},
    {'value': 'Stanbic Bank Zimbabwe', 'label': 'Stanbic Bank Zimbabwe'},
    {'value': 'Ecobank Zimbabwe', 'label': 'Ecobank Zimbabwe'}
  ];
  var actionController = TextEditingController();
  var meterController = TextEditingController();
  var meterHolderController = TextEditingController();
  var amountController = TextEditingController();

  String transaction_reference_number = random.randomNumeric(10);
  String customerCurrentBalance;

  updateBalance() async {
    double val1 = double.tryParse(customerCurrentBalance);
    double val2 = double.tryParse(amountController.text);

    print(val1 - val2);
    String apiurl =
        'https://getFuel.000webhostapp.com/RoboBank/updateBalance.php';
    var data = {
      'account_balance': val1 - val2,
      'account_number': widget.account_number
    };
    var response = await http.post(apiurl, body: json.encode(data));
    var message = jsonDecode(response.body);
    if (message == 'Login Matched') {
      print('Sender new balance ' +
          (val1 - val2).toString() +
          ' ' +
          'Update Account method');
      print('Sender account Number ' +
          widget.account_number +
          ' ' +
          'Transfer Money method');
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: message,
      );
    }
  }

  getCurrentBalanceExternal() async {
    String apiurl =
        'https://getFuel.000webhostapp.com/RoboBank/checkBalance.php'; //api url

    var response = await http.post(Uri.parse(apiurl), body: {
      'account_number': widget.account_number, //get the username text
    });
    print('Sender account ID ' +
        widget.account_number +
        ' ' +
        'Get Current Balance');

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["error"]) {
        //transferMoney();
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"];
          print(errormsg);
        });
      } else {
        if (jsondata["success"]) {
          setState(() {
            error = false;
            showprogress = false;
          });
          String account_balance = jsondata["account_balance"];
          customerCurrentBalance = account_balance;
          print('Sender current balance ' + customerCurrentBalance.toString());
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
      });
    }
  }

  void initState() {
    setState(() {
      getCurrentBalanceExternal();
      //bankController.text = 'RoboBank';
    });
  }

  void validation() {
    String av = amountController.text;
    var long2 = double.tryParse(av);
    var long1 = double.tryParse(customerCurrentBalance);
    print('This is your value ' + long2.toString());

    if (long2 > long1) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: 'You have insufficient funds',
      );
    }
    if (long2 <= long1) {
      sendMoney();
    }
  }

  maths() {
    double val1 = double.tryParse(customerCurrentBalance);
    double val2 = double.tryParse(amountController.text);

    print(val1 - val2);
  }

  sendMoney() async {
    double val1 = double.tryParse(customerCurrentBalance);
    double val2 = double.tryParse(amountController.text);
    setState(() {
      //visible = true;
    });
    String apiurl =
        'https://getFuel.000webhostapp.com/RoboBank/transactions.php';
    var data = {
      'transaction_reference_number': transaction_reference_number,
      'transaction_account_number': widget.account_number,
      'transaction_account_other': widget.account_number,
      'transaction_amount': amountController.text,
      'new_balance': val1 - val2,
      'transaction_description': actionController.text + ' ' + 'Airtime',
    };
    print('This is your customer ID from credentials methods ');
    var response = await http.post(apiurl, body: json.encode(data));
    var message = jsonDecode(response.body);
    if (message == 'Login Matched') {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: 'Transaction was successful !',
          text: 'Thank you');
      updateBalance();
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: message,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/tre.jfif"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 40, right: 10, bottom: 10),
                child: Text(
                  'Buy Zesa Tokens | Pay Zinwa Bills',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 10),
                child: Center(
                  child: ToggleSwitch(
                    initialLabelIndex: 0,
                    fontSize: 13,
                    //totalSwitches: 3,
                    activeBgColor: Colors.blueGrey,
                    minWidth: 250,
                    labels: [
                      'Zinwa Bills',
                      'Zesa Tokens',
                    ],
                    onToggle: (index) {
                      if (index == 0) {
                        print('this is index 0');
                        isVisible2 = false;
                        isVisible1 = true;
                        actionController.text = 'Purchasing Zesa Tokens';
                        meterHolderController.clear();
                        meterController.clear();
                        amountController.clear();
                      }
                      if (index == 1) {
                        print('this is index 1');
                        isVisible1 = false;
                        isVisible2 = true;
                        actionController.text = 'Zinwa Bills';
                        meterHolderController.clear();
                        meterController.clear();
                        amountController.clear();
                      }
                      print('switched to: $index');
                    },
                  ),
                ),
              ),
              Visibility(
                visible: isVisible1,
                child: Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: TextFormField(
                        controller: actionController,
                        readOnly: true,
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SFUIDisplay'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          //labelText: 'Destination Bank',
                          prefixIcon: Icon(
                            Icons.description_outlined,
                            color: Colors.blueGrey,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 13, color: Colors.black),
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        cursorColor: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 90,
                      ),
                      child: TextFormField(
                        controller: meterController,
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SFUIDisplay'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Meter Number',
                          prefixIcon: Icon(
                            Icons.eleven_mp,
                            color: Colors.blueGrey,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 13, color: Colors.black),
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        cursorColor: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 170,
                      ),
                      child: TextFormField(
                        controller: meterHolderController,
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SFUIDisplay'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Meter Holder Full Name',
                          prefixIcon: Icon(
                            Icons.person_pin,
                            color: Colors.blueGrey,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 13, color: Colors.black),
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        cursorColor: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 250,
                      ),
                      child: TextFormField(
                        controller: amountController,
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SFUIDisplay'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Amount',
                          prefixIcon: Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.blueGrey,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 13, color: Colors.black),
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        cursorColor: Colors.grey,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 325,
                        ),
                        child: GestureDetector(
                          child: Container(
                              height: 50,
                              width: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blueGrey,
                              ),
                              child: Center(
                                child: Text(
                                  'Transfer',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )),
                          onTap: () {
                            validation();
                          },
                        )),
                  ],
                ),
              ),
              Visibility(
                visible: isVisible2,
                child: Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: TextFormField(
                        controller: actionController,
                        readOnly: true,
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SFUIDisplay'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          //labelText: 'Destination Bank',
                          prefixIcon: Icon(
                            Icons.description_outlined,
                            color: Colors.blueGrey,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 13, color: Colors.black),
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        cursorColor: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 90,
                      ),
                      child: TextFormField(
                        controller: meterController,
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SFUIDisplay'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Meter Number',
                          prefixIcon: Icon(
                            Icons.eleven_mp,
                            color: Colors.blueGrey,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 13, color: Colors.black),
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        cursorColor: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 170,
                      ),
                      child: TextFormField(
                        controller: meterHolderController,
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SFUIDisplay'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Meter Holder Full Name',
                          prefixIcon: Icon(
                            Icons.person_pin,
                            color: Colors.blueGrey,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 13, color: Colors.black),
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        cursorColor: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 250,
                      ),
                      child: TextFormField(
                        controller: amountController,
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SFUIDisplay'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Amount',
                          prefixIcon: Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.blueGrey,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 13, color: Colors.black),
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        cursorColor: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 325,
                      ),
                      child: Container(
                          height: 50,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blueGrey,
                          ),
                          child: Center(
                            child: Text(
                              'Transfer',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
