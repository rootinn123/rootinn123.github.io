import 'package:flustars/flustars.dart';
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

class AppMenuPage extends StatelessWidget{

  const AppMenuPage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    if(null == bloc.appMenuTypeListBloc.comList){
      bloc.appMenuTypeListBloc.getData(labelId: AppLocalLabel.InitialData, comReq: <String, dynamic>{});
    } 
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: StreamBuilder(
        stream: bloc.appMenuTypeListBloc.comListStream,
        builder: (BuildContext context, AsyncSnapshot<List<AppMenuType>> snapshot){
          if(ObjectUtil.isEmptyList(snapshot.data)) return Container();
          return SingleChildScrollView(
            child: Container(
              // height: AppConfig.appScreenHeight,
              width: AppConfig.appScreenWidth,
              padding: EdgeInsets.only(top: 200.0),
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
        DumeiRepository.getInstance().getMenuData(DumeiApi.getPath(path: appMenuType.url),comReq).then((List<Menu> menuList){
          appMenuType.menuList = menuList;
          bloc.appMenuTypeListBloc.comListData.sink.add(bloc.appMenuTypeListBloc.comList);

          bloc.menulListBloc.comList = appMenuType.menuList;
          bloc.menulListBloc.comListData.sink.add(bloc.menulListBloc.comList);
          NavigatorUtil.pushPage(context, AppRoutes.getInstance().mainPage);
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 100.0,
        width: 350.0,
        margin: EdgeInsets.only(bottom: 15.0),
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: AppConfig.deskColor[1]),
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('${appMenuType.name}', style: TextStyle(fontSize: AppDimens.font_26),),
            Container(height: 5.0,),
            Text('${appMenuType.aliasName}/${appMenuType.timeSlot}', style: TextStyle(fontSize: AppDimens.font_18),),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderWidget(){
    return Padding(
      padding: EdgeInsets.only(bottom: 35.0),
      child: Image.asset('assets/images/logo.png', height: 100, fit: BoxFit.fitHeight,),
    );
  }

}