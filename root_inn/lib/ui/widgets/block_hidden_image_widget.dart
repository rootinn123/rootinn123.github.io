
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:root_inn/ui/widgets/select_order_count_widget.dart';
import 'package:root_inn/ui/widgets/widgets.dart';

class BlockHiddenImageWidget extends StatelessWidget{
  BlockHiddenImageWidget({Key key, this.menu, this.type = 1}) : super(key: key);
  final Menu menu;
  final int type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: <Widget>[
          MainPageMenuHeaderWidget(menu: this.menu,),
          this._buildHiddenImageProductsWidget(context),
        ],
      ),
    );
  }

  Widget _buildHiddenImageProductsWidget(BuildContext context){
    if(ObjectUtil.isEmptyList(this.menu.products)) return Container();
    double height = this.menu.products.length >= 3 ? 260.0 : this.menu.products.length * 80.0 + (this.menu.products.length - 1) * 10.0;
    // double itemWidget = AppConfig.appScreenWidth - 60.0;
    double itemWidget = AppDimens.no_img_card_width*3 + 20.0;
    List<Widget> list = [];
    list.add(Container(
      color: Colors.transparent,
      height: height,
      width: AppDimens.padding_20,
    ));
    this.menu.products.forEach((Product product){
      list.add(
        this._buildProductItemWidget(context, product, itemWidget),
      );
    });
    Widget wrapWidget = Wrap(
      direction: Axis.vertical,
      spacing: 10.0,
      runSpacing: 10.0,
      children: list,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
    );
    return Container(
      alignment: Alignment.topLeft,
      height: height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: wrapWidget,
      ),
    );
  }

  Widget _buildProductItemWidget(BuildContext context, Product product, double width){

    List<Widget> priceList = <Widget>[];
    
    for(int i=0; i < product.unitPrice.length; i++){
      priceList.add(
        this._buildPriceInfoWidget(
          context, 
          '${product.unitPrice[i].price}', product.unitPrice[i].unit, 
        ), 
      );
      // if(i < (product.unitPrice.length - 1)){
      //   priceList.add(
      //     Expanded(
      //       flex: 1,
      //       child: Container(
      //         width: 0.2,
      //         color: Colors.white,
      //       ),
      //     )
      //   );
      // }
    }
    
    return Container(
      padding: EdgeInsets.only(left: AppDimens.padding_20),
      width: width,
      height: AppDimens.width_80,
      decoration: BoxDecoration(
        color: AppColors.topNaviColor,
        borderRadius: BorderRadius.all(Radius.circular(AppDimens.radius_5))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Expanded(
            child: GestureDetector(
              onTap: (){
                if(ObjectUtil.isEmpty(product.image)) return;
                // NavigatorUtil.pushPage(context, AppRoutes.getInstance().productDetailPage(product: product, isHero: false), useXCupertinoPageRoute: true);
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    this._buildNameInfoWidget(context, product.name, product.aliasName),
                    Container(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: priceList,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            width: 181.0,
            padding: EdgeInsets.only(left: 1.0),
            color: Colors.black,
            child: product.unitPrice.length  == 1 ?  Column(
                children: <Widget>[
                  SelectOrderCountWidget(type: this.type, product: product, width: 180.0, height: 80.0,unitPriceIndex: 0,),
                ],
              ): 
              product.unitPrice.length  == 2 ?  Column(
                children: <Widget>[
                  SelectOrderCountWidget(type: this.type, product: product, width: 180.0, height: 39.5,unitPriceIndex: 0,),
                  Container(height: 1.0,width: 180.0, color: Colors.black,),
                  SelectOrderCountWidget(type: this.type, product: product, width: 180.0, height: 39.5,unitPriceIndex: 1,),
                ],
              ): Container(),
            
          )
        ],
      ),
    );
  }

  Widget _buildNameInfoWidget(BuildContext context, String topWord, String bottomWord){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // height: 30.0,
            alignment: Alignment.bottomCenter,
            child: Text('$topWord', style: TextStyle(fontSize: AppDimens.font_16),),
          ),
          Container(height: 4.0,),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text('$bottomWord', style: TextStyle(fontSize: AppDimens.font_12, color: AppColors.descriptionFontColor),),
          )
        ],
      ),
    );
  }
  Widget _buildPriceInfoWidget(BuildContext context, String topWord, String bottomWord){
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 6.0),
            child: Text('$bottomWord', style: TextStyle(fontSize: AppDimens.font_12, color: AppColors.descriptionFontColor),),
          ),
          Container(
            alignment: Alignment.center,
            child: Text('$topWord', style: TextStyle(fontSize: AppDimens.font_18, color: AppColors.priceFontColor),),
          ),
          
        ],
      ),
    );
  }
}