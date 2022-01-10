import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class ChabBotMenu extends StatefulWidget {
  ChabBotMenu({Key key}) : super(key: key);

  @override
  _ChabBotMenuState createState() => _ChabBotMenuState();
}

class _ChabBotMenuState extends State<ChabBotMenu> {
  var userMessageController = TextEditingController();
  var messageContent = '';
  final List<String> names = <String>[];
  List<String> litems = [];
  TextEditingController nameController = TextEditingController();
  void addItemToList() {
    setState(() {
      names.insert(0, nameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Robo Banking ChatBot',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Container(
        color: Colors.yellow.withAlpha(64),
        child: Stack(fit: StackFit.passthrough, children: <Widget>[
          ListView(
            padding: EdgeInsets.all(8.0),
            children: [
              Bubble(
                alignment: Alignment.center,
                color: Color.fromARGB(255, 212, 234, 244),
                elevation: 1 * px,
                margin: BubbleEdges.only(top: 8.0),
                child: Text('Today', style: TextStyle(fontSize: 10)),
              ),
              Bubble(
                style: styleSomebody,
                child: Text(
                    'Hi Jason. Sorry to bother you. I have a queston for you.'),
              ),
              Bubble(
                style: styleMe,
                child: Text('Whats\'up?'),
              ),
              Bubble(
                style: styleSomebody,
                child: Text('I\'ve been having a problem with my computer.'),
              ),
              Bubble(
                style: styleSomebody,
                margin: BubbleEdges.only(top: 2.0),
                nip: BubbleNip.no,
                child: Text('Can you help me?'),
              ),
              Bubble(
                style: styleMe,
                child: Text('Ok'),
              ),
              Bubble(
                style: styleMe,
                nip: BubbleNip.no,
                margin: BubbleEdges.only(top: 2.0),
                child: Text('What\'s the problem?'),
              ),
              Bubble(
                style: styleMe,
                nip: BubbleNip.no,
                margin: BubbleEdges.only(top: 2.0),
                child: Text(messageContent.toString()),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 450, 10, 5),
            child: TextFormField(
              controller: userMessageController,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.message,
                    size: 20,
                  ),
                  suffix: GestureDetector(
                    child: Icon(
                      Icons.send,
                      size: 20,
                    ),
                    onTap: () {
                      messageContent = userMessageController.text;
                    },
                  )),
            ),
          )
        ]),
      ),
    );
  }
}
