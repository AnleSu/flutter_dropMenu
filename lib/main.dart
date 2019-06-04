// import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:convert';
import 'widgets/drop_menu.dart';
import 'widgets/drop_menu_leftWidget.dart';
import 'widgets/drop_menu_rightWidget.dart';
import 'widgets/drop_menu_header.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'package:mynavigator/model/SearchParamModel.dart';

Future<String> _loadAStudentAsset(BuildContext context) async {
  return await DefaultAssetBundle.of(context)
      .loadString('assets/searchParam.json');
}

Future loadStudent(BuildContext context) async {
  String jsonString = await _loadAStudentAsset(context);
  final jsonResponse = json.decode(jsonString);
  SearchParamList paramList = new SearchParamList.fromJson(jsonResponse);
  return paramList;
}

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "new_router": (context) => NewRoute(),
      },
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('new route'),
      ),
      body: Center(
        child: Text('this is a new route'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showPop = false;
  bool _showFilter = false;
  bool _showSort = false;

  List leftWidgets = ["最早预约日期", "最晚预约日期", "最早完成日期", "最晚完成日期"];
  String leftSelectedStr = '最早完成日期';

  void _showPopView() {
    setState(() {
      _showPop = !_showPop;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        bottom: DropMenuHeader(
          height: 44,
          leftTitle: '最早创建日期',
          rightTitle: '筛选',
          onPressedFilter: (bool selected) {
            _showFilter = selected;
            _showSort = false;
            _showPopView();
          },
          onPressedSort: (bool selected) {
            _showSort = selected;
            _showFilter = false;
            _showPopView();
          },
        ),
      ),
      body: _showPop
          ? Stack(
              children: <Widget>[
                buildBody(),
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      _showPopView();
                    },
                    child: Container(
                      color: Colors.black.withAlpha(70),
                    ),
                  ),
                ),
                buildPopView(),
              ],
            )
          : buildBody(),
      // body: DropMenu(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildPopView() {
    if (_showFilter) {
      return FutureBuilder (
        future: loadStudent(context),
        builder:(BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData ) {
            return DropMenuRightWidget(
              paramList: snapshot,
            );
          } else {
            return Text("data error");
          }
        },
      );
    } else if (_showSort) {
      return DropMenuLeftWidget(
        dataSource: leftWidgets,
        selectedItem: leftSelectedStr,
        onSelected: (String selectedItem, String paramCode) {
          DropMenuLeftSelectedNoti(selectedItem, paramCode).dispatch(context);
        },
      );
    } else {
      return null;
    }
  }

  Widget buildBody() {
    return Center(child: Text('这里放试驾单列表以及请求错误的失败页面以及无数据的空页面'));
  }
}
