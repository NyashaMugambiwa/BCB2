import 'package:flutter/material.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({Key key}) : super(key: key);

  @override
  _SeeAllState createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hameno'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('ksksk')
          ],
        ),
      ),
    );
  }
}

class SeeALL extends StatelessWidget {
  const SeeALL({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hameno'),
      ),
      body: Container(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
          home: Column(
            children: [
              Text('ksksk')
            ],
          )
        ),
      ),
    );
  }
}
