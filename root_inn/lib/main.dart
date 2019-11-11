import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:root_inn/blocs/bloc_index.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/ui/main_page.dart';

Future main() async {
  
  SystemChrome.setPreferredOrientations([       // 强制竖屏
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(BlocProvider(child: MyApp(), bloc: MainBloc()),);
  SystemChrome.setSystemUIOverlayStyle(AppConfig.light);
}

class MyApp extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    LogUtil.debuggable = Constant.DEBUG_MODE;
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    bloc.initAppData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "pixel",
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryColor,
      ),
      home: MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

