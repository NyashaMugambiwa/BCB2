import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class ChatBot extends StatefulWidget {
  @override
  _ListV createState() => _ListV();
}

class _ListV extends State<ChatBot> {
  final List<String> names = <String>[
    'You have questions related to our banking services right? '
        'You are lost lost buddy, just let us know how you want '
        'us to assist you today by choose clicking a number that '
        'corresponds to the question you want to ask\n\n'
        '1. How can i open an account\n'
        '2. How long does it take to open an account ?\n'
        '3. What type of accounts can i open with your bank?\n'
        '4. What do i need to open an account ?\n'
  ];
  final List<String> questions = <String>[
    'Good morning Mrs. N Mugambiwa, welcome to RoboChat\nHow many we '
        'help you today ?\nChoose a number that corresponds to the '
        'service you need today\n\n'
        '1. How can i open an account\n'
        '2. Balance enquiry\n'
        '3. How do i purchase payments\n'
        '4. Is internet banking secure ?\n'
        '5. Can i change my card pin ?\n',
  ];
  var messageType = 'sending';
  void pub() {
    print('List length is ' + names.length.toString());
    names.insert(names.length - 1, nameController.text);

    String hyt = names.elementAt(names.length - 1);
    nameController.clear();
    if (hyt == '1') {
      //
      print('I get it');
      Timer(Duration(seconds: 3), () {
        print("Yeah, this line is printed after 3 second");
        names.insert(names.length - 1, 'Zvaita');
        print(names.toList());
      });
    }
  }

  void myTimer() {
    String hyt = names.elementAt(names.length - 1);
    if (hyt == '1') {
      Timer(Duration(seconds: 3), () {
        print("Yeah, this line is printed after 3 second");
        names.insert(names.length - 1, 'Zvaita');
        print(names.toList());
      });
    } else {
      print("String doesn't contain 1");
    }
  }

