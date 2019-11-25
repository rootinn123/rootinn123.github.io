import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/blocs/bloc_index.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:root_inn/ui/main_detail_page.dart';
import 'package:root_inn/ui/route/app_routes.dart';
import 'package:root_inn/utils/navigator_util.dart';


class MainPage extends StatelessWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  static double appHeaderHeight;
  static double bottomNaviHeight;  

  @override
  Widget build(BuildContext context) {
    LogUtil.v('MainPage----->Build--->');
    AppConfig.appScreenHeight = ScreenUtil.getScreenH(context);
    AppConfig.appScreenWidth = ScreenUtil.getScreenW(context);
    AppConfig.appStatusBarHeight = ScreenUtil.getStatusBarH(context);

    MainPage.appHeaderHeight =  AppConfig.appScreenHeight * AppConfig.appBarHeight + AppConfig.appStatusBarHeight;
    MainPage.bottomNaviHeight = AppConfig.appScreenHeight * AppConfig.appBottomBarHeight;  

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        child: this._buildStructureWidget(context),
      ),
    );
  }

  Widget _buildStructureWidget(BuildContext context){
    LogUtil.v('_buildStructureWidget----->Build--->1');
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    if(bloc.menulListBloc == null) ComListBloc<Menu>(comList: null);
    if(ObjectUtil.isEmptyList(bloc.menulListBloc.comList )){
      LogUtil.v('menulListBloc判断为空取数据');
      bloc.menulListBloc.getData(labelId: AppLocalLabel.InitialData, comReq: <String, dynamic>{});
    }
    if(ObjectUtil.isEmptyList(bloc.deskListBloc.comList )){
      LogUtil.v('deskListBloc');
      bloc.deskListBloc.getData(labelId: AppLocalLabel.DeskData, comReq: <String, dynamic>{});
    }
     if(ObjectUtil.isEmptyList(bloc.lotteryItemModelListBloc.comList )){
      LogUtil.v('lotteryItemModelListBloc');
      bloc.deskListBloc.getData(labelId: AppLocalLabel.LotteryData, comReq: <String, dynamic>{});
    }
    LogUtil.v('_buildStructureWidget----->Build--->2');
    return StreamBuilder(
      stream: bloc.menulListBloc.comListStream,
      builder: (BuildContext context, AsyncSnapshot<List<Menu>> snapshot){
        List<Menu> menuList = snapshot.data;
        if(ObjectUtil.isEmptyList(menuList)) return Center(child: CupertinoActivityIndicator(),);
        
        return Container(
          child: StreamBuilder(
            stream: bloc.mainBottomNaviIndexBloc.comStream,
            builder: (BuildContext context, AsyncSnapshot<int> asyncSnapshot){
              int index = asyncSnapshot.data ?? 0;
              return Stack(
                children: <Widget>[
                  this._buildPageWidget(context, menuList, index),
                  this._buildHeaderWidget(context, menuList[index], index),
                  this._buildBottomNaviWidget(context, menuList, index),
                ],
              );
            },
          ),
        );
      },
    );

  }
  /// 头部
  Widget _buildHeaderWidget(BuildContext context, Menu menu, int index){
    LogUtil.v('_buildHeaderWidget----->>>>>>$appHeaderHeight');
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      // bottom: AppConfig.appScreenHeight * AppConfig.appBarHeight,
      child: Container(
        height: MainPage.appHeaderHeight,
        padding: EdgeInsets.only(left: AppDimens.padding_30, right: AppDimens.padding_30, top: AppConfig.appStatusBarHeight),
        decoration: BoxDecoration(
          color: AppColors.topNaviColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('${menu.title}', style: TextStyle(fontSize: AppDimens.font_24),),
            CachedNetworkImage(
              imageUrl: '${Constant.DUMEI_RESOURCE_SERVER}${Constant.IMAGE_LOGO}',
              height: 18.0,
              fit: BoxFit.fitHeight,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      NavigatorUtil.pushPage(context, AppRoutes.getInstance().orderListPage);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15.0),
                      child: Image.asset('assets/images/shoppingCar.png', width: 30.0, height: 30.0, fit: BoxFit.fill,),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      NavigatorUtil.pushPage(context, AppRoutes.getInstance().lotteryViewPage);
                    },
                    child: Container(
                      child: Image.asset('assets/images/prize.png', width: 30.0, height: 30.0, fit: BoxFit.fill,),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  /// 内容页
  Widget _buildPageWidget(BuildContext context, List<Menu> menuList, int index){
    List<Widget> pageList = <Widget>[];
    for(int i = 0; i< menuList.length; i++){
      pageList.add(
        Positioned.fill(
          child: Offstage(
            offstage: i != index,
            child: MainDetailPage(menu: menuList[i],),
          ),
        )
      );
    }
    return Stack(
      children: pageList,
    );
  }

  /// 底部导航
  Widget _buildBottomNaviWidget(BuildContext context, List<Menu> menuList, int index){
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    List<Widget> navis = <Widget>[];
    for(int i = 0; i< menuList.length; i++){
      navis.add(this._buildBottomNaviItemWidget(bloc, menuList[i], i, i == index));
    }

    Widget widget = Container(
      height: MainPage.bottomNaviHeight,
      decoration: BoxDecoration(
        color: AppColors.bottomNaviColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navis,
      ),
    );
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: ClipRect(  //裁切长方形
        child: BackdropFilter(   //背景滤镜器
          filter: ImageFilter.blur(sigmaX: 10.0,sigmaY: 10.0), //图片模糊过滤，横向竖向都设置5.0
          child: widget,
        )
      ),
    );
  }

  Widget _buildBottomNaviItemWidget(MainBloc bloc, Menu menu, int index, bool active){
    
    String imageUrl = menu.image;
    if(active){
      List<String> list = imageUrl.split('.');
      imageUrl = '${list[0]}_active.${list[1]}';
    }
    return Expanded(
      child: GestureDetector(
        onTap: (){
          bloc.mainBottomNaviIndexBloc.comData.sink.add(index);
        },
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CachedNetworkImage(imageUrl: '${Constant.DUMEI_RESOURCE_SERVER}$imageUrl', width: 35.0, fit: BoxFit.fitWidth,),
              Container(
                // alignment: Alignment.center,
                color: Colors.transparent,
                padding: EdgeInsets.only(left: AppDimens.padding_4),
                child: Text(
                  '${menu.name}', 
                  style: TextStyle(
                    fontSize: AppDimens.font_18,
                    color: active ? AppColors.selectedFontColor : Colors.white
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}
