

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/common/sp_helper.dart';
import 'package:root_inn/data/api.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/utils/dio_util.dart';
DioUtil dioUtil = DioUtil.getInstance();
class DumeiRepository {

  DumeiRepository._();

  static DumeiRepository _instance;

  static DumeiRepository getInstance() {
    if (_instance == null) {
      _instance = DumeiRepository._();
    }
    return _instance;
  }
  /// 获取Menu
  Future<List<Menu>> getInitialData(Map<String, dynamic> comReq) async {
    Response response = await dioUtil.requestPure(
      Method.get, 
      DumeiApi.getPath(path: DumeiApi.initialData),
      queryParameters:comReq
    );
    LogUtil.v('response----->>>>>${response.data.runtimeType}');
    Map<String, dynamic> resultMap = response.data;
    if(null != resultMap) {
      SpHelper.putObject<String>(Constant.KEY_INITIAL_DATA, jsonEncode(resultMap));
    }
    return DumeiRepository.tranfer2ListMenu(resultMap);
  }

  // List<Menu> tranfer2ListMenu(String result){
  //   if(ObjectUtil.isEmpty(result)){
  //     return <Menu>[];
  //   }
  //   // result = result.replaceAll('\\', '');
  //   Map<String, dynamic> resultMap = json.decode(result);
  static List<Menu> tranfer2ListMenu(Map<String, dynamic> resultMap){
    if(ObjectUtil.isEmpty(resultMap)){
      return <Menu>[];
    }
    
    // result = result.replaceAll('\\', '');
    List<Map<String, dynamic>> menuMapList = List.castFrom(resultMap[AppHttpConstant.MENUS]);
    List<Map<String, dynamic>> productMapList = List.castFrom(resultMap[AppHttpConstant.PRODUCTS]);
    List<Menu> mainMenuList = <Menu>[];
    List<Menu> menuList;
    List<Product> productList;
    LogUtil.v('----->>>>>productMapList resolve');
    if(null != productMapList){
      productList = productMapList.map((Map<String, dynamic> map){
        return Product.fromJson(map);
      }).toList();
    }
    LogUtil.v('----->>>>>menuMapList resolve');
    if(null != menuMapList){
      menuList = menuMapList.map((Map<String, dynamic> map){
        return Menu.fromJson(map);
      }).toList();
    }
    LogUtil.v('----->>>>>${productList?.length}====${menuList?.length}');
    if(productList != null && menuList != null){
      // 为 menu挂载products
      LogUtil.v('----->>>>>为 menu挂载products');
      for(Menu menu in menuList){
        menu.products = menu.products ?? <Product>[];
        for(Product product in productList){
          if(null != product.category && '${product.category}${AppConfig.splitSymbol}'.indexOf('${menu.id}${AppConfig.splitSymbol}') >= 0){
            menu.products.add(product);
          }
        }
      }
      // 为Menu挂载子Menu
      LogUtil.v('----->>>>>为Menu挂载子Menu');
      for(Menu parent in menuList){
        parent.subMenu = parent.subMenu ?? <Menu>[];
        if(parent.level == 1) mainMenuList.add(parent);
        for(Menu son in menuList){
          if(son.id != parent.id && son.id.startsWith(parent.id) && (parent.id.length + 1) == son.id.length)
            parent.subMenu.add(son);
        }
      }
    }
    return mainMenuList;
  }


}
