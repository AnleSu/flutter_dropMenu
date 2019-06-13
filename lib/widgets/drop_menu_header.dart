import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:realank_flutter_bloc/realank_flutter_bloc.dart';
import 'drop_menu_bloc.dart';

typedef FilterBarCallback = void Function(bool isSelected);

class DropMenuHeader extends StatefulWidget implements PreferredSizeWidget {
  DropMenuHeader({
    @required this.height,
    this.items,
  });

  double height;
  final List<ButtonModel> items;

  Size get preferredSize => Size.fromHeight(height);

  @override
  _dropMenuHeaderState createState() {
    // TODO: implement createState
    return new _dropMenuHeaderState();
  }
}

class ButtonModel {
  final String text;
  final Color normalColor;
  final Color selectedColor;
  String imageName;
  bool dataSelected;
  FilterBarCallback onTap;

  ButtonModel(
      {this.text,
      this.normalColor,
      this.selectedColor,
      this.imageName =
          "resources/dropMenu_images/mmc_dropMenu_up_normal@2x.png",
      this.dataSelected = false,
      this.onTap});
}

class _dropMenuHeaderState extends State<DropMenuHeader> {
  int _selectedIndex = 999;

  _button(ButtonModel buttonModel) {
    int index = widget.items.indexOf(buttonModel);

    return RLKBLoCBuilder(
        builder: (BuildContext context, Map data, RLKBaseBLoC bloc) {
          DropMenuHeaderBLoC bloc2 = bloc as DropMenuHeaderBLoC;
      if (data["selectedIndex"] == 999) {
        _selectedIndex = 999;
      }

      if(buttonModel.text == "筛选") {
        buttonModel.dataSelected = data["filterData"];
      }
      return Container(
          color: Colors.white,
          padding: EdgeInsets.all(0),
          height: 44,
          child: GestureDetector(
            onTap: () {
              if (_selectedIndex == index) {
                
                _selectedIndex = 999;
              } else {
                
                _selectedIndex = index;
              }
              bloc2.headerUnSelect(0);
              buttonModel.onTap(index == _selectedIndex);
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          buttonModel.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: buttonModel.dataSelected
                                ? buttonModel.selectedColor ?? Color(0xFFF12E49)
                                : buttonModel.normalColor ?? Color(0xFF333333),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Image(
                        image: AssetImage((index == _selectedIndex)
                            ? 'resources/dropMenu_images/mmc_dropMenu_down_normal@2x.png'
                            : 'resources/dropMenu_images/mmc_dropMenu_up_normal@2x.png'),
                        width: 10,
                        height: 10,
                        color: buttonModel.dataSelected
                            ? buttonModel.selectedColor ?? Color(0xFFF12E49)
                            : buttonModel.normalColor ?? Color(0xFF333333),
                      ),
                      index == widget.items.length - 1
                          ? Container()
                          : Container(
                              height: widget.height,
                              color: Color(0xFFE5E5E5),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ));
    });
  }

  double _screenWidth;
  int _menuCount;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _menuCount = widget.items.length;

    return Container(
      height: widget.height,
      child: GridView.count(
        crossAxisCount: _menuCount,
        //子Widget宽高比例
        childAspectRatio: (_screenWidth / _menuCount) / widget.height,
        children: widget.items.map<Widget>((item) {
          return _button(item);
        }).toList(),
      ),
    );
  }
}
