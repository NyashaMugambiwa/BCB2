import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart' as random;
import 'package:select_form_field/select_form_field.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  int _activeStepIndex = 0;

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var titleController = TextEditingController();
  var genderController = TextEditingController();
  var idNumberController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var dateController = TextEditingController();
  var addressController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  var accountTypeController = TextEditingController();

  String customer_id = '';
  String account_id = '';

  String account_number = random.randomNumeric(10);

  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';
  final List<Map<String, dynamic>> _gender = [
    {
      'value': 'male',
      'label': 'Male',
    },
    {
      'value': 'female',
      'label': 'Female',
    },
  ];
  final List<Map<String, dynamic>> _accountType = [
    {
      'value': 'Lite Account',
      'label': 'Lite Account',
    },
    {
      'value': 'Current Account',
      'label': 'Current Account',
    },
    {
      'value': 'Savings Account',
      'label': 'Savings Account',
    },
  ];
  final List<Map<String, dynamic>> _title = [
    {
      'value': 'Mr.',
      'label': 'Mr.',
    },
    {
      'value': 'Mrs.',
      'label': 'Mrs.',
    },
    {
      'value': 'Ms.',
      'label': 'Ms.',
    },
    {
      'value': 'Sir.',
      'label': 'Sir.',
    },
    {
      'value': 'Dr.',
      'label': 'Dr.',
    },
    {
      'value': 'Prof.',
      'label': 'Prof.',
    },
  ];

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: Text(
            'Personal Information',
            style: TextStyle(fontSize: 13),
          ),
          content: Container(
            child: Column(
              children: [
                TextFormField(
                  controller: firstNameController,
                  maxLength: 30,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.black,
                      ),
                      focusColor: Colors.black54,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(1.0)),
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Enter your first name',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                      labelText: 'First name',
                      labelStyle: TextStyle(fontSize: 13, color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: lastNameController,
                  maxLength: 30,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.black,
                      ),
                      focusColor: Colors.black54,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(1.0)),
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Enter your last name',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                      labelText: 'Last name',
                      labelStyle: TextStyle(fontSize: 13, color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1))),
                ),
                SizedBox(
                  height: 10,
                ),
                SelectFormField(
                  //type: SelectFormFieldType.dialog,
                  controller: titleController,
                  maxLength: 20,
                  //initialValue: _initialValue,
                  style: TextStyle(fontSize: 13, color: Colors.black),
                  decoration: InputDecoration(
                    focusColor: Colors.black54,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Select your title',
                    labelStyle: TextStyle(fontSize: 13, color: Colors.black),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.badge,
                      color: Colors.black,
                    ),
                    hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  changeIcon: true,
                  dialogTitle: 'Select your title',
                  dialogCancelBtn: 'Cancel',
                  enableSearch: true,
                  dialogSearchHint: 'Search your title',
                  items: _title,
                  onChanged: (val) => setState(() => _valueChanged = val),
                  validator: (val) {
                    setState(() => _valueToValidate = val ?? '');
                    return null;
                  },
                  onSaved: (val) => setState(() => _valueSaved = val ?? ''),
                ),
              ],
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: Text(
              'Physical Address',
              style: TextStyle(fontSize: 13),
            ),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  SelectFormField(
                    //type: SelectFormFieldType.dialog,
                    controller: genderController,
                    maxLength: 20,
                    //initialValue: _initialValue,
                    style: TextStyle(fontSize: 13, color: Colors.black),
                    decoration: InputDecoration(
                      focusColor: Colors.black54,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(1.0)),
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Select your gender',
                      labelStyle: TextStyle(fontSize: 13, color: Colors.black),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.badge,
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                    changeIcon: true,
                    dialogTitle: 'Select your gender',
                    dialogCancelBtn: 'Cancel',
                    enableSearch: true,
                    dialogSearchHint: 'Search your gender',
                    items: _gender,
                    onChanged: (val) => setState(() => _valueChanged = val),
                    validator: (val) {
                      setState(() => _valueToValidate = val ?? '');
                      return null;
                    },
                    onSaved: (val) => setState(() => _valueSaved = val ?? ''),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: idNumberController,
                    maxLength: 30,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.card_membership_sharp,
                          color: Colors.black,
                        ),
                        focusColor: Colors.black54,
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'Enter your national ID number',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                        labelText: 'ID number',
                        labelStyle:
                            TextStyle(fontSize: 13, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    readOnly: true,
                    maxLength: 15,
                    controller: dateController,
                    style: TextStyle(fontSize: 13, color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Pick your date of birth',
                      prefixIcon: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                      focusColor: Colors.black54,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(1.0)),
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      dateController.text = date.toString().substring(0, 10);
                    },
                  ),
                ],
              ),
            )),
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: Text(
              'Contact Details',
              style: TextStyle(fontSize: 13),
            ),
            content: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: addressController,
                    maxLength: 30,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_city_outlined,
                          color: Colors.black,
                        ),
                        focusColor: Colors.black54,
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'Enter your physical address',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                        labelText: 'Physical Address',
                        labelStyle:
                            TextStyle(fontSize: 13, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    maxLength: 30,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        focusColor: Colors.black54,
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'Enter your email address',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                        labelText: 'Email Address',
                        labelStyle:
                            TextStyle(fontSize: 13, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1))),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    cursorColor: Colors.black,
                    style: TextStyle(fontSize: 13),
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: new InputDecoration(
                      labelText: 'Enter your mobile number',
                      labelStyle: TextStyle(fontSize: 13, color: Colors.black),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                      focusColor: Colors.black54,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(1.0)),
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: '0784340477',
                      border: OutlineInputBorder(),
                    ),
                    autocorrect: true,
                    maxLength: 10,
                  ),
                ],
              ),
            )),
        Step(
            state:
                _activeStepIndex <= 3 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 3,
            title: Text(
              'Account Credentials',
              style: TextStyle(fontSize: 13),
            ),
            content: Container(
              child: Column(
                children: [
                  SelectFormField(
                    //type: SelectFormFieldType.dialog,
                    controller: accountTypeController,
                    maxLength: 20,
                    //initialValue: _initialValue,
                    style: TextStyle(fontSize: 13, color: Colors.black),
                    decoration: InputDecoration(
                      focusColor: Colors.black54,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(1.0)),
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Select account type',
                      labelStyle: TextStyle(fontSize: 13, color: Colors.black),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.badge,
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                    changeIcon: true,
                    dialogTitle: 'Select the type of an account',
                    dialogCancelBtn: 'Cancel',
                    enableSearch: true,
                    dialogSearchHint: 'Search account type',
                    items: _accountType,
                    onChanged: (val) => setState(() => _valueChanged = val),
                    validator: (val) {
                      setState(() => _valueToValidate = val ?? '');
                      return null;
                    },
                    onSaved: (val) => setState(() => _valueSaved = val ?? ''),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: usernameController,
                    maxLength: 30,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.verified_user_outlined,
                          color: Colors.black,
                        ),
                        focusColor: Colors.black54,
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'Create username',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                        labelText: 'Username',
                        labelStyle:
                            TextStyle(fontSize: 13, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    maxLength: 30,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.security_outlined,
                          color: Colors.black,
                        ),
                        focusColor: Colors.black54,
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'Create your password',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                        labelText: 'Password',
                        labelStyle:
                            TextStyle(fontSize: 13, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1))),
                  ),
                ],
              ),
            )),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 4,
          title: Text('Confirm'),
          content: Container(
              //height: 60,
              width: 350,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "First Name",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " \n${firstNameController.text}",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Color(0xffff2d55),
                                fontSize: 13,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                    trailing: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Last Name",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " \n${lastNameController.text}",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Color(0xffff2d55),
                                fontSize: 13,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                  ),
                  ListTile(
                    leading: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "User Title",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " \n${titleController.text}",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Color(0xffff2d55),
                                fontSize: 13,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                    trailing: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "User Gender",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " \n${genderController.text}",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Color(0xffff2d55),
                                fontSize: 13,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                  ),
                  ListTile(
                    leading: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Date of birth",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " \n${dateController.text}",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Color(0xffff2d55),
                                fontSize: 13,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                    trailing: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "ID number",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " \n${idNumberController.text}",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Color(0xffff2d55),
                                fontSize: 13,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                  ),
                  ListTile(
                    leading: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Phone number",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " \n${phoneNumberController.text}",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Color(0xffff2d55),
                                fontSize: 13,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                    trailing: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Email address",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " \n${emailController.text}",
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Color(0xffff2d55),
                                fontSize: 13,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                  ),
                  RaisedButton(
                      child: Text('Hellow'),
                      onPressed: () {
                        validation();
                      })
                ],
              )),
        )
      ];

  validation() {
    String a1 = firstNameController.text;
    String a2 = lastNameController.text;
    String a3 = titleController.text;
    String a4 = genderController.text;
    String a5 = idNumberController.text;
    String a6 = phoneNumberController.text;
    String a7 = dateController.text;
    String a8 = addressController.text;
    if (a1.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please enter your first name',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 10,
          backgroundColor: Colors.blueGrey);
    }
    if (!a1.isEmpty) {
      if (a2.isEmpty) {
        Fluttertoast.showToast(
            msg: 'Please enter your last name',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 10,
            backgroundColor: Colors.blueGrey);
      }
      if (!a2.isEmpty) {
        if (a3.isEmpty) {
          Fluttertoast.showToast(
              msg: 'Please select your title',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 10,
              backgroundColor: Colors.blueGrey);
        }
        if (!a3.isEmpty) {
          if (a4.isEmpty) {
            Fluttertoast.showToast(
                msg: 'Please select your gender',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 10,
                backgroundColor: Colors.blueGrey);
          }
          if (!a4.isEmpty) {
            if (a5.isEmpty) {
              Fluttertoast.showToast(
                  msg: 'Please enter your national ID number',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 10,
                  backgroundColor: Colors.blueGrey);
            }
            if (!a5.isEmpty) {
              if (a6.isEmpty) {
                Fluttertoast.showToast(
                    msg: 'Please select your phone number',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 10,
                    backgroundColor: Colors.blueGrey);
              }
              if (!a6.isEmpty) {
                if (a6.length < 10) {
                  Fluttertoast.showToast(
                      msg: 'Your phone number is invalid',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 10,
                      backgroundColor: Colors.blueGrey);
                }
                if (a6.length == 10) {
                  if (a7.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Please pick your date of birth',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 10,
                        backgroundColor: Colors.blueGrey);
                  }
                  if (!a7.isEmpty) {
                    if (a8.isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Please enter your address',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 10,
                          backgroundColor: Colors.blueGrey);
                    }
                    if (!a8.isEmpty) {
                      customerRegister();
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  customerRegister() async {
    setState(() {
      //visible = true;
    });
    String apiurl = 'https://getFuel.000webhostapp.com/RoboBank/signup.php';
    var data = {
      'customer_first_name': firstNameController.text,
      'customer_last_name': lastNameController.text,
      'customer_title': titleController.text,
      'customer_gender': genderController.text,
      'customer_id_number': idNumberController.text,
      'customer_email_address': emailController.text,
      'customer_phone_number': phoneNumberController.text,
      'customer_date_birth': dateController.text,
      'customer_address': addressController.text,
    };
    var response = await http.post(apiurl, body: json.encode(data));
    var message = jsonDecode(response.body);
    String a = message.toString();
    if (a != '0') {
      setState(() {
        // visible = false;
      });
      print('This is your customer ID ' + a);

      print('Inserted into customer table successful');
      customer_id = a;
      credentials();
    } else {
      setState(() {
        //visible = false;
      });
      // Showing Alert Dialog with Response JSON Message.
      print('something went wrong');
    }
  }

  credentials() async {
    setState(() {
      //visible = true;
    });
    String apiurl =
        'https://getFuel.000webhostapp.com/RoboBank/credentials.php';
    var data = {
      'customer_username': usernameController.text,
      'customer_password': passwordController.text,
      'customer_id': customer_id,
    };
    print('This is your customer ID from credentials methods ' + customer_id);
    var response = await http.post(apiurl, body: json.encode(data));
    var message = jsonDecode(response.body);
    String b = message.toString();
    if (b != '0') {
      setState(() {
        // visible = false;
      });
      print('This is your customer security ID ' + b);

      //print('Customer Credentials Created Successfully');
      accounts();
    } else {
      setState(() {
        //visible = false;
      });
      // Showing Alert Dialog with Response JSON Message.
      print('something went wrong');
    }
  }

  accounts() async {
    setState(() {
      //visible = true;
    });
    String apiurl = 'https://getFuel.000webhostapp.com/RoboBank/accounts.php';
    var data = {
      'account_number': account_number,
      'account_balance': '0',
      'account_type': accountTypeController.text,
    };
    print('This is your account number ' + account_number);
    print('This is your account type ' + accountTypeController.text);
    var response = await http.post(apiurl, body: json.encode(data));
    var message = jsonDecode(response.body);
    String b = message.toString();
    if (b != '0') {
      setState(() {
        // visible = false;
      });
      print('This is your ID' + b);
      account_id = b;
      //print('Your account number was created successfully');
      customer_has_account();
    } else {
      setState(() {
        //visible = false;
      });
      // Showing Alert Dialog with Response JSON Message.
      print('something went wrong');
    }
  }

  customer_has_account() async {
    setState(() {
      //visible = true;
    });
    String apiurl =
        'https://getFuel.000webhostapp.com/RoboBank/customer_has_account.php';
    var data = {
      'customer_customer_id': customer_id,
      'account_account_id': account_id,
    };
    print('This is your customer ID ' + customer_id);
    print('This is your account ID ' + account_id);
    var response = await http.post(apiurl, body: json.encode(data));
    var message = jsonDecode(response.body);
    String b = message.toString();
    if (b != '0') {
      setState(() {
        // visible = false;
      });
      print('This is your response from the server ' + b);
      //print('')

      print('Successfully inserted into Customer Has Account');
    } else {
      setState(() {
        //visible = false;
      });
      // Showing Alert Dialog with Response JSON Message.
      print('something went wrong');
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
            margin: EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(18),
              child: ListView(
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
                          text: " \nCreate an account now",
                          style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Color(0xffff2d55),
                              fontSize: 15,
                              fontWeight: FontWeight.bold))
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
                    child: Stepper(
                      type: StepperType.vertical,
                      currentStep: _activeStepIndex,
                      steps: stepList(),
                      onStepContinue: () {
                        if (_activeStepIndex < (stepList().length - 1)) {
                          setState(() {
                            _activeStepIndex += 1;
                          });
                        } else {
                          print('Submited');
                        }
                      },
                      onStepCancel: () {
                        if (_activeStepIndex == 0) {
                          return;
                        }

                        setState(() {
                          _activeStepIndex -= 1;
                        });
                      },
                      onStepTapped: (int index) {
                        setState(() {
                          _activeStepIndex = index;
                        });
                      },
                      controlsBuilder: (context,
                          {onStepContinue, onStepCancel}) {
                        final isLastStep =
                            _activeStepIndex == stepList().length - 1;
                        return Container(
                          height: 70,
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: onStepContinue,
                                  child: (isLastStep)
                                      ? const Text('Submit')
                                      : const Text('Next'),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              if (_activeStepIndex > 0)
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: onStepCancel,
                                    child: Text('Back'),
                                  ),
                                )
                            ],
                          ),
                        );
                      },
                    ),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _activeStepIndex = 0;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Account'),
          content: Container(
            child: Column(
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Address'),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: address,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full House Address',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: pincode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pin Code',
                    ),
                  ),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Confirm'),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name: ${name.text}'),
                Text('Email: ${email.text}'),
                const Text('Password: *****'),
                Text('Address : ${address.text}'),
                Text('PinCode : ${pincode.text}'),
              ],
            )))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Stepper'),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            setState(() {
              _activeStepIndex += 1;
            });
          } else {
            print('Submited');
          }
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }

          setState(() {
            _activeStepIndex -= 1;
          });
        },
        onStepTapped: (int index) {
          setState(() {
            _activeStepIndex = index;
          });
        },
        controlsBuilder: (context, {onStepContinue, onStepCancel}) {
          final isLastStep = _activeStepIndex == stepList().length - 1;
          return Container(
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onStepContinue,
                    child: (isLastStep)
                        ? const Text('Submit')
                        : const Text('Next'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (_activeStepIndex > 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onStepCancel,
                      child: const Text('Back'),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
