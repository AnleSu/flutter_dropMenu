import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mynavigator/widgets/drop_menu_header.dart';
import 'package:http/http.dart' as http;
import 'dart:isolate';
import 'dart:convert';
import 'drop_menu_leftWidget.dart';

class DropMenu extends StatefulWidget {
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

class _dropMenuState  extends State<DropMenu> {
  List leftWidgets = ["最早预约日期","最晚预约日期","最早完成日期","最晚完成日期"];
  String leftSelectedStr = '最早完成日期';
  bool leftClick = false;
  bool rightClick = false;
  getProgressDialog() {
    return Center(child: CircularProgressIndicator());
  }

  void initState() {
      super.initState();

      // loadData();
    }

  getBody() {
    if (leftClick) {
        return DropMenuLeftWidget(dataSource: leftWidgets, selectedItem: leftSelectedStr,);
  
      } else if(rightClick){
        return getListView();
      } else {
        // return DropMenuLeftWidget(dataSource: leftWidgets);
      }
  }
  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return NotificationListener(
      onNotification: (event) {
        if(event is DropMenuLeftSelectedNoti) {
          setState(() {
            leftSelectedStr = (event as DropMenuLeftSelectedNoti).selectedCode;
          });
          
        }
      },
      child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        DropMenuHeader(
          height: 44,
          leftTitle: leftSelectedStr,
          rightTitle: '筛选',
          leftTap: () {
            print('left tap');
            setState(() {
              leftClick = !leftClick;
              if(rightClick == true) {
                rightClick = false;
              }
              getBody();
            });
            
          },
          rightTap:() {

          },
        ),
        Divider(
          height: 1,
        ),
        Container(
          child: getBody(),
        ),
      ],
    ),
    );
    
  }

  Widget getRow(int i) {
    return Padding (
      padding: EdgeInsets.all(10),
      child: Text("Row ${leftWidgets[i]["title"]}"),
    );
  }

  ListView getListView() => ListView.builder(
      itemCount: leftWidgets.length,
      itemBuilder: (BuildContext context, int position) {
          return getRow(position);
      },
  );


  _getListData() {
      List<Widget> widgets = [];
      for(int i = 0; i < 100; i++) {
        widgets.add(GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('row $i'),  
          ),
          onTap: () {
            // Navigator.pushNamed(context, "new_router");
            // Navigator.push(context, 
            //   new MaterialPageRoute(builder: (context){
            //     return new NewRoute();
            //   }, fullscreenDialog: true)
            // );
          },
        ));
      }
      return widgets;
  }

  loadData() async {
    // String dataUrl = "https://jsonplaceholder.typicode.com/posts";
    // http.Response response = await http.get(dataUrl);
    // setState(() {
    //   widgets = json.decode(response.body);
    // });
    ReceivePort port = ReceivePort();
    await Isolate.spawn(dataLoader, port.sendPort);

    SendPort sendPort = await port.first;
     
    List msg = await sendReceiver(sendPort, "https://jsonplaceholder.typicode.com/posts");
    setState(() {
      leftWidgets = msg;
    });
  }

  static dataLoader(SendPort sendPort) async {
    ReceivePort port = ReceivePort();

    sendPort.send(port.sendPort);

    await for (var msg in port) {
      String data = msg[0];
      SendPort replyTo = msg[1];

      String dataURL = data;
      http.Response response = await http.get(dataURL);
      replyTo.send(json.decode(response.body));
    }
  }

  Future sendReceiver(SendPort port, msg) {
    ReceivePort response = ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }
  
}

