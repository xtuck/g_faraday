import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettleSchoolItem extends StatelessWidget {
  final String title;
  final String subtitle;
  SettleSchoolItem(this.title,this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(fontSize: 14,color: Colors.black),),
        SizedBox(height: 5,),
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text(subtitle,style: TextStyle(fontSize: 12,color: Colors.black),),
        ),
        SizedBox(height: 15,),
      ],
    );
  }
}