  Timer _timer;
  int _start = 10;

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];

  TextEditingController nameController = TextEditingController();

  String effective_datetime =
      DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
  //String currentDate = DateFormat("mmm dd yyyy").format(DateTime.now());

  var currentDate = Jiffy().dateTime;
  String welcomeNote =
      'You have questions related to our banking services right? '
      'You are lost lost buddy, just let us know how you want us to '
      'assist you today by choose clicking a number that corresponds '
      'to the question you want to ask\n\n'
      '1. How can i open an account\n'
      '2. How long does it take to open an account ?\n'
      '3. What type of accounts can i open with your bank?\n'
      '4. What do i need to open an account ?\n';
  String mainMenu = '\n________________________________________________\n'
      '\nRoboBank Main Menu\n'
      '________________________________________________\n\n'
      '1. How can i open an account\n'
      '2. How long does it take to open an account ?\n'
      '3. What type of accounts can i open with your bank?\n'
      '4. What do i need to open an account ?\n';
  String option1Selected =
      '\n________________________________________________\n'
      '\nFollow the steps below to open an account\n'
      '________________________________________________\n\n'
      '>. Download and install the mobile application in your smart device\n'
      '>. Run the application\n'
      '>. Login and click the link in blue at the bottom center of the login page\n'
      '>. Fill in the fields with your valid details\n'
      '\nPress # to return to the main menu';
  String option2Selected =
      '\n________________________________________________\n'
      '\nAccount Creation Duration\n'
      '________________________________________________\n\n'
      '>. Once you follow through the registration process, and provide '
      'all your '
      ' personal details that we ask from you, you will only need to wait'
      ' for 4 hours as we wait for validation your identity \n';
  String option3Selected =
      '\n________________________________________________\n'
      '\nTypes Of Accounts you can open\n'
      '________________________________________________\n\n'
      '>. With RoboBank you can open 2 types of account which are \n'
      '>. RoboBank Lite Account ->Press 1 for more details\n'
      '>. RoboBank Savings Account ->Press 2 for more details\n'
      '>. RoboBank Personal Account -> Press 3 for more details\n'
      '\nPress # to return to the main menu';
  String option4Selected =
      '\n________________________________________________\n'
      '\nWhat you need to open an account \n'
      '________________________________________________\n\n'
      '>. Please choose the type of an account you want to know about\n'
      '>. RoboBank Lite Account ->Press 1 for more details\n'
      '>. RoboBank Savings Account ->Press 2 for more details\n'
      '>. RoboBank Personal Account -> Press 3 for more details\n'
      '\nPress # to return to the main menu';

  @override
  Widget build(BuildContext context) {
    String nameValue = nameController.text;
    BubbleType b;
    Alignment al = Alignment.topLeft;
    BubbleNip bnp = BubbleNip.leftTop;
    Color textColor;
    BubbleEdges bubbleEdges;

    void startTimer() {
      const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) {
          if (_start == 0) {
            setState(() {
              timer.cancel();
              print('zvaita');
              String a = names.elementAt(names.length - 1);
              print(names.length);
              if (names.length == 2 && a == '1') {
                names.insert(names.length, option1Selected);
                b = BubbleType.receiverBubble;
                al = Alignment.topLeft;
              }
              if (names.length == 2 && a == '2') {
                names.insert(names.length, option2Selected);
                b = BubbleType.receiverBubble;
                al = Alignment.topLeft;
              }
              if (names.length == 2 && a == '3') {
                names.insert(names.length, option3Selected);
                b = BubbleType.receiverBubble;
                al = Alignment.topLeft;
              }
              if (names.length == 2 && a == '4') {
                names.insert(names.length, option2Selected);
                b = BubbleType.receiverBubble;
                al = Alignment.topLeft;
              }
              if (names.length > 2 && a == '#') {
                names.insert(names.length, mainMenu);
                b = BubbleType.receiverBubble;
                al = Alignment.topLeft;
              }
              if (names.length > 2 && a == '1') {
                names.insert(names.length, option1Selected);
                b = BubbleType.receiverBubble;
                al = Alignment.topLeft;
              }
              if (names.length > 2 && a == '2') {
                names.insert(names.length, option2Selected);
                b = BubbleType.receiverBubble;
                al = Alignment.topLeft;
              }
              if (names.length > 2 && a == '3') {
                names.insert(names.length, option3Selected);
                b = BubbleType.receiverBubble;
                al = Alignment.topLeft;
                nameController.clear();
              }
              if (names.length > 2 && a == '4') {
                names.insert(names.length, option4Selected);
                b = BubbleType.receiverBubble;
                al = Alignment.topLeft;
              }
            });
          } else {
            setState(() {
              _start--;
              if (_start == 0) {}
            });
          }
        },
      );
    }

    void addItemToList() {
      var lrt = names.length;

      setState(() {
        b = BubbleType.receiverBubble;
        al = Alignment.topLeft;
        names.insert(lrt, nameController.text);
        msgCount.insert(0, 0);
      });
    }

    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      elevation: 10,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );
    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      elevation: 10,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Robo Banking ChatBot',
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/tre.jfif"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: <Widget>[
            Bubble(
              alignment: Alignment.center,
              color: Color.fromARGB(255, 212, 234, 244),
              elevation: 5,
              margin: BubbleEdges.only(top: 8.0),
              child: Text('Today', style: TextStyle(fontSize: 10)),
            ),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: names.length,
                    itemBuilder: (BuildContext context, int index) {
                      String swer = '${names[index]}';
                      if (swer == '1') {
                        messageType = 'sending';
                        //pub();
                        al = Alignment.topRight;
                        bnp = BubbleNip.rightTop;
                        bubbleEdges = BubbleEdges.only(top: 8.0, left: 50.0);
                        textColor = Color.fromARGB(255, 225, 255, 199);
                      }
                      if (swer.contains(option1Selected)) {
                        al = Alignment.topLeft;
                        bnp = BubbleNip.leftTop;
                        bubbleEdges = BubbleEdges.only(top: 8.0, right: 50.0);
                        textColor = Colors.orange.withAlpha(64);
                      }
                      if (swer == '2') {
                        messageType = 'sending';
                        //pub();
                        al = Alignment.topRight;
                        bnp = BubbleNip.rightTop;
                        bubbleEdges = BubbleEdges.only(top: 8.0, left: 50.0);
                        textColor = Color.fromARGB(255, 225, 255, 199);
                      }
                      if (swer.contains(option2Selected)) {
                        al = Alignment.topLeft;
                        bnp = BubbleNip.leftTop;
                        bubbleEdges = BubbleEdges.only(top: 8.0, right: 50.0);
                        textColor = Colors.orange.withAlpha(64);
                      }
                      if (swer == '3') {
                        messageType = 'sending';
                        //pub();
                        al = Alignment.topRight;
                        bnp = BubbleNip.rightTop;
                        bubbleEdges = BubbleEdges.only(top: 8.0, left: 50.0);
                        textColor = Color.fromARGB(255, 225, 255, 199);
                      }
                      if (swer.contains(option3Selected)) {
                        al = Alignment.topLeft;
                        bnp = BubbleNip.leftTop;
                        bubbleEdges = BubbleEdges.only(top: 8.0, right: 50.0);
                        textColor = Colors.orange.withAlpha(64);
                      }
                      if (swer == '4') {
                        messageType = 'sending';
                        //pub();
                        al = Alignment.topRight;
                        bnp = BubbleNip.rightTop;
                        bubbleEdges = BubbleEdges.only(top: 8.0, left: 50.0);
                        textColor = Color.fromARGB(255, 225, 255, 199);
                      }
                      if (swer.contains(option4Selected)) {
                        al = Alignment.topLeft;
                        bnp = BubbleNip.leftTop;
                        bubbleEdges = BubbleEdges.only(top: 8.0, right: 50.0);
                        textColor = Colors.orange.withAlpha(64);
                      }
                      if (swer == '#') {
                        messageType = 'sending';
                        //pub();
                        al = Alignment.topRight;
                        bnp = BubbleNip.rightTop;
                        bubbleEdges = BubbleEdges.only(top: 8.0, left: 50.0);
                        textColor = Color.fromARGB(255, 225, 255, 199);
                      }
                      if (swer.contains(mainMenu)) {
                        al = Alignment.topLeft;
                        bnp = BubbleNip.leftTop;
                        bubbleEdges = BubbleEdges.only(top: 8.0, right: 50.0);
                        textColor = Colors.orange.withAlpha(64);
                      }
                      if (swer.contains('Good')) {
                        print('good');
                        al = Alignment.topLeft;
                        bnp = BubbleNip.leftTop;
                        bubbleEdges = BubbleEdges.only(top: 8.0, right: 50.0);
                        textColor = Colors.orange.withAlpha(64);
                      }
                      return Stack(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: EdgeInsets.all(2),
                            child: Bubble(
                              style: BubbleStyle(
                                stick: true,
                                nip: bnp,
                                color: textColor,
                                elevation: 10,
                                margin: bubbleEdges,
                                alignment: al,
                              ),
                              child: Text(
                                '${names[index]}' +
                                    '\n ' +
                                    DateFormat("yyyy-MM-dd hh:mm:ss")
                                        .format(DateTime.now())
                                        .toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      );
                    })),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    labelText: 'Message',
                    labelStyle: TextStyle(fontSize: 13),
                    hintText: 'Please type your message here',
                    hintStyle: TextStyle(fontSize: 13),
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          addItemToList();
                        });
                        startTimer();
                        //nameController.clear();
                      },
                      child: Icon(
                        Icons.send,
                        size: 20,
                      ),
                    )),
              ),
            ),
          ]),
        ));
  }
}
