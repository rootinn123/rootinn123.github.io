
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:root_inn/ui/route/app_routes.dart';
import 'package:root_inn/ui/widgets/widgets.dart';
import 'package:root_inn/utils/navigator_util.dart';

class BlockHiddenImageWidget extends StatelessWidget{
  BlockHiddenImageWidget({Key key, this.menu}) : super(key: key);
  final Menu menu;

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
    double itemWidget = AppDimens.card_width*3 + 20.0;
    List<Widget> list = [];
    list.add(Container(
      color: Colors.transparent,
      height: height,
      width: AppDimens.padding_20,
    ));
    this.menu.products.forEach((Product product){
      list.add(
        GestureDetector(
          onTap: (){
            NavigatorUtil.pushPage(context, AppRoutes.getInstance().productDetailPage(product: product, isHero: false), useXCupertinoPageRoute: true);
          },
          child: this._buildProductItemWidget(context, product, itemWidget),
        )
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
          product.unitPrice[i][AppHttpConstant.PRICE], product.unitPrice[i][AppHttpConstant.UNIT], 
        ), 
      );
      if(i < (product.unitPrice.length - 1)){
        priceList.add(
          Container(
            width: 0.2,
            height: 25.0,
            color: Colors.white,
          )
        );
      }
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.padding_20),
      width: width,
      height: AppDimens.width_80,
      decoration: BoxDecoration(
        color: AppColors.topNaviColor,
        borderRadius: BorderRadius.all(Radius.circular(AppDimens.radius_5))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          this._buildNameInfoWidget(context, product.name, product.aliasName),
          Container(
            child: Row(
              children: priceList,
            ),
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
            child: Text('$topWord', style: TextStyle(fontSize: AppDimens.font_18),),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text('$bottomWord', style: TextStyle(fontSize: AppDimens.font_16, color: AppColors.descriptionFontColor),),
          )
        ],
      ),
    );
  }
  Widget _buildPriceInfoWidget(BuildContext context, String topWord, String bottomWord){
    return Container(
      decoration: BoxDecoration(
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 40.0,
            // height: 30.0,
            alignment: Alignment.bottomCenter,
            child: Text('$topWord', style: TextStyle(fontSize: AppDimens.font_20),),
          ),
          Container(
            width: 40.0,
            alignment: Alignment.bottomCenter,
            child: Text('$bottomWord', style: TextStyle(fontSize: AppDimens.font_12, color: AppColors.descriptionFontColor),),
          )
        ],
      ),
    );
  }
}