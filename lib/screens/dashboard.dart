import 'package:BCB/screens/onlineBot.dart';
import 'package:BCB/screens/seeAll.dart';
import 'package:BCB/screens/services.dart';
import 'package:BCB/screens/transfers.dart';
import 'package:BCB/services/airtime.dart';
import 'package:BCB/utilities/themeColors.dart';
import 'package:BCB/utilities/themeStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:BCB/generated/l10n.dart';


class DashboardHome extends StatelessWidget {
  const DashboardHome({Key key, this.account_number, this.account_balance, this.customer_first_name, this.customer_last_name, this.account_type, this.customer_title, this.customer_created}) : super(key: key);
  final String account_number;
  final String account_balance;

  final String customer_first_name;
  final String customer_last_name;
  final String account_type;
  final String customer_title;
  final String customer_created;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Dashboard(
        account_number: account_number,
        account_balance: account_balance,
        customer_first_name: customer_first_name,
        customer_last_name: customer_last_name,
        account_type: account_type,
        customer_title: customer_title,
        customer_created: customer_created,
      ),
    );
  }
}




class Dashboard extends StatefulWidget {
  const Dashboard(
      {Key key,
      this.account_number,
      this.account_balance,
      this.customer_first_name,
      this.customer_last_name,
      this.account_type,
      this.customer_title, this.customer_created})
      : super(key: key);
  final String account_number;
  final String account_balance;

  final String customer_first_name;
  final String customer_last_name;
  final String account_type;
  final String customer_title;
  final String customer_created;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List cardList = [
    Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'RoboBank',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                icon: SvgPicture.asset('assets/analytics-icon.svg'),
                onPressed: null,
              ),
              IconButton(
                icon: SvgPicture.asset('assets/search-icon.svg'),
                onPressed: null,
              ),
              IconButton(
                icon: SvgPicture.asset('assets/more-icon.svg'),
                onPressed: null,
              )
            ],
          )
        ],
      ),
    )
  ];

  int _currentCard = 0;

  final PageController _pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentCard = index;
    });
  }

  void initState() {
    setState(() {
      print(widget.customer_first_name);
      print(widget.customer_last_name);

      print(widget.account_number);
      print(widget.account_type);
      print(widget.account_balance);
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      body: SafeArea(
        child: Container(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 5.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Robo Holdings Zimbabwe',
                        style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 80,),
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
                      Container(
                        height: 210.0,
                        child: PageView.builder(
                          itemCount: cardList.length,
                          scrollDirection: Axis.horizontal,
                          controller: _pageController,
                          onPageChanged: _onPageChanged,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 180,
                              width: 380,
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0,
                                        vertical: 20.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.account_balance+'.00'+' RTGS',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87)),
                                          Text(widget.customer_title+' '+widget.customer_first_name+' '+widget.customer_last_name+'\n'+S.of(context).account_type+' '+widget.account_type,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 24.0,
                                        bottom: 32.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(S.of(context).card_number,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black87)),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 6.0),
                                                child: Text(
                                                    widget.account_number,
                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 50),
                                                child: Text(S.of(context).created_on+': '+widget.customer_created, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          height: 110,
                          width: 370,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.white,
                                                child: Text('T',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.green)),
                                              ),
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                    builder: (_) => TransfersPage(
                                                      account_number: widget
                                                          .account_number,
                                                    )));
                                              },
                                            ),
                                            Text(
                                              S.of(context).transfers,
                                              style: TextStyle(
                                                  fontSize: 13, color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.white,
                                                child: Text('A',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                        color:
                                                        Colors.deepOrangeAccent)),
                                              ),
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                    builder: (_) => Airtime(
                                                      account_number: widget
                                                          .account_number,
                                                    )));
                                              },
                                            ),
                                            Text(
                                              S.of(context).airtime,
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.white,
                                                child: Text(
                                                  'S',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                    builder: (_) => Services(
                                                      account_number: widget
                                                          .account_number,
                                                    )));
                                              },
                                            ),
                                            Text(
                                              S.of(context).services,
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.white,
                                                child: Text(
                                                  'C',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.blueGrey),
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                    builder: (_) => OnlineBot(
                                                      account_number: widget
                                                          .account_number,
                                                      title: widget
                                                          .customer_title,
                                                      customer_first_name: widget
                                                          .customer_first_name,
                                                      customer_last_name: widget
                                                          .customer_last_name,
                                                    )));
                                              },
                                            ),
                                            Text(
                                              S.of(context).chatbot,
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 16.0,
                          top: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).recent_transactions,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            GestureDetector(
                              child: Text('See All', style: ThemeStyles.seeAll),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SeeALL()));
                              },
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                child: Text(
                                  'E',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text('Account Credited',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                              trailing: Text('500.00 RTGS',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text('Received From Nyasha',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/tre.jfif"),
                fit: BoxFit.cover,
              ),
            )),
      ),
      //backgroundColor: Colors.green[200],
    );
  }
}

class DotIndicator extends StatefulWidget {
  final bool isActive;
  DotIndicator(this.isActive);
  @override
  _DotIndicatorState createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: widget.isActive ? ThemeColors.black : ThemeColors.grey,
        ),
      ),
    );
  }
}
