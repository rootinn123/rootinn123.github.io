import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/blocs/bloc_index.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:root_inn/ui/route/app_routes.dart';
import 'package:root_inn/ui/widgets/widgets.dart';

class OrderListPage extends StatelessWidget{

  const OrderListPage({Key key}): super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: bloc.orderListBloc.comListStream,
        builder: (BuildContext context, AsyncSnapshot<List<OrderItem>> snapshot){
          List<OrderItem> orderList = snapshot.data ?? <OrderItem>[];
          LogUtil.v('orderList---lengh: ${orderList.length}');
          double amount = 0.0;
          for(OrderItem orderItem in orderList){
            amount += orderItem.product.unitPrice[orderItem.unitPriceItemIndex].price * orderItem.product.unitPrice[orderItem.unitPriceItemIndex].checkCount;
          }
          return this.buildContent(context, bloc, orderList, orderList.length,  amount);
        },
      ),
    );
  }

  

  Widget buildContent(BuildContext context, MainBloc bloc, List<OrderItem> orderList, int categoryCount, double amount) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: SingleChildScrollView(
              // child: DeskExpensionPanelWidget(),
              child: Container(
                // color: Colors.blue,
                padding: EdgeInsets.only(left: AppDimens.padding_36, right: AppDimens.padding_36, top: AppConfig.appBarHeight * AppConfig.appScreenHeight + 20, bottom: 90.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: AppDimens.padding_30,bottom: AppDimens.padding_15),
                      child: Text('当前台号', style: TextStyle(color: Colors.white, fontSize: AppDimens.font_24), textAlign: TextAlign.start,),
                    ),
                    DeskExpensionPanelWidget(),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: AppDimens.padding_30,bottom: AppDimens.padding_15),
                      child: Text('我的食谱', style: TextStyle(color: Colors.white, fontSize: AppDimens.font_24), textAlign: TextAlign.start,),
                    ),
                    this._buildOrdersWidget(context, bloc, orderList),
                  ],                  
                ),
              ),
            ),
          ),

          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child:Appheader(title: '订单详情',),
          ),

          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: this._buildBottomWidget(context, bloc, categoryCount, amount),
          ),
        ],
      ),
    );
  }

  
  Widget _buildBottomWidget(BuildContext context, MainBloc bloc, int categoryCount, double amount, ){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.padding_20),
      height: 80.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.topNaviColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text('数量: $categoryCount', style: TextStyle(fontSize: AppDimens.font_18)),
                Container(
                  width: AppDimens.padding_30,
                ),
                Text('合计: $amount',style: TextStyle(fontSize: AppDimens.font_18)),
              ],
            ),
          ),

          Row(
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Text('完成选择后请呼叫服务员', style: TextStyle(fontSize: AppDimens.font_16, color: Colors.white),),
                ),

                GestureDetector(
                  onTap: (){
                    if(ObjectUtil.isEmptyList(bloc.orderListBloc.comList)) return;
                    Navigator.push(
                      context, 
                      PageRouteBuilder(
                        opaque: false,
                        transitionDuration: Duration(milliseconds: 300),
                        pageBuilder: (_, __, ___) => AppRoutes.getInstance().orderConfirmResultPage,
                      ),
                    );
                    

                    // if(!ObjectUtil.isEmptyList(bloc.orderListBloc.comList)){
                    //   for(OrderItem orderItem in bloc.orderListBloc.comList){
                    //     orderItem.product.unitPrice[orderItem.unitPriceItemIndex].checkCount = 0;
                    //   }
                    // }
                    // bloc.orderListBloc.comList = <OrderItem>[];
                    // bloc.orderListBloc.comListData.sink.add(bloc.orderListBloc.comList);
                    // bloc.menulListBloc.comListData.sink.add(bloc.menulListBloc.comList);
                    // Navigator.of(context).pop();
                    
                  },
                  child: Container(
                  alignment: Alignment.center,
                  height: 44.0,
                  width: 131.0,
                  decoration: BoxDecoration(
                    color: AppColors.confirmButtonNaviColor,
                    borderRadius: BorderRadius.all(Radius.circular(22.0))
                  ),
                  child: Text('服务员确认', style: TextStyle(fontSize: AppDimens.font_22, color: Colors.white),),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// 购物清单
  Widget _buildOrdersWidget(BuildContext context, MainBloc bloc, List<OrderItem> orderList){
    List<Widget> listWidget = orderList.map((OrderItem orderItem){
      return Offstage(
        offstage: orderItem.product.unitPrice[orderItem.unitPriceItemIndex].checkCount <= 0,
        child: this._buildOrderItemWidget(context, bloc, orderItem),
      );
    }).toList();
    return Container(
      // color: Colors.red,
      child: Column(
        children: listWidget,
      ),
    ); 
    
  }

  Widget _buildOrderItemWidget(BuildContext context, MainBloc bloc, OrderItem orderItem){
    return Container(
      margin: EdgeInsets.only(bottom: AppDimens.padding_10),
      padding: EdgeInsets.symmetric(horizontal: AppDimens.padding_15),
      width: AppDimens.order_item_width,
      height: AppDimens.order_item_height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
        // color: AppColors.primaryColor,
        color: AppColors.topNaviColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${orderItem.product.name}', style: TextStyle(color: Colors.white, fontSize: AppDimens.font_16, height: 1.2), maxLines: 1, overflow: TextOverflow.ellipsis,),
                Text('${orderItem.product.aliasName}', style: TextStyle(color: AppColors.descriptionFontColor, fontSize: AppDimens.font_12), maxLines: 1, overflow: TextOverflow.ellipsis,),
              ],
            ),
          ),

          Container(
            child: Text('${orderItem.product.unitPrice[orderItem.unitPriceItemIndex].price}/${orderItem.product.unitPrice[orderItem.unitPriceItemIndex].unit}', style: TextStyle(fontSize: AppDimens.font_18),),
          ),

          Container(
            margin: EdgeInsets.only(left: 15.0),
            width: 80.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    if(orderItem.product.unitPrice[orderItem.unitPriceItemIndex].checkCount <= 0) return;
                    orderItem.product.unitPrice[orderItem.unitPriceItemIndex].checkCount--;
                    bloc.orderListBloc.comListData.sink.add(bloc.orderListBloc.comList);
                    bloc.menulListBloc.comListData.sink.add(bloc.menulListBloc.comList);
                  },
                  child: Container(
                    height: 20.0,
                    width: 20.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.cardBottomColor,
                    ),
                    child: Image.asset(
                      'assets/images/subSign.png',
                        fit: BoxFit.fill,
                        height: 20.0,
                        width: 20.0,
                    ),
                  ),
                ),

                Text(
                  '${orderItem.product.unitPrice[orderItem.unitPriceItemIndex].checkCount}', 
                  style: TextStyle(
                    color: orderItem.product.unitPrice[orderItem.unitPriceItemIndex].checkCount > 0 ? AppColors.countColor : AppColors.descriptionFontColor, 
                    fontSize: AppDimens.font_20
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    orderItem.product.unitPrice[orderItem.unitPriceItemIndex].checkCount++;
                    bloc.orderListBloc.comListData.sink.add(bloc.orderListBloc.comList);
                    bloc.menulListBloc.comListData.sink.add(bloc.menulListBloc.comList);
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.cardBottomColor,
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
          )
        ],
      ),
    );
  }
  
}


