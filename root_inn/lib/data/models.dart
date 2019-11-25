import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/utils/utils.dart';

class ComData {
  int total;
  List rows;
  String pagingState;
  bool hasNext = true;

  ComData.fromJson(Map<String, dynamic> jsonData)
      : hasNext = jsonData['hasNext'],
        pagingState = jsonData['pagingState'],
        total = jsonData['total'],
        rows = jsonData['rows'] ?? [];
}

// {"id":"25","level":"2","name":"威士忌","title":"Whiskey","image":"","subclassImageShow":"TRUE","hasMore":"TRUE","moreTitle":"烈酒纯饮/Straight","remark":""},
class Menu {
  String id;
  int level;
  String name;
  String title;
  String image;
  bool subclassImageShow; 
  bool hasMore;
  String moreTitle;
  String remark;
  List<Product> products;
  List<Menu> subMenu;

  Menu({
    this.id, 
    this.level, 
    this.name,
    this.title,
    this.image,
    this.subclassImageShow,
    this.hasMore, 
    this.moreTitle, 
    this.remark, 
    this.products,
    this.subMenu
  });

  Menu.fromJson(Map<String, dynamic> jsonData)
    : id = jsonData['id'],
      level = Utils.tranfer2Int(jsonData['level']),
      name = jsonData['name'],
      image = Utils.trimData(jsonData['image']),
      title = jsonData['title'],
      subclassImageShow =  Utils.tranfer2Bool(jsonData['subclassImageShow']),
      hasMore = Utils.tranfer2Bool(jsonData['hasMore']),
      moreTitle = jsonData['moreTitle'],
      remark = jsonData['remark'];


  Map<String, dynamic> toJson() => {
    'id': id,
    'level': level,
    'name' : name,
    'image' : image,
    'title': title,
    'subclassImageShow': subclassImageShow,
    'hasMore': hasMore,
    'moreTitle': moreTitle,
    'remark': remark,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }

}


/// {"id":"1","name":"菲力牛排","aliasName":"Fili Steak","category":"11","currency":"RMB",
/// "price":"79","unitPrice":"79/份+480/Bottle","newStatus":"TRUE","recommendStatus":"TRUE",
/// "type":"food",
/// "image":"http://5b0988e595225.cdn.sohucs.com/images/20180216/4ee3a50d80ef4d2791f03373c2cc9668.jpeg",
/// "mark":"230g/份+限量供量+进口食材料",
/// "description":"费力牛排，手指萝卜，西兰花，烤玉米，两种酱汁；精选牛排，搭配特制腌料，煎至恰当五分熟，吧啦吧啦～",
/// "spiceIndex":"1","alcoholIndex":"35","withIce":"TRUE","remark":""}
class Product {
  String id;
  String name;
  String aliasName;
  String category;
  String currency;
  String price; 
  List<SpecsProduct> unitPrice;   // 加号分割
  bool newStatus;
  bool recommendStatus;
  String type;
  String image;
  List<String> mark;                      // 加号分割
  String description;
  int spiceIndex;
  int alcoholIndex;
  bool withIce;
  String remark;

  Product({
    this.id,
    this.name,
    this.aliasName,
    this.category,
    this.currency,
    this.price, 
    this.unitPrice,   // 加号分割
    this.newStatus,
    this.recommendStatus,
    this.type,
    this.image,
    this.mark,                      // 加号分割
    this.description,
    this.spiceIndex,
    this.alcoholIndex,
    this.withIce,
    this.remark,
  });

  /// 解析标记
  static List<String> resolveMark(dynamic val){
    if(val == null || val == '') return <String>[];
    return '$val'.split(AppConfig.splitSymbol);
  }

  /// 解析价格数组
  static List<SpecsProduct> resolveUnitPrice(dynamic productId,dynamic val){
    if(val == null || val == '' || '$val'.length < 1) return <SpecsProduct>[];
    List<SpecsProduct> list = <SpecsProduct>[];
    int index = 1;
    for (String unitItem in '$val'.split(AppConfig.splitSymbol)){
      List<String> item = unitItem.split('/');
      list.add(SpecsProduct(id: '$productId-$index' ,price: Utils.tranfer2Double(item[0]), unit: item[1],checkCount: 0),);
      index++;
    }
    return list;
  }

