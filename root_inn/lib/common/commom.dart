

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Constant {

  static const String APP_NAME = 'RootInn';
  static const bool DEBUG_MODE = false;
  static const int STATUS_SUCCESS = 0;
  static const String SERVER_ADDRESS = DUMEI_SERVER_PRD;

  static const String DUMEI_SERVER_PRD = "https://rootinn123.github.io/";
  static const String DUMEI_SERVER = "https://rootinn123.github.io/";
  static const String DUMEI_SERVER_DEV = 'https://rootinn123.github.io/';

  static const String DUMEI_RESOURCE_SERVER = 'https://rootinn123.github.io/';

  static const String KEY_INITIAL_DATA = "KEY_INITIAL_DATA";
  static const String KEY_DESK_DATA = "KEY_DESK_DATA";

  static const String IMAGE_BACK = "images/page/back.png";
  static const String IMAGE_LOGO = "images/page/logo.png";
  static const String IMAGE_NEW = "images/page/new.png";
  static const String IMAGE_HEART = "images/page/heart.png";
  static const String IMAGE_SPICE = "images/page/spice.png";
}

class AppConfig {

  static const double appBarHeight = 0.06;
  static const double appBottomBarHeight = 0.08;
  static const double appElevation = 0.5;

  static double appStatusBarHeight = 0.0;
  static double appScreenWidth = 0.0;
  static double appScreenHeight = 0.0;
  static double searchBarHeight = 45.0;
  static int commonDuration = 350;

  static double appHeaderHeight;
  static double bottomNaviHeight;  

  static const SystemUiOverlayStyle dark = SystemUiOverlayStyle(    // 黑色字体
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  static const SystemUiOverlayStyle darkFontWhiteBg = SystemUiOverlayStyle(    // 黑色字体
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  static const SystemUiOverlayStyle light = SystemUiOverlayStyle(   // 白色字体
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  static const SystemUiOverlayStyle lightFontWhiteBg = SystemUiOverlayStyle(    // 黑色字体
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  static const String splitSymbol = '+';

  static Map<int, Color> markColor = {
    1: Color.fromRGBO(17, 234, 79, 1.0),
    2: Color.fromRGBO(255, 175, 0, 1.0),
    3: Color.fromRGBO(228, 94, 239, 1.0),
    4: Color.fromRGBO(78, 183, 255, 1.0),
    5: Color.fromRGBO(198, 0, 255, 1.0),
    6: Color.fromRGBO(164, 164, 164, 1.0),
  };

  static Map<int, Color> deskColor = {
    1: Color.fromRGBO(255, 0, 103, 1.0),
    2: Color.fromRGBO(0, 129, 255, 1.0),
    3: Color.fromRGBO(15, 201, 69, 1.0),
    4: Color.fromRGBO(255, 175, 0, 1.0),
    5: Color.fromRGBO(198, 0, 255, 1.0),
    6: Color.fromRGBO(164, 164, 164, 1.0),
  };
}

class AppLocalLabel{
  static const String InitialData = "InitialData";
  static const String DeskData = "DeskData";
  static const String LotteryData = "LotteryData";
}

class AppHttpConstant {
  static const String MENUS = 'menus';
  static const String PRODUCTS = 'products';
  static const String UNIT = 'unit';
  static const String PRICE = 'price';
}
