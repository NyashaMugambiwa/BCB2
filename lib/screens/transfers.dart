import 'dart:convert';

import 'package:BCB/screens/dashboard.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart' as random;
import 'package:select_form_field/select_form_field.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:BCB/generated/l10n.dart';


class TransfersPage extends StatefulWidget {
  const TransfersPage({Key key, this.account_number}) : super(key: key);
  final String account_number;

  @override
  _TransfersPageState createState() => _TransfersPageState();
}

class _TransfersPageState extends State<TransfersPage> {
  bool isVisible2 = false;
  bool isVisible1 = true;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';
  String errormsg;
  bool error, showprogress;
  String customerCurrentBalance;
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
  var bankController = TextEditingController();
  var accountController = TextEditingController();
  var nameController = TextEditingController();
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
      bankController.text = 'RoboBank';
    });
  }

  void validation() {
    double val1 = double.tryParse(customerCurrentBalance);
    double val2 = double.tryParse(amountController.text);
    print('This is your value ' + val2.toString());

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
  String transactions_new_bal;

  maths() {
    double val1 = double.tryParse(customerCurrentBalance);
    double val2 = double.tryParse(amountController.text);

    print(val1 - val2);
  }

  sendMoney() async {
    double val1 = double.tryParse(customerCurrentBalance);
    double val2 = double.tryParse(amountController.text);
    int acc = int.tryParse(accountController.text);
    int abc = int.tryParse(widget.account_number);
    int axc = int.tryParse(transaction_reference_number);
    setState(() {
      //visible = true;
    });
    String apiurl =
        'https://getFuel.000webhostapp.com/RoboBank/transactions.php';
    var data = {
      'transaction_reference_number': axc,
      'transaction_account_number': abc,
      'transaction_other_account_number': acc,
      'transaction_amount': val2,
      'new_balance': val1 - val2,
      'transaction_description': 'Internal Transfers',
    };
    print(data);
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
      'account_balance': (val1 - val2).toString(),
      'account_number': widget.account_number
    };
    var response = await http.post(apiurl, body: json.encode(data));
    var message = jsonDecode(response.body);
    if (message == 'Login Matched') {
      print('Sender new balance ' +
          transactions_new_bal.toString() +
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
      print(data);
    }
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(S.of(context).make_transfers, style: TextStyle(fontSize: 16),),
      ),
      body: Container(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Row(
                    children: [
                      SizedBox(width: 250,),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            width: 45,
                            height: 30,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('Assets/usa.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            S.load(Locale('en', 'US'));
                          });
                        },
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            width: 45,
                            height: 30,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('Assets/spain.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            S.load(Locale('es', 'SP')) ;
                          });
                        },
                      )
                    ],
                  ),
                ),
                Container(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                          child: Center(
                            child: ToggleSwitch(
                              initialLabelIndex: 0,
                              //inactiveBgColor: Colors.white,
                              fontSize: 13,
                              //totalSwitches: 3,
                              activeBgColor: Colors.blueGrey,
                              minWidth: 250,
                              labels: [S.of(context).internal_transfers, S.of(context).external_transfers],
                              onToggle: (index) {
                                if (index == 0) {
                                  print('this is index 0');
                                  isVisible2 = false;
                                  isVisible1 = true;
                                }
                                if (index == 1) {
                                  print('this is index 1');
                                  isVisible1 = false;
                                  isVisible2 = true;
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
                              Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 20, right: 20, top: 10),
                                    child: TextFormField(
                                      controller: bankController,
                                      readOnly: true,
                                      style: TextStyle(
                                          color: Colors.black, fontFamily: 'SFUIDisplay'),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: S.of(context).destination_bank,
                                        prefixIcon: Icon(
                                          Icons.store_mall_directory_outlined,
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
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 90,
                                ),
                                child: TextFormField(
                                  controller: accountController,
                                  style: TextStyle(
                                      color: Colors.black, fontFamily: 'SFUIDisplay'),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: S.of(context).ben_account_number,
                                    prefixIcon: Icon(
                                      Icons.account_balance_wallet,
                                      color: Colors.blueGrey,
                                    ),
                                    labelStyle: TextStyle(fontSize: 13, color: Colors.black),
                                    focusColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
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
                                  controller: nameController,
                                  style: TextStyle(
                                      color: Colors.black, fontFamily: 'SFUIDisplay'),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: S.of(context).ben_full_name,
                                    prefixIcon: Icon(
                                      Icons.person_pin,
                                      color: Colors.blueGrey,
                                    ),
                                    labelStyle: TextStyle(fontSize: 13, color: Colors.black),
                                    focusColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
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
                                    labelText: S.of(context).amount,
                                    prefixIcon: Icon(
                                      Icons.monetization_on_outlined,
                                      color: Colors.blueGrey,
                                    ),
                                    labelStyle: TextStyle(fontSize: 13, color: Colors.black),
                                    focusColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
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
                                                fontSize: 13, decoration: TextDecoration.none,
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
                              Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 20, right: 20, top: 10),
                                    child: SelectFormField(
                                      //type: SelectFormFieldType.dialog,
                                      //controller: de,
                                      //initialValue: _initialValue,
                                      style: TextStyle(fontSize: 13, color: Colors.black),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Select the recipient bank',
                                        hintStyle:
                                        TextStyle(color: Colors.grey, fontSize: 13),
                                        labelStyle:
                                        TextStyle(fontSize: 13, color: Colors.black),
                                        focusColor: Colors.black54,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(1.0)),
                                            borderSide: BorderSide(color: Colors.black)),
                                        prefixIcon: Icon(
                                          Icons.store_mall_directory_outlined,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                      changeIcon: true,
                                      dialogTitle: 'Select the recipient bank',
                                      dialogCancelBtn: 'Cancel',
                                      enableSearch: true,
                                      dialogSearchHint: 'Search the bank',
                                      items: _banks,
                                      onChanged: (val) => setState(() => _valueChanged = val),
                                      validator: (val) {
                                        setState(() => _valueToValidate = val ?? '');
                                        return null;
                                      },
                                      onSaved: (val) =>
                                          setState(() => _valueSaved = val ?? ''),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 90,
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  style: TextStyle(
                                      color: Colors.black, fontFamily: 'SFUIDisplay'),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Beneficiary Account Number',
                                    prefixIcon: Icon(
                                      Icons.account_balance_wallet,
                                      color: Colors.blueGrey,
                                    ),
                                    labelStyle: TextStyle(fontSize: 13, color: Colors.black),
                                    focusColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
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
                                  style: TextStyle(
                                      color: Colors.black, fontFamily: 'SFUIDisplay'),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Beneficiary Full Name',
                                    prefixIcon: Icon(
                                      Icons.person_pin,
                                      color: Colors.blueGrey,
                                    ),
                                    labelStyle: TextStyle(fontSize: 13, color: Colors.black),
                                    focusColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
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
                                  style: TextStyle(
                                      color: Colors.black, fontFamily: 'SFUIDisplay'),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Amount',
                                    prefixIcon: Icon(
                                      Icons.monetization_on_outlined,
                                      color: Colors.blueGrey,
                                    ),
                                    labelStyle: TextStyle(fontSize: 13, color: Colors.black),
                                    focusColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
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
                        )
                      ],
                    )),
              ],
            )
        ),
      ),
    );
  }
}

