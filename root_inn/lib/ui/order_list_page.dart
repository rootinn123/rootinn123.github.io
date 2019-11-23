import 'package:flutter/material.dart';
import 'package:root_inn/blocs/bloc_index.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:root_inn/ui/widgets/widgets.dart';

class OrderListPage extends StatelessWidget{

  const OrderListPage({Key key}): super(key: key);

  static Map<int, Color> deskColor = {
    1: AppColors.primaryColor,
    2: AppColors.updateButtonNaviColor,
    3: Color.fromRGBO(15, 101, 69, 1.0),
    4: Color.fromRGBO(255, 175, 0, 1.0),
    5: Color.fromRGBO(198, 0, 255, 1.0),
    5: Color.fromRGBO(164, 164, 164, 1.0),
  };

  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: bloc.orderListBloc.comListStream,
        builder: (BuildContext context, AsyncSnapshot<List<OrderItem>> snapshot){
          List<OrderItem> orderList = snapshot.data ?? <OrderItem>[];
          double amount = 0.0;
          for(OrderItem orderItem in orderList){
            amount += double.parse('$orderItem.unitPriceItem[AppHttpConstant.PRICE]') * orderItem.count;
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
              child: Container(
                padding: EdgeInsets.only(left: AppDimens.padding_20, top: AppConfig.appBarHeight),
                child: Column(
                  children: <Widget>[
                    DeskExpensionPanelWidget(),
                    Padding(
                      padding: EdgeInsets.only(top: AppDimens.padding_30,),
                      child: Text('我的食谱', style: TextStyle(color: Colors.white, fontSize: AppDimens.font_24),),
                    ),
                    this._buildOrdersWidget(context, bloc, orderList),
                  ],                  
                ),
              ),
            ),
          ),

          Appheader(title: '食谱列表',),

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
        color: AppColors.primaryColor,
      ),
      child: Row(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text('数量： $categoryCount'),
                Container(
                  width: AppDimens.padding_30,
                ),
                Text('合计： $amount'),
              ],
            ),
          ),

          GestureDetector(
            onTap: (){
              bloc.orderListBloc.comListData.sink.add(<OrderItem>[]);
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
          )
        ],
      ),
    );
  }

  /// 购物清单
  Widget _buildOrdersWidget(BuildContext context, MainBloc bloc, List<OrderItem> orderList){
    List<Widget> listWidget = orderList.map((OrderItem orderItem){
      return Offstage(
        offstage: orderItem.count <= 0,
        child: this._buildOrderItemWidget(context, bloc, orderItem),
      );
    }).toList();
    return Container(
      child: Column(
        children: listWidget,
      ),
    ); 
    
  }

  Widget _buildOrderItemWidget(BuildContext context, MainBloc bloc, OrderItem orderItem){
    return Container(
      margin: EdgeInsets.only(bottom: AppDimens.padding_10),
      width: AppDimens.order_item_width,
      height: AppDimens.order_item_height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
        color: AppColors.primaryColor,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Text('${orderItem.product.name}', style: TextStyle(color: Colors.white, fontSize: AppDimens.font_17), maxLines: 1, overflow: TextOverflow.ellipsis,),
                Text('${orderItem.product.aliasName}', style: TextStyle(color: AppColors.descriptionFontColor, fontSize: AppDimens.font_12), maxLines: 1, overflow: TextOverflow.ellipsis,),
              ],
            ),
          ),

          Container(
            child: Text('${orderItem.unitPriceItem[AppHttpConstant.PRICE]}/${orderItem.unitPriceItem[AppHttpConstant.UNIT]}'),
          ),

          Container(
            margin: EdgeInsets.only(left: 15.0),
            width: 76.0,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    if(orderItem.count <= 0) return;
                    orderItem.count--;
                    bloc.orderListBloc.comListData.sink.add(bloc.orderListBloc.comList);
                  },
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

                Text(
                  '${orderItem.count}', 
                  style: TextStyle(
                    color: orderItem.count > 0 ? AppColors.countColor : AppColors.descriptionFontColor, 
                    fontSize: AppDimens.font_16
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    orderItem.count++;
                    bloc.orderListBloc.comListData.sink.add(bloc.orderListBloc.comList);
                  },
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

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return this._buildDesksWidget(context);
  }
  
  /// 吧台桌子
  Widget _buildDesksWidget(BuildContext context){
    return ExpansionPanelList(
        children : <ExpansionPanel>[
          ExpansionPanel(
            headerBuilder:(context, isExpanded){
              return ListTile(
                title: Text('当前台号', style: TextStyle(fontSize: AppDimens.font_24, color: Colors.white),),
              );
            },
            body: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: this._buildWrapDeskWidget(context),
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
      );
  }

  Widget _buildWrapDeskWidget(BuildContext context){
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    return StreamBuilder(
      stream: bloc.currentDeskIndexBloc.comStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot){
        List<Desk> deskList = bloc.deskListBloc.comList ?? <Desk> [];
        List<Widget> listWidget = <Widget>[];
        for(int i=0; i< deskList.length; i++){
          listWidget.add(this._buildDescWidget(context, bloc, deskList[i], i ,snapshot.data == i));
        }
        return Wrap(
          children: listWidget,
        );
      },
    );
  }

  Widget _buildDescWidget(BuildContext context, MainBloc bloc, Desk desk, int index,  bool checked){
    return GestureDetector(
      onTap: (){
        bloc.currentDeskIndexBloc.comData.sink.add(checked ? null : index);
      },
      child: Container(
        alignment: Alignment.center,
        height: 98.0,
        width: 72.0,
        decoration: BoxDecoration(
          color: checked ? OrderListPage.deskColor[desk.colorType] : null,
          border: Border.all(color: OrderListPage.deskColor[desk.colorType], width: 1.0)
        ),
        child: Text('${desk.name}', style: TextStyle(color: checked ? Colors.white : OrderListPage.deskColor[desk.colorType], fontSize: AppDimens.font_16),),
      ),
    );
  }
  
}
