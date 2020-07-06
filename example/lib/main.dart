import 'package:flutter/material.dart';
import 'package:show_drawer/show_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'showDrawer example',
      home: Scaffold(body: Body()),
      // showPerformanceOverlay: true,
    );
  }
}

class OverlayBox extends StatelessWidget {
  final Widget child;
  OverlayBox({this.child});

  @override
  Widget build(Object context) {
    return Container(
      color: Colors.grey[200],
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (_) => child,
          ),
        ],
      ),
    );
  }
}

class Test extends StatelessWidget {
  final String title;
  Test({this.title});

  generateRaisedButton(
    String title,
    DrawerDirection direction,
    BuildContext context,
  ) {
    return Expanded(
      child: RaisedButton(
        child: Text(title),
        onPressed: () => showDrawer(
          barrier: true,
          context: context,
          direction: direction,
          barrierDismissible: true,
          builder: (_, __, close) => Container(
            width: 300,
            height: 200,
            child: Center(
              child: RaisedButton(
                onPressed: close,
                child: Text('close'),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Center(
        child: Column(
          children: [
            Text(title),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              generateRaisedButton(
                "topLeft",
                DrawerDirection.topLeft,
                context,
              ),
              generateRaisedButton(
                "topCenter",
                DrawerDirection.topCenter,
                context,
              ),
              generateRaisedButton(
                "topRight",
                DrawerDirection.topRight,
                context,
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              generateRaisedButton(
                "centerLeft",
                DrawerDirection.centerLeft,
                context,
              ),
              generateRaisedButton(
                "centerRight",
                DrawerDirection.centerRight,
                context,
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              generateRaisedButton(
                "bottomLeft",
                DrawerDirection.bottomLeft,
                context,
              ),
              generateRaisedButton(
                "bottomCenter",
                DrawerDirection.bottomCenter,
                context,
              ),
              generateRaisedButton(
                "bottomRight",
                DrawerDirection.bottomRight,
                context,
              ),
            ])
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Test(
              title: "Global",
            ),
          ),
          Expanded(
            child: OverlayBox(
              child: Test(
                title: "Local",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
