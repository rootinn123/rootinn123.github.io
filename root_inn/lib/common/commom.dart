

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Constant {

  static const String APP_NAME = 'RootInn';
  static const bool DEBUG_MODE = true;
  static const int STATUS_SUCCESS = 0;
  static const String SERVER_ADDRESS = DUMEI_SERVER_PRD;

  static const String DUMEI_SERVER_PRD = "https://rootinn123.github.io/";
  static const String DUMEI_SERVER = "https://rootinn123.github.io/";
  static const String DUMEI_SERVER_DEV = 'https://rootinn123.github.io/';

  static const String DUMEI_RESOURCE_SERVER = 'https://rootinn123.github.io/';

  static const String KEY_INITIAL_DATA = "KEY_INITIAL_DATA";

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
}

class AppLocalLabel{
  static const String InitialData = "InitialData";
}

class AppHttpConstant {
  static const String MENUS = 'menus';
  static const String PRODUCTS = 'products';
  static const String UNIT = 'unit';
  static const String PRICE = 'price';
}
