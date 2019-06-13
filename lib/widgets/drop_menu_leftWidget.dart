import 'package:flutter/material.dart';

typedef DropMenuLeftCallback = void Function(SortModel model);

class SortModel {
  String name;
  bool isSelected;
  String code;
  SortModel({this.name, this.isSelected, this.code}) {}
}

class DropMenuLeftWidget extends StatefulWidget {
  List<SortModel> dataSource = [];
  final DropMenuLeftCallback onSelected;
  DropMenuLeftWidget({
    Key key,
    this.dataSource,
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
      height: widget.dataSource.length * 50.toDouble(),
      child: (getListView()),
    );
  }

  Widget getTrailing(SortModel model) {
    if (model.isSelected) {
      return Padding(
        padding: EdgeInsets.only(right: 15),
        child: Image(
          image: new AssetImage('resources/dropMenu_images/mmc_dropMenu_check_selected@2x.png'),
          width: 13,
          height: 10,
          // trailing: Icon(Icons.computer),
        ),
      );
    } else {}
  }

  Widget getRow(int i) {
    SortModel selectedModel = widget.dataSource[i];
    return new GestureDetector(
      onTap: () {
        setState(() {
          for (var value in widget.dataSource) {
            value.isSelected = false;
          }
          selectedModel.isSelected = true;
          widget.onSelected(selectedModel);
        });
      },
      child: new Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: (Container(
                  height: 49,
                  child: ListTile(
                    title: Text(
                      "${widget.dataSource[i].name}",
                      style: TextStyle(
                          color: selectedModel.isSelected
                              ? Color(0xFFF12E49)
                              : Color(0xFF333333),
                          fontSize: 14),
                    ),
                    trailing: getTrailing(widget.dataSource[i]),
                  )))),
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
