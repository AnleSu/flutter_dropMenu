import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mynavigator/model/SearchParamModel.dart';

typedef DropMenuRightCallback = void Function(SearchParamModel model, ParamItemModel item);

class DropMenuRightWidget extends StatefulWidget {
  final AsyncSnapshot paramList;
  DropMenuRightCallback clickCallBack;
  DropMenuRightWidget({
    this.paramList,
    this.clickCallBack,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _dropMenuRightWidgetState();
  }
}

class _dropMenuRightWidgetState extends State<DropMenuRightWidget> {
  @override
  Widget buildButton(
    SearchParamModel model,
    ParamItemModel item,
    // VoidCallback onPressed, 
    {
    bgColor = Colors.white,
    Color titleColor,
    double height = 32,
  }) {
    titleColor = titleColor ?? Color(0xFF333333);
    bool selected = false;
    return Container(
      height: height,
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            widget.clickCallBack(model, item);

            // onPressed ?? onPressed();
          },
          child: Text(
            item.name,
            style: TextStyle(color: selected ? Color(0xFFF12E49) : titleColor),
          )),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(
              color: selected ? Color(0xFFF12E49) : Color(0xFFDDDDDD),
              width: 1)),
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

  double _screenWidth;

  Widget buildItem(SearchParamModel model) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    return Column(
      // shrinkWrap: true,
      children: <Widget>[
        buildTitle(model.paramName),
        Container(
            child: 
            Wrap(
              alignment: WrapAlignment.start,
              // runAlignment: WrapAlignment.start,
              runSpacing: 10,
              spacing: 16,
              children: List.generate(model.itemList.length, (i) {
                ParamItemModel item = model.itemList[i];
                if (item.name == "自定义时间") {
                  return Container(
                    margin: EdgeInsets.only(top: 0),
                    padding:
                        EdgeInsets.only(left: 0, right: 20, top: 0, bottom: 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(child: buildButton(model, item)),
                        FlatButton(
                            onPressed: null,
                            child: Text(
                              '清空',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff4A90E2)),
                            ))
                      ],
                    ),
                  );
                } else {
                  return buildButton(model, item);
                }
              }),
            ),
            ),
      ],
    );
  }

  Widget build(BuildContext context) {
    SearchParamList data = widget.paramList.data;

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Flexible(
            child:    Container(
            margin: EdgeInsets.only(left: 30,right: 30,top: 9),
            child: Wrap(
              
               children: List.generate(
                data.list.length,
                (i) => Container(
                      child: buildItem(data.list[i]),
                    )),
            ),
          ),
          ),
       
          Container(
            height: 1,
            color: Color(0xfff0f0f0),
            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Container(
                  height: 42,
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          // selected = !selected;
                        });

                        // onPressed ?? onPressed();
                      },
                      child: Text(
                        "重置",
                        style:
                            TextStyle(color: Color(0xFF666666), fontSize: 16),
                      )),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      border: Border.all(color: Color(0xFFDDDDDD), width: 1)),
                )),
                Container(
                  width: 11,
                ),
                Expanded(
                    child: Container(
                  height: 42,
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          // selected = !selected;
                        });

                        // onPressed ?? onPressed();
                      },
                      child: Text(
                        "查看xxx个结果",
                        style:
                            TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                      )),
                  decoration: BoxDecoration(
                    color: Color(0xFFF12E49),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
