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

  /// 菜单
  ComListBloc<Menu> menulListBloc = ComListBloc<Menu>(comList: null);

  /// 吧台桌子
  ComListBloc<Desk> deskListBloc = ComListBloc<Desk>(comList: null);

  /// 首购物车
  ComListBloc<OrderItem> orderListBloc = ComListBloc<OrderItem>(comList: null);

  /// 当前吧台
  ComBloc<int>  currentDeskIndexBloc = ComBloc<int>(com: null);

  /// 中奖概率
  ComListBloc<LotteryItemModel> lotteryItemModelListBloc = ComListBloc<LotteryItemModel>(comList: null);

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
    if(!ObjectUtil.isEmptyList(this.menulListBloc.comList)) return null;
    await SpUtil.getInstance();
    if(!SpUtil.isInitialized()) return null;
    String initialData = SpUtil.getString(Constant.KEY_INITIAL_DATA);
    if(ObjectUtil.isEmpty(initialData)) return null;
    Map<String, dynamic> resultMap = jsonDecode(initialData);
    List<Menu> resultList = DumeiRepository.tranfer2ListMenu(resultMap);
    this.menulListBloc.comListData.add(resultList);
  }

}
