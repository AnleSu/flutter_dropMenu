import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mynavigator/model/SearchParamModel.dart';



class DropMenuRightWidget extends StatefulWidget {
  final AsyncSnapshot paramList;
  DropMenuRightWidget({
    this.paramList,
  });
  
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _dropMenuRightWidgetState();
  }
}

class _dropMenuRightWidgetState extends State<DropMenuRightWidget> {
  
  
  @override
  Widget buildButton(String title, VoidCallback onPressed,
      {bgColor = Colors.white, Color titleColor, double height = 32,}) {
    titleColor = titleColor ?? Color(0xFF333333);
    bool selected = false;
    return Container(
      height: height,
//      margin: EdgeInsets.only(left: 20, right: 20),
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            setState(() {
              selected = !selected;
            });
            
            onPressed ?? onPressed();
          },
          child: Text(
            title,
            style: TextStyle(color: selected ? Color(0xFFF12E49) : titleColor),
          )),
//      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: selected ? Color(0xFFF12E49) : Color(0xFFDDDDDD), width: 1)),
    );
  }

  Widget buildTitle(String title) {
    return Container(
      height: 44,
      alignment: Alignment(-1, 0.2),
      padding: EdgeInsets.only(left: 0),
      child: Text(title),
    );
  }

  Widget buildItem(SearchParamModel model) {
    return Column(
      children: <Widget>[
        buildTitle(model.paramName),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 10,
          spacing: 16,
          children: List.generate(
            model.itemList.length, 
            (i) => buildButton(model.itemList[i].name, null)
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    SearchParamList data = widget.paramList.data;
    return Container(
      color: Colors.white,
      child: ListView(
      padding: EdgeInsets.only(left: 30, top: 9, right: 30),
      children: List.generate(
        data.list.length, 
        (i) => Container(
          
          child: buildItem(data.list[i]),
        )),
    ),
    );
    
    // TODO: implement build
    // return Positioned(
    //     child: Container(
    //   color: Colors.white,
    //   width: double.infinity,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.min,
    //     children: <Widget>[
    //       this.buildTitle('优惠活动'),
    //       Container(
    //         padding: EdgeInsets.only(left: 20, right: 20),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             buildButton('团购券', null),
    //             buildButton('支付优惠', null),
    //             buildButton('代金券', null)
    //           ],
    //         ),
    //       ),
    //       this.buildTitle('筛选时间名称'),
    //       Container(
    //         width: double.infinity,
    //         padding: EdgeInsets.only(left: 20, right: 20),
    //         child: Wrap(
    //           alignment: WrapAlignment.spaceBetween,
    //           runSpacing: 10,
    //           children: <Widget>[
    //             buildButton('今天', null),
    //             buildButton('近2天', null),
    //             buildButton('近7天', null),
    //             buildButton('近15天', null),
    //           ],
    //         ),
    //       ),
    //       Container(
    //         width: double.infinity,
    //         padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
    //         child: Row(
    //           children: <Widget>[
    //             Expanded(child: buildButton('自定义日期', null)),
    //             FlatButton(onPressed: null, child: Text('清空'))
    //           ],
    //         ),
    //       ),
    //       Container(
    //         height: 1,
    //         color: Colors.grey,
    //         margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
    //       ),
    //       Container(
    //         width: double.infinity,
    //         padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Expanded(child: buildButton('重置', null, height: 40)),
    //             Container(
    //               width: 10,
    //             ),
    //             Expanded(
    //                 child: buildButton('确定', null,
    //                     height: 40,
    //                     bgColor: Colors.red,
    //                     titleColor: Colors.white)),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // ));
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
