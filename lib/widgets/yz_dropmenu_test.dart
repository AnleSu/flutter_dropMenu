import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:convert';
import 'dart:async' show Future;
import 'dart:async';

import 'package:mynavigator/model/SearchParamModel.dart';
import 'package:mynavigator/widgets/drop_menu_leftWidget.dart';
import 'package:mynavigator/widgets/drop_menu_rightWidget.dart';
import 'package:mynavigator/widgets/drop_menu_header.dart';
import 'package:mynavigator/widgets/drop_menu_bloc.dart';
import 'package:realank_flutter_bloc/realank_flutter_bloc.dart';

Future<String> _loadAStudentAsset(BuildContext context) async {
  return await DefaultAssetBundle.of(context)
      .loadString('assets/searchParam.json');
}

Future loadStudent(BuildContext context) async {
  String jsonString = await _loadAStudentAsset(context);
  final jsonResponse = json.decode(jsonString);
  SearchParamList paramList = new SearchParamList.fromJson(jsonResponse);
  for (SearchParamModel item in paramList.list) {
    if (item.dateFlag == true) {
      item.itemList.add(new ParamItemModel(
        name: "自定义时间",
        code: "-1",
      ));
    }
  }
  return paramList;
}

class TestPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showPop = false;
  bool _showFilter = false;
  bool _showSort = false;

  static List<SortModel> _leftWidgets = [
    SortModel(name: "最早预约日期", isSelected: false, code: "1"),
    SortModel(name: "最晚预约日期", isSelected: true, code: "2"),
    SortModel(name: "最早完成日期", isSelected: false, code: "5"),
    SortModel(name: "最晚完成日期", isSelected: false, code: "6")
  ];
  SortModel _leftSelectedModel = _leftWidgets[1];
  List<String> _dropDownHeaderItemStrings = [_leftWidgets[1].name, '筛选'];

  void _showPopView() {
    setState(() {
      _showPop = (_showFilter || _showSort);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return RLKBLoCProvider(
        bloc: DropMenuHeaderBLoC({
          "selectedIndex": 0,
          "filterData": false,
        }),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: DropMenuHeader(
              items: [
                ButtonModel(
                    text: _leftSelectedModel.name,
                    onTap: (bool selected) {
                      _showSort = selected;
                      _showFilter = false;

                      _showPopView();
                    }),
                ButtonModel(
                    text: _dropDownHeaderItemStrings[1],
                    onTap: (bool selected) {
                      _showFilter = selected;
                      _showSort = false;
                      _showPopView();
                    }),
              ],
              height: 44,
            ),
          ),
          body: _showPop
              ? Stack(
                  children: <Widget>[
                    buildBody(),
                    Positioned(child: RLKBLoCBuilder(builder:
                        (BuildContext context, Map data, RLKBaseBLoC bloc) {
                          DropMenuHeaderBLoC bloc2 = bloc as DropMenuHeaderBLoC;
                      return GestureDetector(
                        onTap: () {
                          bloc2.headerUnSelect(999);
                          _showFilter = false;
                          _showSort = false;
                          _showPopView();
                        },
                        child: Container(
                          color: Colors.black.withAlpha(70),
                        ),
                      );
                    })),
                    buildPopView(),
                  ],
                )
              : buildBody(),
        ));
  }

  Widget buildPopView() {
    if (_showFilter) {
      return FutureBuilder(
        future: loadStudent(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return DropMenuRightWidget(
              paramList: snapshot.data as SearchParamList,
              clickCallBack:
                  (SearchParamModel pressModel, ParamItemModel pressItem) {
                print('${pressItem.name}');
              },
              sureFun: () {
                print("sure click");
              },
              resetFun: () {
                print("reset click");
              },
            );
          } else {
            return Text("data error");
          }
        },
      );
    } else if (_showSort) {
      return DropMenuLeftWidget(
        dataSource: _leftWidgets,
        onSelected: (SortModel model) {
          _leftSelectedModel = model;
          print("select ${model.name}  ${model.code}");
          setState(() {});
        },
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }

  Widget buildBody() {
    return Center(child: Text('这里放试驾单列表以及请求错误的失败页面以及无数据的空页面'));
  }
}