  Product.fromJson(Map<String, dynamic> jsonData)
    : id = jsonData['id'],
      name = jsonData['name'],
      aliasName = Utils.trimData(jsonData['aliasName']),
      category = Utils.trimData(jsonData['category']),
      currency = jsonData['currency'],
      price = jsonData['price'],
      unitPrice = Product.resolveUnitPrice(jsonData['id'], jsonData['unitPrice']),
      newStatus = Utils.tranfer2Bool(jsonData['newStatus']),
      recommendStatus = Utils.tranfer2Bool(jsonData['recommendStatus']),
      type = jsonData['type'],
      image = Utils.trimData(jsonData['image']),
      mark = Product.resolveMark(jsonData['mark']),
      description = jsonData['description'],
      spiceIndex =  Utils.tranfer2Int(jsonData['spiceIndex']),
      alcoholIndex = Utils.tranfer2Int(jsonData['alcoholIndex']),
      withIce = Utils.tranfer2Bool(jsonData['withIce']),
      remark = jsonData['remark'];


  Map<String, dynamic> toJson() => {
    'id': id,
    'name' : name,
    'aliasName': aliasName,
    'category': category,
    'currency' : currency,
    'price': price,
    'unitPrice': unitPrice,
    'newStatus': newStatus,
    'recommendStatus': recommendStatus,
    'type': type,
    'image': image,
    'mark': mark,
    'description': description,
    'spiceIndex': spiceIndex,
    'alcoholIndex': alcoholIndex,
    'withIce': withIce,
    'remark': remark,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }

}

class SpecsProduct {
  String id;
  String unit;
  double price;  //1红色，2 蓝色， 3绿色， 4深绿
  int checkCount;
  
  SpecsProduct({
    this.id, 
    this.unit,
    this.price,
    this.checkCount,
  });

  SpecsProduct.fromJson(Map<String, dynamic> jsonData)
    : id = jsonData['id'],
      unit = jsonData['unit'],
      price = jsonData['price'],
      checkCount = 0
    ;


  Map<String, dynamic> toJson() => {
    'id': id,
    'unit' : unit,
    'price' : price,
    'checkCount' : checkCount,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }

}

class Desk {
  String id;
  String name;
  int colorType;  //1红色，2 蓝色， 3绿色， 4深绿
  
  Desk({
    this.id, 
    this.name,
    this.colorType,
  });

  Desk.fromJson(Map<String, dynamic> jsonData)
    : id = jsonData['id'],
      name = jsonData['name'],
      colorType = Utils.tranfer2Int(jsonData['colorType']) ?? 1
    ;


  Map<String, dynamic> toJson() => {
    'id': id,
    'name' : name,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }

}

class OrderItem {
  String id;    // id = product.id + product.name + product.unitPrice
  Product product;
  // SpecsProduct unitPriceItem;
  int unitPriceItemIndex;
  
  OrderItem({
    this.id,
    this.product, 
    // this.unitPriceItem,
    this.unitPriceItemIndex
  });

  OrderItem.fromJson(Map<String, dynamic> jsonData)
  : 
    id = jsonData['id'],
    product = jsonData['product']
  ;

  Map<String, dynamic> toJson() => {
    'product': product,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }

}

class LotteryItemModel {
  final String title;
  final String icon;
  final int coefficient;

  LotteryItemModel({
    this.title,
    this.icon, 
    this.coefficient
  });

  LotteryItemModel.fromJson(Map<String, dynamic> jsonData)
  : 
    title = jsonData['title'],
    icon = jsonData['icon'],
    coefficient = Utils.tranfer2Int(jsonData['coefficient'], defaultVal: 10)
  ;

  Map<String, dynamic> toJson() => {
    'titleNatitleme': title,
    'icon': icon,
    'coefficient': coefficient,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}