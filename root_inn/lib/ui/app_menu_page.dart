import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/blocs/bloc_index.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/api.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/data/repository.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:root_inn/ui/route/app_routes.dart';
import 'package:root_inn/utils/navigator_util.dart';
import 'package:tip_dialog/tip_dialog.dart';

class AppMenuPage extends StatelessWidget{

  const AppMenuPage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    if(null == bloc.appMenuTypeListBloc.comList){
      LogUtil.v('appMenuTypeListBloc');
      bloc.appMenuTypeListBloc.getData(labelId: AppLocalLabel.InitialData, comReq: <String, dynamic>{});
    } 
    if(ObjectUtil.isEmptyList(bloc.deskListBloc.comList )){
      LogUtil.v('deskListBloc判断为空取数据');
      bloc.deskListBloc.getData(labelId: AppLocalLabel.DeskData, comReq: <String, dynamic>{});
    }
     if(ObjectUtil.isEmptyList(bloc.lotteryItemModelListBloc.comList )){
      LogUtil.v('lotteryItemModelListBloc判断为空取数据');
      bloc.lotteryItemModelListBloc.getData(labelId: AppLocalLabel.LotteryData, comReq: <String, dynamic>{});
    }
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: StreamBuilder(
        stream: bloc.appMenuTypeListBloc.comListStream,
        builder: (BuildContext context, AsyncSnapshot<List<AppMenuType>> snapshot){
          if(ObjectUtil.isEmptyList(snapshot.data)) return Center(child:CupertinoActivityIndicator(),);
          return SingleChildScrollView(
            child: Container(
              // height: AppConfig.appScreenHeight,
              width: AppConfig.appScreenWidth,
              padding: EdgeInsets.only(top: 170.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/timeSlot.png'),
                  fit: BoxFit.cover
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: this._buildContentWidget(context, bloc, snapshot.data),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 构建内容
  List<Widget> _buildContentWidget(BuildContext context, MainBloc bloc,  List<AppMenuType> appMenuTypeList){

    List<Widget> list = [this._buildHeaderWidget()];
    for(AppMenuType appMenuType in appMenuTypeList){
      list.add(this._buildItemWidget(context, bloc, appMenuType));
    }
    return list;

  }

  Widget _buildItemWidget(BuildContext context, MainBloc bloc, AppMenuType appMenuType){
    return GestureDetector(
      onTap: (){
        if(!ObjectUtil.isEmptyList(appMenuType.menuList)){
          bloc.menulListBloc.comList = appMenuType.menuList;
          bloc.menulListBloc.comListData.sink.add(bloc.menulListBloc.comList);
          NavigatorUtil.pushPage(context, AppRoutes.getInstance().mainPage);
          return;
        }
        Map<String, dynamic> comReq = {};
        TipDialogHelper.loading(context, "Loading");
        DumeiRepository.getInstance().getMenuData(DumeiApi.getPath(path: appMenuType.url),comReq).then((List<Menu> menuList){
          TipDialogHelper.dismiss(context);
          appMenuType.menuList = menuList;
          bloc.appMenuTypeListBloc.comListData.sink.add(bloc.appMenuTypeListBloc.comList);

          bloc.menulListBloc.comList = appMenuType.menuList;
          bloc.menulListBloc.comListData.sink.add(bloc.menulListBloc.comList);
          NavigatorUtil.pushPage(context, AppRoutes.getInstance().mainPage);
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 120.0,
        width: 500.0,
        margin: EdgeInsets.only(bottom: 15.0),
        decoration: BoxDecoration(
          // border: Border.all(width: 1.0, color: AppConfig.deskColor[1]),
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          image: DecorationImage(
            image: AssetImage('assets/images/timeSlotBg.png'),
            fit: BoxFit.fill
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('${appMenuType.name}', style: TextStyle(fontSize: AppDimens.font_28),),
            Container(height: 3.0,),
            Text('${appMenuType.aliasName}/${appMenuType.timeSlot}', style: TextStyle(fontSize: AppDimens.font_14),),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderWidget(){
    return Padding(
      padding: EdgeInsets.only(bottom: 35.0),
      child: Image.asset('assets/images/logo-1.png', width: 500, fit: BoxFit.fitWidth,),
    );
  }

}