import 'package:realank_flutter_bloc/realank_flutter_bloc.dart';

class DropMenuHeaderBLoC extends RLKBaseBLoC<Map> {
  DropMenuHeaderBLoC(Map data) : super(data);
  increment() {
    
  }
  
  headerUnSelect(int v) {
    data["selectedIndex"] = v;
    changeData(data);
  }

  headerFilterData(bool hasData) {
    data["filterData"] = hasData;
    changeData(data);
  }

}



