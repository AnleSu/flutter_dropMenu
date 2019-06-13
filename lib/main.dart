import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mynavigator/widgets/yz_dropmenu_test.dart';

main () async {
  // debugPaintSizeEnabled = true;      //打开视觉调试开关
  runApp(SALLearnFlutterApp());
} 


class SALLearnFlutterApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _sALLearnFlutterAppState();
}

class _sALLearnFlutterAppState extends State<SALLearnFlutterApp> {

  @override
  void initState() {
    super.initState();

    // FlutterBoost.singleton.registerPageBuilders({
    //   'sample://firstPage': (pageName, params, _) => FirstRouteWidget(),
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestPage(),
      // home: TestPage(),
    );
  }
}
