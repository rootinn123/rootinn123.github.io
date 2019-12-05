
import 'package:flutter/material.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/ui/main_detail_page.dart';
import 'package:root_inn/ui/widgets/widgets.dart';

class MainViewMorePage extends StatefulWidget{
  MainViewMorePage({Key key, this.menu}) : super(key: key);
  final Menu menu;
  @override
  State<StatefulWidget> createState() => _MainViewMorePageState();
}
class _MainViewMorePageState extends State<MainViewMorePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          this._buildPageWidget(context),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child:Appheader(title: widget.menu.moreTitle,),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPageWidget(BuildContext context){
    return Positioned.fill(
      child: MainDetailPage(menu: widget.menu, type: 3,),
    );
  }

  

 
}