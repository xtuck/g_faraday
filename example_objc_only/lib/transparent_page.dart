import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransparentPage extends StatefulWidget {
  @override
  _TransparentPageState createState() => _TransparentPageState();
}

class _TransparentPageState extends State<TransparentPage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    // Future.microtask(
    //   () => setState(() {
    //   }),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        return true;
      },
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          child: Container(
            color: Color.fromRGBO(0, 0, 0, 0.7),
            child: Center(child: Text("多页面测试"),),
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
