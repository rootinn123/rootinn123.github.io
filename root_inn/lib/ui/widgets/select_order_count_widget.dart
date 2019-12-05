
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/blocs/bloc_index.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:tip_dialog/tip_dialog.dart';

class SelectOrderCountWidget extends StatefulWidget{

  SelectOrderCountWidget({Key key,
    this.type = 1,  //1主页 2弹窗 3需要setState
    @required this.product, 
    @required this.width, 
    @required this.height, 
    this.unitPriceIndex = 0
  }): super(key: key);

  final int type;

  final Product product;

  final int unitPriceIndex;

  final double width;

  final double height;

  @override
  State<StatefulWidget> createState() =>_SelectOrderCountWidgetState();
  
}

class _SelectOrderCountWidgetState extends State<SelectOrderCountWidget>{

  String orderItemId;

  @override
  void initState() {
    super.initState();
    orderItemId = '${widget.product.id}${widget.product.name}${widget.product.unitPrice[widget.unitPriceIndex]}';
  }

  @override
  Widget build(BuildContext context) {
    return widget.type == 1 || widget.type == 3 ? this._buildCardBottomWidget(context) : this._buildDetailBottomWidget(context);
  }

  void _subtractCount(MainBloc bloc){
    if(widget.product.unitPrice[widget.unitPriceIndex].checkCount <= 0) return;
    List<OrderItem> orderList = bloc.orderListBloc.comList ?? <OrderItem>[];
    for(OrderItem orderItem in orderList){
      if(orderItem.id == widget.product.unitPrice[widget.unitPriceIndex].id){
        widget.product.unitPrice[widget.unitPriceIndex].checkCount--;
        if(widget.product.unitPrice[widget.unitPriceIndex].checkCount == 0){
          orderList.remove(orderItem);
        }
        break;
      }
    }
    bloc.orderListBloc.comListData.sink.add(orderList);
    bloc.menulListBloc.comListData.sink.add(bloc.menulListBloc.comList);
    if(widget.type == 3) setState(() {});
  }

  void _addCount(MainBloc bloc){
    bool hasPalced = false;
    widget.product.unitPrice[widget.unitPriceIndex].checkCount++;
    List<OrderItem> orderList = bloc.orderListBloc.comList ?? <OrderItem>[];
    LogUtil.v('_addCount----->>>orderList: ${orderList.length}');
    for(OrderItem orderItem in orderList){
      if(orderItem.id == widget.product.unitPrice[widget.unitPriceIndex].id){
        LogUtil.v('_addCount----->>>2.1');
        hasPalced = true;
        break;
      }
    }
    LogUtil.v('_addCount----->>>3');
    if(!hasPalced){
      LogUtil.v('_addCount----->>>4');
      orderList.add(
        OrderItem(
          id : widget.product.unitPrice[widget.unitPriceIndex].id,
          product: widget.product,
          unitPriceItemIndex: widget.unitPriceIndex
        )
      );
    }
    LogUtil.v('_addCount----->>>5---${orderList.length}');
    bloc.orderListBloc.comList = orderList;
    bloc.orderListBloc.comListData.sink.add(bloc.orderListBloc.comList );
    bloc.menulListBloc.comListData.sink.add(bloc.menulListBloc.comList);
    if(widget.type == 2) {
      // setState(() {});
      TipDialogHelper.success(context, "Successfully");
      Future.delayed(Duration(milliseconds: 1000)).then((_){
        TipDialogHelper.dismiss(context);
      });
    }
    if(widget.type == 3) setState(() {});
  }



  Widget _buildCardBottomWidget(BuildContext context){
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.black,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => this._subtractCount(bloc),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.cardBottomColor,
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
                child: Text('-', style: TextStyle(color: AppColors.descriptionFontColor, fontSize: 26.0),),
              ),
            ),
          ),
          Container(width: 1.0,),
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.cardBottomColor,
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
              ),
              child: Text(
                '${widget.product.unitPrice[widget.unitPriceIndex].checkCount}', 
                style: TextStyle(
                  color: widget.product.unitPrice[widget.unitPriceIndex].checkCount > 0 ? AppColors.countColor : AppColors.descriptionFontColor, 
                  fontSize: AppDimens.font_18
                ),
              ),
            ),
          ),
          Container(width: 1.0,),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: ()=> this._addCount(bloc),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.cardBottomColor,
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
                child: Text('+', style: TextStyle(color: AppColors.descriptionFontColor, fontSize: AppDimens.font_26),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailBottomWidget(BuildContext context){
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    return Container(
      width: widget.width,
      height: widget.height,
      // margin: EdgeInsets.only(left: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // GestureDetector(
          //   onTap: () => this._subtractCount(bloc),
          //   child: Container(
          //     height: 20.0,
          //     width: 20.0,
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       color: Colors.transparent,
          //     ),
          //     child: Image.asset(
          //       'assets/images/subSign.png',
          //         fit: BoxFit.fill,
          //         height: 20.0,
          //         width: 20.0,
          //     ),
          //   ),
          // ),
          // Expanded(
          //   flex: 3,
          //   child: Container(
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       color: AppColors.cardBottomColor,
          //     ),
          //     child: Text(
          //       '${widget.product.unitPrice[widget.unitPriceIndex].checkCount}', 
          //       style: TextStyle(
          //         color: widget.product.unitPrice[widget.unitPriceIndex].checkCount > 0 ? AppColors.countColor : AppColors.descriptionFontColor, 
          //         fontSize: AppDimens.font_20,
          //         fontStyle: FontStyle.normal,
          //         fontFamily: 'pixel',
          //         decoration: TextDecoration.none,
          //       ),),
          //   ),
          // ),
          GestureDetector(
            onTap: ()=> this._addCount(bloc),
            child: Container(
              height: 20.0,
              width: 35.0,
              padding: EdgeInsets.only(left: 15.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Image.asset(
                'assets/images/addSign.png',
                  fit: BoxFit.fill,
                  height: 20.0,
                  width: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