class DeskExpensionPanelWidget extends StatefulWidget{
  @override
  _DeskExpensionPanelWidgetState createState() => _DeskExpensionPanelWidgetState();
  
}

class _DeskExpensionPanelWidgetState extends State<DeskExpensionPanelWidget>{

  bool _isExpanded;

  @override
  void initState() {
    super.initState();
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    _isExpanded = bloc.currentDeskIndexBloc.com == null;
  }


  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    return StreamBuilder(
      stream: bloc.deskListBloc.comListStream,
      builder: (BuildContext context, AsyncSnapshot<List<Desk>> snapshot){
        List<Desk> deskList = snapshot.data ?? <Desk> [];
        return this._buildDesksWidget(context, bloc, deskList);
      }
    );
    
  }
  
  /// 吧台桌子
  Widget _buildDesksWidget(BuildContext context, MainBloc bloc, List<Desk> deskList){
    return StreamBuilder(
      stream: bloc.currentDeskIndexBloc.comStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot){
        String currentDesk = snapshot.data != null ? deskList[snapshot.data].name: '';
        return Container(
          color: AppColors.topNaviColor,
          // color: Colors.red,
          // padding: EdgeInsets.only(bottom: 20.0),
          child: ExpansionPanelList(
            children : <ExpansionPanel>[
              ExpansionPanel(
                headerBuilder:(context, isExpanded){
                  
                  return Container(
                    height: 70.0,
                    padding: EdgeInsets.only(left: 34.0),
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('$currentDesk', style: TextStyle(color: AppConfig.deskColor[1], fontSize: AppDimens.font_16),),
                        Text('*点击确认该笔订前，请确认正确的台号', style: TextStyle(fontSize: AppDimens.font_13, color: AppConfig.deskColor[1],)),
                      ],
                    ),
                  );
                },
                body: Container(
                  decoration: BoxDecoration(
                    color: AppColors.topNaviColor,
                    border: Border(top: BorderSide(width: 2.0, color: Colors.black))
                  ),
                  padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15),
                  child: this._buildWrapDeskWidget(context, bloc, deskList, snapshot.data),
                ),
                isExpanded: _isExpanded,
                canTapOnHeader: true,
              ),
    
            ],
            expansionCallback:(panelIndex, isExpanded){
              setState(() {
                _isExpanded = !isExpanded;
              });
            },
            animationDuration : kThemeAnimationDuration,
          )
      );
    }
    );
  }

  Widget _buildWrapDeskWidget(BuildContext context, MainBloc bloc, List<Desk> deskList, int currentIndex){
    
        
        LogUtil.e('_buildWrapDeskWidget---snapshot--->${deskList?.length}');
        List<Widget> listWidget = <Widget>[];
        for(int i=0; i< deskList.length; i++){
          listWidget.add(this._buildDeskWidget(context, bloc, deskList[i], i ,currentIndex == i));
        }
        return Wrap(
          spacing: 15.0,
          runSpacing: 15.0,
          children: listWidget,
        );
     
  }

  Widget _buildDeskWidget(BuildContext context, MainBloc bloc, Desk desk, int index,  bool checked){
    // LogUtil.e('desk color------>>>>${desk.colorType}-----${AppConfig.deskColor[desk.colorType]}');
    return GestureDetector(
      onTap: (){
        bloc.currentDeskIndexBloc.com = checked ? null : index;
        bloc.currentDeskIndexBloc.comData.sink.add(bloc.currentDeskIndexBloc.com);
      },
      child: Container(
        alignment: Alignment.center,
        height: 72.0,
        width: 98.0,
        decoration: BoxDecoration(
          color: checked ? AppConfig.deskColor[desk.colorType] : null,
          border: Border.all(color: AppConfig.deskColor[desk.colorType], width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Text('${desk.name}', style: TextStyle(color: checked ? Colors.white : AppConfig.deskColor[desk.colorType], fontSize: AppDimens.font_16),),
      ),
    );
  }
  
}
