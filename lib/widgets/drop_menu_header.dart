import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'drop_menu_leftWidget.dart';

typedef FilterBarCallback = void Function(bool isSelected);

class DropMenuHeader extends StatefulWidget implements PreferredSizeWidget {
  DropMenuHeader({
    @required this.height,
    @required this.leftTitle,
    @required this.rightTitle,
    this.leftTap,
    this.rightTap,
    this.hasData,
    this.onPressedFilter,
    this.onPressedSort,
  });

  double height;
  String leftTitle;
  final String rightTitle;
  final Function leftTap;
  final Function rightTap;
  bool hasData; //筛选里面是否有选中项
  final FilterBarCallback onPressedSort;
  final FilterBarCallback onPressedFilter;
  Size get preferredSize => Size.fromHeight(height);

  @override
  _dropMenuHeaderState createState() {
    // TODO: implement createState
    return new _dropMenuHeaderState();
  }
}

class TextIconButton extends StatefulWidget {
  final String text;
  final Function onTap;
  final Color normalColor;
  final Color selectedColor;
  // bool selected;
  bool dataSelected;
  final double radius;

  TextIconButton({
    Key key,
    this.text,
    this.onTap,
    this.normalColor,
    this.selectedColor,
    // this.selected: false,
    this.radius = 0.0,
    this.dataSelected: false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _textIconButton();
  }
}

class _textIconButton extends State<TextIconButton> {
  String imageName = 'images/mmc_dropMenu_up_normal@2x.png';
  bool selected = false;
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    if (selected == true) {
      imageName = widget.dataSelected
          ? 'images/mmc_dropMenu_down_red@2x.png'
          : 'images/mmc_dropMenu_down_normal@2x.png';
    } else {
      imageName = widget.dataSelected
          ? 'images/mmc_dropMenu_up_red@2x.png'
          : 'images/mmc_dropMenu_up_normal@2x.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(0),
        height: 44,
        child: GestureDetector(
          onTap: () {
            this.widget.onTap();
            setState(() {
              selected = !selected;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.dataSelected
                      ? Color(0xFFF12E49)
                      : Color(0xFF333333),
                  fontSize: 14,
                ),
              ),
              Image(
                image: AssetImage(imageName),
                width: 10,
                height: 10,
              ),
            ],
          ),
        ));
  }
}

class _dropMenuHeaderState extends State<DropMenuHeader> {
  bool sortSelected = false;
  bool filterSelected = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NotificationListener(
      onNotification: (event) {
        if (event is DropMenuLeftSelectedNoti) {
          setState(() {
            widget.leftTitle = (event as DropMenuLeftSelectedNoti).selectedCode;
          });
        }
      },
      child: Container(
        height: widget.height,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: TextIconButton(
                    
                      text: widget.leftTitle,
                      onTap: () {
                        this.widget.leftTap;
                        this.widget.onPressedSort(!sortSelected);
                      }),
                ),
                Container(
                  color: Color(0xFFE5E5E5),
                  width: 1,
                  height: widget.height.toDouble(),
                ),
                Expanded(
                  child: TextIconButton(
                      text: widget.rightTitle,
                      onTap: () {
                        this.widget.rightTap;
                        this.widget.onPressedFilter(!filterSelected);
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
