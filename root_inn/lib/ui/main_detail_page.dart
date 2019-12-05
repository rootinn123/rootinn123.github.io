import 'package:flutter/material.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/ui/widgets/block_hidden_image_widget.dart';
import 'package:root_inn/ui/widgets/block_show_image_widget.dart';

class MainDetailPage extends StatelessWidget{

  MainDetailPage({Key key, this.menu, this.type = 1}) : super(key: key);
  final Menu menu;
  final int  type;
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: AppConfig.appHeaderHeight, bottom: AppConfig.bottomNaviHeight + 10.0, ),
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
      return menu.subclassImageShow ? BlockShowImageWidget(menu: menu, type: this.type,) : BlockHiddenImageWidget(menu: menu, type: this.type,);
    }).toList();
    return list;
  }



}