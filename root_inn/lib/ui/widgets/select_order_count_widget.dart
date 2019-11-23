
import 'package:flutter/material.dart';
import 'package:root_inn/blocs/bloc_index.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';

class SelectOrderCountWidget extends StatefulWidget{

  SelectOrderCountWidget({Key key,
    this.type = 1, 
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
    return widget.type == 1  ? this._buildCardBottomWidget(context) : this._buildDetailBottomWidget(context);
  }

  void _subtractCount(MainBloc bloc){
    if(widget.product.unitPrice[widget.unitPriceIndex].checkCount <= 0) return;
    List<OrderItem> orderList = bloc.orderListBloc.comList ?? <OrderItem>[];
    for(OrderItem orderItem in orderList){
      if('${orderItem.product.id}${orderItem.product.name}${orderItem.product.unitPrice[widget.unitPriceIndex]}' == this.orderItemId){
        orderItem.count--;
        if(orderItem.count == 0){
          orderList.remove(orderItem);
        }
        break;
      }
    }
    bloc.orderListBloc.comListData.sink.add(orderList);
    setState(() => widget.product.unitPrice[widget.unitPriceIndex].checkCount--);
  }

  void _addCount(MainBloc bloc){
    List<OrderItem> orderList = bloc.orderListBloc.comList ?? <OrderItem>[];
    for(OrderItem orderItem in orderList){
      if(orderItem.product.id == widget.product.id){
        orderItem.count++;
        return;
      }
    }
    orderList.add(
      OrderItem(
        id : this.orderItemId,
        product: widget.product,
        count: 1,
      )
    );
    bloc.orderListBloc.comListData.sink.add(orderList);
    setState(() => widget.product.unitPrice[widget.unitPriceIndex].checkCount++);
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
                  fontSize: AppDimens.font_26
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
      margin: EdgeInsets.only(left: 5.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => this._subtractCount(bloc),
            child: Container(
              height: 30.0,
              width: 30.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.cardBottomColor,
                image: DecorationImage(
                  image: AssetImage('assets/images/subSign.png'),
                  fit: BoxFit.fill
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
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
                  fontSize: AppDimens.font_26
                ),),
            ),
          ),
          GestureDetector(
            onTap: ()=> this._addCount(bloc),
            child: Container(
              height: 30.0,
              width: 30.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.cardBottomColor,
                image: DecorationImage(
                  image: AssetImage('assets/images/addSign.png'),
                  fit: BoxFit.fill
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
