import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart' as random;
import 'package:toggle_switch/toggle_switch.dart';

class Airtime extends StatefulWidget {
  const Airtime({Key key, this.account_number}) : super(key: key);
  final String account_number;
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Airtime> {
  bool isVisible1 = true;
  bool isVisible2 = false;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';
  String errormsg;
  bool error, showprogress;
  String customerCurrentBalance;

  var serviceProvider = TextEditingController();
  var phoneController = TextEditingController();
  var amountController = TextEditingController();

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
    double val1 = double.tryParse(customerCurrentBalance);
    double val2 = double.tryParse(amountController.text);
    print('This is your value ' + (val1 - val2).toString());

    if (val2 > val1) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: 'You have insufficient funds',
      );
    }
    if (val2 <= val1) {
      sendMoney();
    }
  }

  String transaction_reference_number = random.randomNumeric(10);

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
      'transaction_description': serviceProvider.text + ' ' + 'Airtime',
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
          'Transfer Money method');
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
                  'Buy Airtime For All Your Networks',
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
                    labels: ['Econet', 'Netone', 'Telecel'],
                    onToggle: (index) {
                      if (index == 0) {
                        print('this is index 0');
                        serviceProvider.text = 'Econet';
                        phoneController.clear();
                        amountController.clear();
                      }
                      if (index == 1) {
                        print('this is index 1');
                        serviceProvider.text = 'Netone';
                        phoneController.clear();
                        amountController.clear();
                      }
                      if (index == 2) {
                        print('this is index 2');
                        serviceProvider.text = 'Telecel';
                        phoneController.clear();
                        amountController.clear();
                      }
                      print('switched to: $index');
                    },
                  ),
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      controller: serviceProvider,
                      readOnly: true,
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'SFUIDisplay'),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Selected  Service Provider',
                        prefixIcon: Icon(
                          Icons.network_cell,
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
                      controller: phoneController,
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'SFUIDisplay'),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone number to receive airtime',
                        prefixIcon: Icon(
                          Icons.dialpad_outlined,
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
                        top: 250,
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
            ],
          )),
    );
  }
}
