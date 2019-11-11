
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:root_inn/ui/main_detail_page.dart';
import 'package:root_inn/ui/main_page.dart';

class MainViewMorePage extends StatelessWidget{
  MainViewMorePage({Key key, this.menu}) : super(key: key);
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          this._buildPageWidget(context),
          this._buildHeaderWidget(context),
        ],
      ),
    );
  }
  
  Widget _buildPageWidget(BuildContext context){
    return Positioned.fill(
      child: MainDetailPage(menu: this.menu,),
    );
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
            Text('${menu.moreTitle}', style: TextStyle(fontSize: AppDimens.font_24), maxLines: 1, overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }

 
}