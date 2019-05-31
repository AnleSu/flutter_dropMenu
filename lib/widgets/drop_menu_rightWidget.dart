import 'dart:convert';
import 'package:flutter/material.dart';

class DropMenuRightWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _dropMenuRightWidgetState();
  }
}

class _dropMenuRightWidgetState extends State<DropMenuRightWidget> {
  List data;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Positioned(
      height: 500,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int position) {
          return ItemContainer('筛选项', data);
        },
      ),
    );
  }
}

Widget ItemContainer(String title, List data) {
  return Container(
    child: Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF333333),
          ),
        ),
        GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          children: <Widget>[
            Icon(Icons.ac_unit),
            Icon(Icons.airport_shuttle),
            Icon(Icons.all_inclusive),
          ],
        )
      ],
    ),
  );
}
