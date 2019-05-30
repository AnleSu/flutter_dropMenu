import 'dart:convert';
import 'package:flutter/material.dart';

class DropMenuLeftWidget extends StatefulWidget {
  List dataSource = [];
  String selectedItem;
  DropMenuLeftWidget({
    Key key,
    this.dataSource,
    this.selectedItem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _dropMenuLeftWidgetState();
  }
}

class DropMenuLeftSelectedNoti extends Notification {
  final String selectedCode;
  final String selectedName;
  DropMenuLeftSelectedNoti(this.selectedCode, this.selectedName);
}

class _dropMenuLeftWidgetState extends State<DropMenuLeftWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 300,
      child: (getListView()),
    );
  }

  Widget getTrailing(String name) {
    if (name == this.widget.selectedItem) {
      return Image(
        image: new AssetImage('images/mmc_dropMenu_check_selected@2x.png'),
        // trailing: Icon(Icons.computer),
      );
    } else {}
  }

  Widget getRow(int i) {
    return new GestureDetector(
      onTap: () {
        setState(() {
          widget.selectedItem = widget.dataSource[i];
          DropMenuLeftSelectedNoti(widget.dataSource[i], widget.dataSource[i]).dispatch(context);
        });
        
      },
      child: new Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 30, top: 15),
              child: (ListTile(
                  title: Text("${widget.dataSource[i]}"),
                  trailing: getTrailing(widget.dataSource[i])))),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }

  ListView getListView() => ListView.builder(
        // itemExtent: 50,
        itemCount: widget.dataSource.length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        },
      );
}
