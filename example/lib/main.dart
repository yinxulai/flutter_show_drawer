import 'package:flutter/material.dart';
import 'package:show_drawer/show_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'showOverlay example',
      home: Scaffold(body: Body()),
      showPerformanceOverlay: true,
    );
  }
}

class Body extends StatelessWidget {
  get testCard {
    return Container(
      height: 120,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () => showDrawer(
              context: context,
              builder: (_, __, ___) => testCard,
              alignment: Alignment.bottomCenter,
            ),
            child: Text('bottomCenter'),
          ),
          RaisedButton(
            onPressed: () => showDrawer(
              context: context,
              builder: (_, __, ___) => testCard,
              alignment: Alignment.bottomLeft,
            ),
            child: Text('bottomLeft'),
          ),
          RaisedButton(
            onPressed: () => showDrawer(
              context: context,
              builder: (_, __, ___) => testCard,
              alignment: Alignment.bottomRight,
            ),
            child: Text('bottomRight'),
          ),
          RaisedButton(
            onPressed: () => showDrawer(
              context: context,
              builder: (_, __, ___) => testCard,
              alignment: Alignment.center,
            ),
            child: Text('center'),
          ),
          RaisedButton(
            onPressed: () => showDrawer(
              context: context,
              builder: (_, __, ___) => testCard,
              alignment: Alignment.centerLeft,
            ),
            child: Text('centerLeft'),
          ),
          RaisedButton(
            onPressed: () => showDrawer(
              context: context,
              builder: (_, __, ___) => testCard,
              alignment: Alignment.centerRight,
            ),
            child: Text('centerRight'),
          ),
          RaisedButton(
            onPressed: () => showDrawer(
              context: context,
              builder: (_, __, ___) => testCard,
              alignment: Alignment.topCenter,
            ),
            child: Text('topCenter'),
          ),
          RaisedButton(
            onPressed: () => showDrawer(
              context: context,
              builder: (_, __, ___) => testCard,
              alignment: Alignment.topLeft,
            ),
            child: Text('topLeft'),
          ),
          RaisedButton(
            onPressed: () => showDrawer(
              context: context,
              builder: (_, __, ___) => testCard,
              alignment: Alignment.topRight,
            ),
            child: Text('topRight'),
          ),
        ],
      ),
    );
  }
}
