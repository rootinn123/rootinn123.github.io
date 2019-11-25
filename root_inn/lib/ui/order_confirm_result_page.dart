
import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/blocs/bloc_index.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:root_inn/ui/route/app_routes.dart';

class OrderConfirmResultPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: ClipRect(  //裁切长方形
                child: BackdropFilter(   //背景滤镜器
                  filter: ImageFilter.blur(sigmaX: 10.0,sigmaY: 10.0), //图片模糊过滤，横向竖向都设置5.0
                  child: Container(
                    color: AppColors.primaryColor.withOpacity(0.5),
                  ),
                )
              ),
            ),
          ),

          Positioned(
            top: 300.0,
            child: this._buildContent(context, bloc),
          )
          
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, MainBloc bloc){
    return Container(
      width: 350.0,
      height: 250.0,
      padding: EdgeInsets.only(top: 40.0),
      decoration: BoxDecoration(
        color: AppColors.topNaviColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/happy.png', width: 80.0, height: 80.0, fit: BoxFit.fill,),
          Container(
            alignment: Alignment.center,
            height: 65.0,
            decoration: BoxDecoration(
              // border: Border(bottom: BorderSide(width: 1.0, color: AppColors.primaryColor))
            ),
            padding: EdgeInsets.only(top: 20.0,bottom: 10.0),
            child: Text('确认该订单？', style: TextStyle(fontSize: AppDimens.font_24),),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 60.0,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text('No', style: TextStyle(fontSize: AppDimens.font_24),),
                  ),
                )
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(!ObjectUtil.isEmptyList(bloc.orderListBloc.comList)){
                      for(OrderItem orderItem in bloc.orderListBloc.comList){
                        orderItem.product.unitPrice[orderItem.unitPriceItemIndex].checkCount = 0;
                      }
                    }
                    bloc.orderListBloc.comList = <OrderItem>[];
                    bloc.currentDeskIndexBloc.com = null;
                    bloc.currentDeskIndexBloc.comData.sink.add(bloc.currentDeskIndexBloc.com);
                    bloc.orderListBloc.comListData.sink.add(bloc.orderListBloc.comList);
                    bloc.menulListBloc.comListData.sink.add(bloc.menulListBloc.comList);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute<void>(
                        builder: (ctx) => AppRoutes.getInstance().mainPage, 
                        settings: RouteSettings(
                          isInitialRoute: false
                        ),
                        maintainState : true
                      ), 
                      (Route<dynamic> route) => false);
                  },
                  child: Container(
                    height: 60.0,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text('Yes', style: TextStyle(fontSize: AppDimens.font_24),),
                  ),
                )
              ),
            ],
          )
        ],
      ),
    );
  }
  
}