import 'package:flutter/material.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:root_inn/ui/main_page.dart';
import 'package:root_inn/ui/widgets/block_hidden_image_widget.dart';
import 'package:root_inn/ui/widgets/block_show_image_widget.dart';

class MainDetailPage extends StatelessWidget{

  MainDetailPage({Key key, this.menu}) : super(key: key);
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: MainPage.appHeaderHeight, bottom: MainPage.bottomNaviHeight + 10.0, ),
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        child:  Column(
          children: this._buildBlockListWidget(context),
        ) ,
      )
    );
  }

  /// 页面板块
  List<Widget> _buildBlockListWidget(BuildContext context){
    List<Widget> list = this.menu.subMenu.map((Menu menu){
      return menu.subclassImageShow ? BlockShowImageWidget(menu: menu) : BlockHiddenImageWidget(menu: menu);
    }).toList();
    return list;
  }



}