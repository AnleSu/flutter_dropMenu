class SearchParamList {
  List<SearchParamModel> list;
  SearchParamList({
    this.list,
  });

  factory SearchParamList.fromJson(List<dynamic> parsedJson) {
    List<SearchParamModel> modelList = new List<SearchParamModel>();
    modelList = parsedJson.map((i)=>SearchParamModel.fromJson(i)).toList();
    return new SearchParamList(
      list: modelList,
    );
  }
}

class ParamItemModel {
  String name;
  String code;
  bool isSelected;
  ParamItemModel({
    this.name,
    this.code,
    this.isSelected = false,
  });

  factory ParamItemModel.fromJson(Map<String, dynamic> json){
  return ParamItemModel(
    name: json['name'],
    code: json['code']
  );
}
}

enum DateSelectorType { OTHER,AFTERTODAY,BEFORTODAY }
class SearchParamModel {
  List<ParamItemModel> itemList;
  int dateSelectorType;//（Integer） 日期选择器类型(1不支持今天之后 2不支持今天之前 0其他)
  bool multiFlag = false;//是否多选
  String paramCode;//字段编码
  bool dateFlag = false;//是否日期控件
  String paramName;//字段名称
  String defaultVal;//默认值
  
  SearchParamModel({
    this.itemList,
    this.dateSelectorType,
    this.multiFlag,
    this.paramCode,
    this.dateFlag,
    this.paramName,
    this.defaultVal,
  });

  factory SearchParamModel.fromJson(Map<String, dynamic> parsedJson) {
    var list =  parsedJson['itemList'] as List;
    List<ParamItemModel> items = list.map((i) => ParamItemModel.fromJson(i)).toList();
    return new SearchParamModel(
      itemList: items,
      dateSelectorType: parsedJson['dateSelectorType'],
      multiFlag: parsedJson['multiFlag'],
      paramCode: parsedJson['paramCode'],
      dateFlag: parsedJson['dateFlag'],
      paramName: parsedJson['paramName'],
      defaultVal: parsedJson['defaultVal'],
    );
  }
}