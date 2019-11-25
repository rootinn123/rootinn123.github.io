import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:root_inn/ui/main_page.dart';
import 'package:root_inn/ui/route/app_routes.dart';
import 'package:root_inn/utils/navigator_util.dart';


class MainPageMenuHeaderWidget extends StatelessWidget{

  MainPageMenuHeaderWidget({Key key, this.menu}) : super(key: key);
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: AppDimens.padding_30, bottom: AppDimens.padding_20, left: AppDimens.padding_30,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Container(
            child: Row(
              children: <Widget>[
                Text('${this.menu.name}', style: TextStyle(fontSize: AppDimens.font_20)),
                Container(
                  padding: EdgeInsets.only(left: AppDimens.padding_10, top: 6.0),
                  child: Text('${this.menu.title}', style: TextStyle(fontSize: AppDimens.font_14, color: AppColors.descriptionFontColor),),
                )
              ],
            ),
          ),
          ViewMoreBottonWidget(menu: this.menu),
        ],
      ),
    );
  }

}


class ViewMoreBottonWidget extends StatelessWidget{

  ViewMoreBottonWidget({Key key, this.menu}) : super(key: key);
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    if(!this.menu.hasMore) return Container();
    Widget widget = Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.padding_10, vertical: AppDimens.padding_3),
      margin: EdgeInsets.only(right: AppDimens.padding_30),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: AppColors.priceFontColor),
        borderRadius: BorderRadius.all(Radius.circular(AppDimens.radius_10))
      ),
      child: Text('查看全部', style: TextStyle(fontSize: AppDimens.font_12, color: AppColors.priceFontColor),),
    );

    return GestureDetector(
      onTap: (){
        NavigatorUtil.pushPage(context, AppRoutes.getInstance().mainViewMorePage(menu: this.menu));
      },
      child: widget,
    );
  }

}

class MarkWidget extends StatelessWidget{

  MarkWidget({Key key, this.mark}) : super(key: key);
  final String mark;

  @override
  Widget build(BuildContext context){
    return  Container(
      // width: 10,
      // alignment: Alignment.center,
      margin: EdgeInsets.only(right: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(AppDimens.radius_10)),
        border: Border.all(color: AppColors.markFontColor, width: 0.5),
      ),
      child: Text(
        '${this.mark}', 
        style: TextStyle(
          fontSize: AppDimens.font_12, 
          color: AppColors.markFontColor,
          fontFamily: 'pixel',
          decoration: TextDecoration.none,
        ), 
        maxLines: 1, 
        overflow: TextOverflow.ellipsis,
      ),
    );
  }


}

class Appheader extends StatelessWidget{

  Appheader({Key key, @required this.title, this.bgColor= AppColors.topNaviColor}) : super(key: key);

  final String title;

  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return this._buildHeaderWidget(context);
  }

  Widget _buildHeaderWidget(BuildContext context){
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        height: AppConfig.appHeaderHeight,
        padding: EdgeInsets.only(left: AppDimens.padding_30, right: AppDimens.padding_30, top: AppConfig.appStatusBarHeight),
        decoration: BoxDecoration(
          color: this.bgColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(right: 10.0),
              child: CachedNetworkImage(
                imageUrl: '${Constant.DUMEI_RESOURCE_SERVER}${Constant.IMAGE_BACK}',
                height: 28.0,
                width: 28.0,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              '$title', 
              style: TextStyle(fontSize: AppDimens.font_24, decoration: TextDecoration.none), 
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      )
    );
  }


}


class MainPageHeaderWidget extends StatelessWidget{

  const MainPageHeaderWidget({Key key, this.menu}) : super(key: key);
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return _buildHeaderWidget(context);
  }

  Widget _buildHeaderWidget(BuildContext context){
    LogUtil.v('_buildHeaderWidget----->>>>>>');
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      // bottom: AppConfig.appScreenHeight * AppConfig.appBarHeight,
      child: Container(
        height: AppConfig.appHeaderHeight,
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
                      // NavigatorUtil.pushPage(context, AppRoutes.getInstance().orderListPage);
                     
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            return AppRoutes.getInstance().orderListPage;
                          },
                          settings: RouteSettings(),
                          maintainState: false
                        ),
                        
                      );

                      // Navigator.push(
                      //   context, 
                      //   PageRouteBuilder(
                      //     opaque: false,
                      //     transitionDuration: Duration(milliseconds: 300),
                      //     pageBuilder: (_, __, ___) => AppRoutes.getInstance().orderListPage,
                      //   ),
                      // );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.0),
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      width: 40.0,
                      height: 30.0,
                      color: Colors.transparent,
                      child: Image.asset('assets/images/shoppingCar.png', width: 30.0, height: 30.0, fit: BoxFit.fill,),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      NavigatorUtil.pushPage(context, AppRoutes.getInstance().lotteryViewPage);
                    },
                    child: Container(
                      width: 40.0,
                      height: 30.0,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      color: Colors.transparent,
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
  
}