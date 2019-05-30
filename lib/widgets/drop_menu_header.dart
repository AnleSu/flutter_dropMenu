import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DropMenuHeader extends StatefulWidget {
  DropMenuHeader({
    @required this.height,
    @required this.leftTitle,
    @required this.rightTitle,
    this.leftTap,
    this.rightTap,
    this.hasData,
  });

  int height;
  final String leftTitle;
  final String rightTitle;
  final Function leftTap;
  final Function rightTap;
  bool hasData; //筛选里面是否有选中项
  @override
  _dropMenuHeaderState createState() {
    // TODO: implement createState
    return new _dropMenuHeaderState();
  }
}

class TextIconButton extends StatefulWidget {
  final Image icon;
  final String text;
  final Function onTap;
  final Color normalColor;
  final Color selectedColor;
  // bool selected;
  bool dataSelected;
  final double radius;

  TextIconButton({
    Key key,
    this.icon,
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
    Widget w = ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: Material(
        elevation: 0.0,
        child: InkWell(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 12),
              ),
              Row(
                children: <Widget>[
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: widget.dataSelected
                          ? Color(0xFFF12E49)
                          : Color(0xFF333333),
                    ),
                  ),
                  Image(image: AssetImage(imageName)),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
              ),
            ],
          ),
          onTap: () {
            
            this.widget.onTap();
            setState(() {
              selected = !selected;
              // widget.dataSelected = !widget.dataSelected;
              // if (widget.selected = true) {
              //   imageName = widget.dataSelected
              //       ? 'images/mmc_dropMenu_down_red@2x.png'
              //       : 'images/mmc_dropMenu_down_normal@2x.png';
              // } else {
              //   imageName = widget.dataSelected
              //       ? 'images/mmc_dropMenu_up_red@2x.png'
              //       : 'images/mmc_dropMenu_up_normal@2x.png';
              // }
            });
          },
        ),
      ),
    );

    return w;
  }
}

class _dropMenuHeaderState extends State<DropMenuHeader> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 44, top: 12),
        ),
        TextIconButton(
          text: widget.leftTitle,
          icon: Image.asset("images/mmc_dropMenu_up_normal@2x.png"),
          onTap: this.widget.leftTap,
        ),
        Container(
          color: Color(0xFFE5E5E5),
          width: 1,
          height: widget.height.toDouble(),
          margin: EdgeInsets.only(left: 44, top: 0, right: 67),
        ),
        // Padding(
        //         padding: EdgeInsets.only(left: 112, top: 13),
        //       ),
        TextIconButton(
          text: widget.rightTitle,
          icon: Image.asset("images/mmc_dropMenu_up_normal@2x.png"),
          onTap: this.widget.rightTap,
        ),
      ],
    );
  }
}
