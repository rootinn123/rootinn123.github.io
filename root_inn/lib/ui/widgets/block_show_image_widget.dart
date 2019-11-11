
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:root_inn/ui/product_detail_page.dart.dart';
import 'package:root_inn/ui/route/app_routes.dart';
import 'package:root_inn/ui/widgets/widgets.dart';
import 'package:root_inn/utils/extended_cupertino_page_route.dart';
import 'package:root_inn/utils/navigator_util.dart';

class BlockShowImageWidget extends StatelessWidget{
  BlockShowImageWidget({Key key, this.menu}) : super(key: key);
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MainPageMenuHeaderWidget(menu: this.menu,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              // color: Colors.red,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: this._buildProductListWidget(context),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildProductListWidget(BuildContext context){
    List<Widget> list = [];
    list.add(Container(
      color: Colors.transparent,
      height: AppDimens.card_height,
      width: AppDimens.padding_30,
    ));
    this.menu.products.forEach((Product product){
      Widget cardWidget =  Container(
        height: AppDimens.card_height,
        width: AppDimens.card_width + AppDimens.padding_10,
        // color: Colors.blue,
        child: GestureDetector(
          onTap: (){
            Navigator.push(
              context, 
              PageRouteBuilder(
                opaque: false,
                transitionDuration: Duration(milliseconds: 300),
                pageBuilder: (_, __, ___) => AppRoutes.getInstance().productDetailPage(product: product),
              )
            );
          },
          child: Hero(
            tag: '${product.id}${product.image}',
            child: ProductCard(product: product,  ratio: 0.65,),
            transitionOnUserGestures: true
          ),
      ),
      );
      list.add(cardWidget);
    });
    return list;
  }

}

class ProductCard extends StatelessWidget{

