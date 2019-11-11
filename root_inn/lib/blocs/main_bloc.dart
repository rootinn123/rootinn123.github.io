import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:root_inn/blocs/bloc_provider.dart';
import 'package:root_inn/blocs/com_bloc.dart';
import 'package:root_inn/blocs/com_list_bloc.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/data/repository.dart';

class MainBloc implements BlocBase {

  /// 首页bottomNavi下标
  ComBloc<int>  mainBottomNaviIndexBloc = ComBloc<int>(com: 0);

  /// 首页tab
  ComListBloc<Menu> menulListBloc = ComListBloc<Menu>(comList: null);

  /// 销毁  
  @override
  void dispose() {
   
  }

  @override
  Future getData({String labelId}) {
    return null;
  }

  @override
  Future onLoadMore({String labelId}) {
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
    return null;
  }

  Future<void> initAppData() async{
    await SpUtil.getInstance();
    if(!SpUtil.isInitialized()) return null;
    String initialData = SpUtil.getString(Constant.KEY_INITIAL_DATA);
    if(ObjectUtil.isEmpty(initialData)) return null;
    Map<String, dynamic> resultMap = jsonDecode(initialData);
    List<Menu> resultList = DumeiRepository.tranfer2ListMenu(resultMap);
    this.menulListBloc.comListData.add(resultList);
  }

}
