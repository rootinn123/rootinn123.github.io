import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/ui/route/app_routes.dart';

class SplashPage extends StatelessWidget {

  static double appHeaderHeight;
  static double bottomNaviHeight;  

  
  @override
  Widget build(BuildContext context) {
    AppConfig.appScreenHeight = ScreenUtil.getScreenH(context);
    AppConfig.appScreenWidth = ScreenUtil.getScreenW(context);
    AppConfig.appStatusBarHeight = ScreenUtil.getStatusBarH(context);
    AppConfig.appHeaderHeight =  AppConfig.appScreenHeight * AppConfig.appBarHeight + AppConfig.appStatusBarHeight;
    AppConfig.bottomNaviHeight = AppConfig.appScreenHeight * AppConfig.appBottomBarHeight; 
    Future.delayed(Duration(milliseconds: 400)).then((_){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context){
            return AppRoutes.getInstance().mainPage;
          },
          settings: RouteSettings(isInitialRoute: true),
          maintainState: false,
        ),
      );
    });
    return Scaffold(
      body: Center(
        child: CachedNetworkImage(
          imageUrl: '${Constant.DUMEI_RESOURCE_SERVER}${Constant.IMAGE_LOGO}',
          height: 150.0,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

}