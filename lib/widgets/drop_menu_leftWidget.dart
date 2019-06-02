import 'dart:convert';
import 'package:flutter/material.dart';

typedef DropMenuLeftCallback = void Function(String selectedItem, String paramCode);

class DropMenuLeftWidget extends StatefulWidget {
  List dataSource = [];
  String selectedItem;
  final DropMenuLeftCallback onSelected;
  DropMenuLeftWidget({
    Key key,
    this.dataSource,
    this.selectedItem,
    this.onSelected,
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
      color: Colors.white,
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
          widget.onSelected(widget.dataSource[i], widget.dataSource[i]);
        });
        
      },
      child: new Column(
        
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 30,),
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
