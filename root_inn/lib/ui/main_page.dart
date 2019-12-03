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
import 'package:root_inn/ui/widgets/widgets.dart';


class MainPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    LogUtil.v('MainPage----->Build--->');
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        child: this._buildStructureWidget(context),
        // child: Center(
        //   child: GestureDetector(
        //     onTap: (){
        //       Navigator.of(context).push(
        //         MaterialPageRoute(
        //           builder: (BuildContext context){
        //             return AppRoutes.getInstance().orderListPage;
        //           },
        //           settings: RouteSettings(),
        //           maintainState: false
        //         ),
        //       );
        //     },
        //     child: Container(
        //       height: 100.0,
        //       width: 100.0,
        //       color: Colors.blue,
        //       child: Text('Demo1---->>>'),
        //     ),
        //   ),
        // ),
        
      ),
    );
  }

  Widget _buildStructureWidget(BuildContext context){
    LogUtil.v('_buildStructureWidget----->Build--->1');
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    // if(bloc.menulListBloc == null) ComListBloc<Menu>(comList: null);
    // if(ObjectUtil.isEmptyList(bloc.menulListBloc.comList)){
    //   LogUtil.v('menulListBloc判断为空取数据');
    //   bloc.menulListBloc.getData(labelId: AppLocalLabel.InitialData, comReq: <String, dynamic>{});
    // }
    // if(ObjectUtil.isEmptyList(bloc.deskListBloc.comList )){
    //   LogUtil.v('deskListBloc判断为空取数据');
    //   LogUtil.v('deskListBloc');
    //   bloc.deskListBloc.getData(labelId: AppLocalLabel.DeskData, comReq: <String, dynamic>{});
    // }
    //  if(ObjectUtil.isEmptyList(bloc.lotteryItemModelListBloc.comList )){
    //    LogUtil.v('lotteryItemModelListBloc判断为空取数据');
    //   LogUtil.v('lotteryItemModelListBloc');
    //   bloc.lotteryItemModelListBloc.getData(labelId: AppLocalLabel.LotteryData, comReq: <String, dynamic>{});
    // }
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
                  MainPageHeaderWidget(menu: menuList[index], bloc: bloc,),
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
      height: AppConfig.bottomNaviHeight,
      decoration: BoxDecoration(
        color: AppColors.bottomNaviColor.withOpacity(0.98)
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
      child: widget,
      // child: ClipRect(  //裁切长方形
      //   child: BackdropFilter(   //背景滤镜器
      //     filter: ImageFilter.blur(sigmaX: 10.0,sigmaY: 10.0), //图片模糊过滤，横向竖向都设置5.0
      //     child: widget,
      //   )
      // ),
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
