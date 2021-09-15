import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_faraday/g_faraday.dart';
import 'package:g_faraday_obj_demo/transparent_page.dart';







void main() {
  runApp(DemoApp());
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => faraday.wrapper(
        (settings) => MaterialPageRoute(
          builder: (context) {
            if (settings.name == "home") {
              return Scaffold(
                body: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: TextButton(
                      child: Text('pop'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              );
            }
            return TransparentPage();
          }
        ),
      ),
    );
  }
}
