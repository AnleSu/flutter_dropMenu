import 'package:flutter/material.dart';

typedef FilterBarCallback = void Function(bool isSelected);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showPop = false;

  void _showPopView() {
    setState(() {
      _showPop = !_showPop;
    });
  }

  Widget buildButton(String title, VoidCallback onPressed,
      {bgColor = Colors.white, Color titleColor, double height = 30}) {
    titleColor = titleColor ?? Colors.grey.shade800;
    return Container(
      height: height,
//      margin: EdgeInsets.only(left: 20, right: 20),
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            onPressed ?? onPressed();
          },
          child: Text(
            title,
            style: TextStyle(color: titleColor),
          )),
//      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.red, width: 1)),
    );
  }

  Widget buildTitle(String title) {
    return Container(
      height: 44,
      alignment: Alignment(-1, 0.2),
      padding: EdgeInsets.only(left: 20),
      child: Text(title),
    );
  }

  Widget buildPopView() {
    return Positioned(
        child: Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          this.buildTitle('优惠活动'),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildButton('团购券', null),
                buildButton('支付优惠', null),
                buildButton('代金券', null)
              ],
            ),
          ),
          this.buildTitle('筛选时间名称'),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 10,
              children: <Widget>[
                buildButton('今天', null),
                buildButton('近2天', null),
                buildButton('近7天', null),
                buildButton('近15天', null),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(child: buildButton('2018/11/11~2018/11/12', null)),
                FlatButton(onPressed: null, child: Text('清空'))
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey,
            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: buildButton('重置', null, height: 40)),
                Container(
                  width: 10,
                ),
                Expanded(
                    child: buildButton('确定', null,
                        height: 40, bgColor: Colors.red, titleColor: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget buildBody() {
    return Center(
      child: Text(
        'You have pushed the button this many times:',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        appBar: AppBar(
            title: Text('简直懒死了'),
            bottom: FilterBar(
              onPressedFilter: (bool selected) {
                this._showPopView();
              },
              onPressedSort: (bool selected) {},
            )),
        body: _showPop
            ? Stack(
                children: <Widget>[
                  this.buildBody(),
                  Positioned(
                      child: Container(
                    color: Colors.black.withAlpha(80),
                  )),
                  this.buildPopView(),
                ],
              )
            : this.buildBody() // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class FilterBar extends StatefulWidget implements PreferredSizeWidget {
  FilterBar({@required this.onPressedSort, @required this.onPressedFilter});

  final FilterBarCallback onPressedSort;
  final FilterBarCallback onPressedFilter;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(40);

  @override
  _FilterBarState createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  bool sortSelected = false;
  bool filterSelected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              child: FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    this.widget.onPressedSort(!sortSelected);
                    this.setState(() {
                      sortSelected = !sortSelected;
                    });
                  },
                  child: Text(
                    '综合排序',
                    style: TextStyle(color: sortSelected ? Colors.red : Colors.grey.shade800),
                  ))),
          Container(
            color: Colors.grey,
            width: 0.5,
            height: 40,
          ),
          Expanded(
              child: FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    this.widget.onPressedFilter(!filterSelected);
                    this.setState(() {
                      filterSelected = !filterSelected;
                    });
                  },
                  child: Text(
                    '筛选',
                    style: TextStyle(color: filterSelected ? Colors.red : Colors.grey.shade800),
                  ))),
        ],
      ),
    );
  }
}
