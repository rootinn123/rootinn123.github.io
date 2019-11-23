import 'package:cached_network_image/cached_network_image.dart';
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
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      decoration: BoxDecoration(
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

  Appheader({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return this._buildHeaderWidget(context);
  }

  Widget _buildHeaderWidget(BuildContext context){
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(right: 10.0),
                child: CachedNetworkImage(
                  imageUrl: '${Constant.DUMEI_RESOURCE_SERVER}${Constant.IMAGE_BACK}',
                  height: 20.0,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Text('$title', style: TextStyle(fontSize: AppDimens.font_24), maxLines: 1, overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }


}

