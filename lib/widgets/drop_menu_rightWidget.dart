import 'package:flutter/material.dart';
import 'package:mynavigator/model/SearchParamModel.dart';
import 'package:realank_flutter_bloc/realank_flutter_bloc.dart';
import 'drop_menu_bloc.dart';

typedef DropMenuRightCallback = void Function(
    SearchParamModel model, ParamItemModel item);

class DropMenuRightWidget extends StatefulWidget {
  final SearchParamList paramList;
  final DropMenuRightCallback clickCallBack;
  final VoidCallback resetFun;
  final VoidCallback sureFun;
  String resultCount;

  DropMenuRightWidget({
    this.paramList,
    this.clickCallBack,
    this.resetFun,
    this.sureFun,
    this.resultCount,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _dropMenuRightWidgetState();
  }
}

class _dropMenuRightWidgetState extends State<DropMenuRightWidget> {
  
  Widget buildButton(
    int modelIndex,
    int itemIndex,
    DropMenuRightCallback onPressed, {
    bgColor = Colors.white,
    Color titleColor,
    double height = 32,
  }) {
    titleColor = titleColor ?? Color(0xFF333333);
    SearchParamModel model = widget.paramList.list[modelIndex];
    ParamItemModel item = model.itemList[itemIndex];

    return RLKBLoCBuilder(
        builder: (BuildContext context, Map data, RLKBaseBLoC bloc) {
      DropMenuHeaderBLoC bloc2 = bloc as DropMenuHeaderBLoC;
      return Container(
        height: height,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              widget.clickCallBack(model, item);
              if (model.multiFlag == true) {

              } else {

                for (ParamItemModel itemModel in model.itemList) {
                  if (itemModel != item) {
                    itemModel.isSelected = false;
                  }
                  
                }
              }
              item.isSelected = !item.isSelected;
              setState(() {});
              onPressed ?? onPressed(model, item);
              bloc2.headerFilterData(_hasSelectedItem());
            },
            child: Text(
              item.name,
              style: TextStyle(
                  color: item.isSelected ? Color(0xFFF12E49) : titleColor),
            )),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(
                color: item.isSelected ? Color(0xFFF12E49) : Color(0xFFDDDDDD),
                width: 1)),
      );
    });
  }

  bool _hasSelectedItem () {
    for (SearchParamModel model in widget.paramList.list) {
      for (ParamItemModel item in model.itemList) {
        if(item.isSelected == true) {
          return true;
        }
      }
    }
    return false;
  }

  Widget buildTitle(String title) {
    return Container(
      height: 44,
      alignment: Alignment(-1, 0.2),
      padding: EdgeInsets.only(left: 0),
      child: Text(title),
    );
  }

  Widget buildItem(int i) {
    SearchParamModel model = widget.paramList.list[i];
    return Column(
      // shrinkWrap: true,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTitle(model.paramName),
        Container(
          child: Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 10,
            spacing: 16,
            children: List.generate(model.itemList.length, (j) {
              ParamItemModel item = model.itemList[j];
              if (item.name == "自定义时间") {
                return Container(
                  margin: EdgeInsets.only(top: 0),
                  padding:
                      EdgeInsets.only(left: 0, right: 20, top: 0, bottom: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                          child: buildButton(
                        i,
                        j,
                        (SearchParamModel pressModel,
                            ParamItemModel pressItem) {
                          print('${pressItem.name}');
                        },
                      )),
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
                return buildButton(
                  i,
                  j,
                  (SearchParamModel pressModel, ParamItemModel pressItem) {
                    print('${pressItem.name}');
                  },
                );
              }
            }),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 9),
              child: Wrap(
                alignment: WrapAlignment.start,
                children: List.generate(
                    widget.paramList.list.length,
                    (i) => Container(
                          child: buildItem(i),
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
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Container(
                  height: 42,
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        for (SearchParamModel model in widget.paramList.list) {
                          for (ParamItemModel item in model.itemList) {
                            item.isSelected = false;
                          }
                        }
                        setState(() {});
                        widget.resetFun();
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
                        setState(() {});
                        widget.sureFun();
                      },
                      child: Text(
                        widget.resultCount == null ? "确定" : "查看${widget.resultCount}个结果",
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
