
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
        children: <Widget>[
          MainPageMenuHeaderWidget(menu: this.menu,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Row(
                children: this.menu.products.map((Product product){
                  return ProductCard(product: product,);
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

}

class ProductCard extends StatelessWidget{

  ProductCard({Key key, this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, 
          PageRouteBuilder(
            opaque: false,
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) => AppRoutes.getInstance().productDetailPage(product: this.product)
          )
        );

        // Navigator.push(
        //   context, 
        //   XCupertinoPageRoute<void>(
        //     builder: (ctx) => AppRoutes.getInstance().productDetailPage(product: this.product), 
        //     opaque: false,
        //   )
        // );
       
        // NavigatorUtil.pushPage(context, AppRoutes.getInstance().productDetailPage(product: this.product), useXCupertinoPageRoute: true);
      },
      child: this.buildContent(context),
    );
  }

  Widget _buildHeroWidget(){
    // return CachedNetworkImage(
    //   imageUrl:'${Constant.DUMEI_RESOURCE_SERVER}${this.product.image}',
    //   fit: BoxFit.cover,
    // ); 
    return Hero(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(AppDimens.radius_10,), topRight: Radius.circular(AppDimens.radius_10,)),
        child: CachedNetworkImage(
          imageUrl:'${Constant.DUMEI_RESOURCE_SERVER}${this.product.image}',
          fit: BoxFit.cover,
        ),
      ),
      tag: '${product.id}${product.image}',
      transitionOnUserGestures: true
    );
  }

  Widget buildContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: AppDimens.padding_10),
      decoration: BoxDecoration(
        color: AppColors.topNaviColor,
        borderRadius: BorderRadius.all(Radius.circular(AppDimens.radius_5)),
      ),
      child: Column(
        children: <Widget>[

          Container(
            width: 230.0,
            height: 150.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: this._buildHeroWidget(),
                ),
                Positioned(
                  top: 3.0,
                  right: 4.0,
                  child: CachedNetworkImage(
                    imageUrl:'${Constant.DUMEI_RESOURCE_SERVER}${Constant.IMAGE_NEW}',
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          ),
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.padding_20),
            alignment: Alignment.centerLeft,
            width: 230.0,
            height: 40.0,
            child: Text(
              '${this.product.name}', 
              maxLines: 1, 
              overflow: TextOverflow.ellipsis, 
              style: TextStyle(fontSize: AppDimens.font_18), 
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.padding_20),
            alignment: Alignment.topCenter,
            width: 230.0,
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                 this._buildCardBottomWidget(context),
                 Text('${this.product.price} ${this.product.currency}', style: TextStyle(fontSize: AppDimens.font_14, color: AppColors.priceFontColor),)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCardBottomWidget(BuildContext context){
    if(ObjectUtil.isEmptyList(this.product.mark)){
      return Text('${this.product.aliasName}', style: TextStyle(fontSize: AppDimens.font_12), maxLines: 1, overflow: TextOverflow.ellipsis,);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ObjectUtil.isEmptyList(this.product.mark) ?  Container(): ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 80.0,
            minWidth: 40,
          ),
          child: MarkWidget(mark: this.product.mark[0],),
        ),
        this.product.mark.length > 1 ? MarkWidget(mark: this.product.mark[1],) : Container(),
      ],
    );

  }

 

}