  ProductCard({
    Key key, 
    @required this.product, 
    this.type = 1, 
    // @required this.width, 
    // @required this.height, 
    @required this.ratio,
  }) : super(key: key);
  final Product product;
  final int type;             // 1为card, 2为详情
  // final double width;
  // final double height;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    return this.buildDetail(context);
  }
 
  Widget buildDetail(BuildContext context) {
    
    return Container(
      // width: this.width,
      // height: this.height,
      child: Stack(
        children: <Widget>[
          this.type == 1 ? Container() :  this._buildDetailBackgroudWidget(context),
          Positioned.fill(child: this._buildDetailPageContentWidget(context),),
        ],
      ),
    );
  }

  Widget _buildSignImageWidget(String url){
    return CachedNetworkImage(
      imageUrl:'${Constant.DUMEI_RESOURCE_SERVER}$url',
      width: 30.0,
      height: 30.0,
      fit: BoxFit.fill,
    );
  }

  Widget _buildSignWidget(BuildContext context){
    Widget signWidget = Column(
      children: <Widget>[
        !this.product.newStatus ? Container() : this._buildSignImageWidget('${Constant.IMAGE_NEW}'),
        !this.product.recommendStatus ? Container() : this._buildSignImageWidget('${Constant.IMAGE_HEART}'),
        this.product.spiceIndex <= 0 ? Container() : this._buildSignImageWidget('${Constant.IMAGE_SPICE}'),
      ],
    );
    return Positioned(
      top: 10.0,
      right: 10.0,
      child: signWidget,
    );
  }
  
  Widget _buildDetailBackgroudWidget(BuildContext context){
    return Positioned.fill(
      child: ClipRect(  //裁切长方形
        child: BackdropFilter(   //背景滤镜器
          filter: ImageFilter.blur(sigmaX: 10.0,sigmaY: 10.0), //图片模糊过滤，横向竖向都设置5.0
          child: GestureDetector(
            onTap: (){
              LogUtil.v('pop===========>>>');
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        )
      )
    );
  }

  Widget _buildDetailPageContentWidget(BuildContext context){
    // double cardHeight = this.type == 1 ? this.height : this.height - AppDimens.padding_80;
    // double cardWidth = this.type == 1 ? this.width : this.width - 2*AppDimens.padding_80;
    // LogUtil.v('------>>>>>>>>${cardHeight * ratio}-----${cardHeight * (1 - ratio)}');
    return Container(
        margin: this.type == 1 ? EdgeInsets.only(right: AppDimens.padding_10) : EdgeInsets.only(left: AppDimens.padding_80, top: AppDimens.padding_80, right:  AppDimens.padding_80) ,
        // padding: this.type == 2 ? : null,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(AppDimens.radius_10,)),
        ),
        // child: Text('sadasdaasd'),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: type == 1 ? 13 : 8,
              child: Container(
                // width: cardWidth,
                child: this._buildDetailHeaderWidget(context),
              )
            ),
              Expanded(
                flex: type == 1 ? 7 : 2,
              child: Container(
                // width: cardWidth,
                child: this._buildDetailBottomWidget(context),
              )
            )

          ],
        )
    );
  }

  Widget _buildDetailMainImageWidget(){

    String url = '${this.product.image}'.indexOf('http') >=0 ? '${this.product.image}' : '${Constant.DUMEI_RESOURCE_SERVER}${this.product.image}';

    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(AppDimens.radius_10,), topRight: Radius.circular(AppDimens.radius_10,)),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          alignment: Alignment.center,
          color: AppColors.topNaviColor,
          // child: Text('RootInn', style: TextStyle(fontSize: AppDimens.font_24, color: Colors.white60),),
        ),
        errorWidget: (context, url, error) => 
          Container(
            alignment: Alignment.center,
            color: AppColors.topNaviColor,
            child: Text('暂未上图', style: TextStyle(fontSize: AppDimens.font_36, color: AppColors.selectedFontColor),),
          ),
      ),
    );
  }

  Widget _buildDetailHeaderWidget(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          this._buildDetailMainImageWidget(),
          this._buildSignWidget(context)
        ],
      ),
    );
  }

  Widget _buildDetailBottomWidget(BuildContext context){
    return Container(
      padding: this.type == 1 ?  
        EdgeInsets.only(top: AppDimens.padding_20, left: AppDimens.padding_20, right: AppDimens.padding_20)
      :
        EdgeInsets.only(top: AppDimens.padding_45, left: AppDimens.padding_40, right: AppDimens.padding_40)
      ,
      decoration: BoxDecoration(
        color: AppColors.topNaviColor,
        // color: Colors.blue,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(AppDimens.radius_10,), bottomRight: Radius.circular(AppDimens.radius_10,)),
      ),
      child: Column(
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[ 
              Expanded(
                flex: 5,
                child: Text('${this.product.name}', 
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'pixel',
                  decoration: TextDecoration.none,
                  fontSize: this.type ==1 ? AppDimens.font_18 : AppDimens.font_24,
                  color: Colors.white,
                ), overflow: TextOverflow.ellipsis, maxLines: 1,),
              ),
              this._buildDetailBottomTopPriceWidget(),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: AppDimens.padding_4),
          ),
          this._buildDetailCenterDescWidget(context),
          Padding(
            padding: EdgeInsets.only(top: AppDimens.padding_4),
          ),
          ObjectUtil.isNotEmpty(this.product.aliasName) && this.type == 2 ? 
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: AppDimens.padding_2),
              child: Text(
                '${this.product.description}', 
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: AppDimens.font_12, 
                  color: AppColors.descriptionFontColor,
                  fontFamily: 'pixel',
                  decoration: TextDecoration.none,
                )
              ),
            )
          : 
            Container(),
          
        ],
      ),
    );
  }

  /// 详情时显示价格
  Widget _buildDetailBottomTopPriceWidget(){
    // return Container();
    if(this.type == 1) return Container();
    String priceInfo = this.product.price;
    if(ObjectUtil.isEmptyList(this.product.unitPrice)){
      priceInfo = '${this.product.price}${this.product.currency}';
    }else{
      priceInfo = this.product.unitPrice.map((Map<String, dynamic> map){
        return '${map[AppHttpConstant.PRICE]}${map[AppHttpConstant.UNIT]}';
      }).join(' ');
    }
    return Expanded(
      flex: 3,
      child: Text(
        '$priceInfo', 
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontFamily: 'pixel',
            decoration: TextDecoration.none,
            fontSize: AppDimens.font_24,
            color: Colors.white,
          ), 
        overflow: TextOverflow.ellipsis, 
        maxLines: 1,
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildDetailCenterDescWidget(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppDimens.padding_2),
      child: Row(
        children: <Widget>[
          this.type == 1 && !ObjectUtil.isEmptyList(this.product.mark) ?
           Container() 
          : 
            Padding(
              padding: EdgeInsets.only(right: 4.0),
              child: Text(
                '${this.product.aliasName}', 
                style: TextStyle(
                  fontSize: AppDimens.font_16, 
                  color: AppColors.descriptionFontColor,
                  fontFamily: 'pixel',
                  decoration: TextDecoration.none,
                )
              ),
            ),
          SizedBox(
            width: 120,
            child: MarkWidget(mark: this.product.mark[0],),
          ),
          this.type == 2 &&  this.product.mark.length > 1 ? 
            SizedBox(
              width: 120,
              child: MarkWidget(mark: this.product.mark[1],),
            ) 
          : 
            Container(),
          this.type == 1 ? Expanded(
            child: Text(
              '${this.product.price}${this.product.currency}', 
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'pixel',
                  decoration: TextDecoration.none,
                  fontSize: AppDimens.font_14,
                  color: Colors.white,
                ), 
                overflow: TextOverflow.ellipsis, 
                maxLines: 1,
                textAlign: TextAlign.right,
              ),
          ): Container(),
        ],
      ),
    );
  }


}