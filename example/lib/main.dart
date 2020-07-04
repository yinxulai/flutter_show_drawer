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
    Alignment alignment,
    BuildContext context,
  ) {
    return Expanded(
      child: RaisedButton(
        child: Text(title),
        onPressed: () => showDrawer(
          barrier: true,
          context: context,
          alignment: alignment,
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
              generateRaisedButton("topLeft", Alignment.topLeft, context),
              generateRaisedButton("topCenter", Alignment.topCenter, context),
              generateRaisedButton("topRight", Alignment.topRight, context),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              generateRaisedButton("centerLeft", Alignment.centerLeft, context),
              generateRaisedButton("center", Alignment.center, context),
              generateRaisedButton(
                  "centerRight", Alignment.centerRight, context),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              generateRaisedButton("bottomLeft", Alignment.bottomLeft, context),
              generateRaisedButton(
                  "bottomCenter", Alignment.bottomCenter, context),
              generateRaisedButton(
                  "bottomRight", Alignment.bottomRight, context),
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
