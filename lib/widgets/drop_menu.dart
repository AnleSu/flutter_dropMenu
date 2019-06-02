import 'dart:convert';
import 'package:flutter/material.dart';
import 'drop_menu_header.dart';
import 'dart:isolate';
import 'dart:convert';
import 'drop_menu_leftWidget.dart';
import 'drop_menu_rightWidget.dart';



class DropMenu extends StatefulWidget implements PreferredSizeWidget {
  Size get preferredSize => Size.fromHeight(40);
  DropMenu({
    Key key,
    this.leftDataSource,
    this.rightDataSource,
    
  }) : super(key: key);

  List leftDataSource = [];
  List rightDataSource = [];
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _dropMenuState();
  }
}

class _dropMenuState extends State<DropMenu> {
  List leftWidgets = ["最早预约日期", "最晚预约日期", "最早完成日期", "最晚完成日期"];
  String leftSelectedStr = '最早完成日期';
  bool leftClick = false;
  bool rightClick = false;

  void initState() {
    super.initState();

    // loadData();
  }

  getBody() {
    if (leftClick) {
      return DropMenuLeftWidget(
        dataSource: leftWidgets,
        selectedItem: leftSelectedStr,
      );
    } else if (rightClick) {
      return DropMenuRightWidget();
    } else {
      // return DropMenuLeftWidget(dataSource: leftWidgets);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NotificationListener(
      onNotification: (event) {
        if (event is DropMenuLeftSelectedNoti) {
          setState(() {
            leftSelectedStr = (event as DropMenuLeftSelectedNoti).selectedCode;
          });
        }
      },
      child: DropMenuHeader(
        
        height: 44,
        leftTitle: leftSelectedStr,
        rightTitle: '筛选',
        leftTap: () {
          print('left tap');
          setState(() {
            leftClick = !leftClick;
            if (rightClick == true) {
              rightClick = false;
            }
            getBody();
          });
        },
        rightTap: () {
          print('right tap');
          setState(() {
            rightClick = !rightClick;
            if (leftClick == true) {
              leftClick = false;
            }
            getBody();
          });
        },
      ),
    );
  }


 

}
