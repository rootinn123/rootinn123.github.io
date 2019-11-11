import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_colors.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:root_inn/ui/widgets/widgets.dart';

class ProductDetailPage extends StatelessWidget{

  ProductDetailPage({Key key, this.product}) : super(key: key);
  final Product product;

  Widget _buildHeroWidget(){
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

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: this._buildBackgroudWidget(context),
          ),
          Positioned.fill(
            child: this._buildPageContentWidget(context),
          )
        ],
      )
    );
  }
  
  Widget _buildBackgroudWidget(BuildContext context){
    return ClipRect(  //裁切长方形
      child: BackdropFilter(   //背景滤镜器
        filter: ImageFilter.blur(sigmaX: 10.0,sigmaY: 10.0), //图片模糊过滤，横向竖向都设置5.0
        child: Container(
          color: Colors.black.withOpacity(0.6),
        ),
      )
    );
  }

  Widget _buildPageContentWidget(BuildContext context){
    return Container(
      padding: EdgeInsets.only(left: AppDimens.padding_40, top: AppDimens.padding_40, right:  AppDimens.padding_40),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      // child: Text('sadasdaasd'),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: this._buildHeaderWidget(context)
          ),

          Expanded(
            flex: 2,
            child: this._buildBottomWidget(context),
          ),

        ],
      )
    );
  }

  Widget _buildHeaderWidget(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent
      ),
      child: this._buildHeroWidget(),
    );
  }

  Widget _buildBottomWidget(BuildContext context){
    return Container(
      padding: EdgeInsets.only(top: AppDimens.padding_20, left: AppDimens.padding_20, right: AppDimens.padding_20),
      decoration: BoxDecoration(
        color: AppColors.topNaviColor,
      ),
      child: Column(
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[ 
              Text('${this.product.name}', style: TextStyle(fontSize: AppDimens.font_16), overflow: TextOverflow.ellipsis, maxLines: 1,),
              Text('${this.product.price} ${this.product.currency}', style: TextStyle(fontSize: AppDimens.font_16), overflow: TextOverflow.ellipsis, maxLines: 1,),
            ],
          ),

          this._buildCenterDescWidget(context),

          ObjectUtil.isNotEmpty(this.product.aliasName) ? 
            Container(
              padding: EdgeInsets.symmetric(vertical: AppDimens.padding_2),
              child: Text('${this.product.description}', style: TextStyle(fontSize: AppDimens.font_10, color: AppColors.descriptionFontColor)),
            )
          : 
            Container(),
          
        ],
      ),
    );
  }

  Widget _buildCenterDescWidget(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppDimens.padding_2),
      child: Row(
        children: <Widget>[
          Text('${this.product.aliasName}', style: TextStyle(fontSize: AppDimens.font_10, color: AppColors.descriptionFontColor)),
          SizedBox(
          width: 120,
            child: MarkWidget(mark: this.product.mark[0],),
          ),
          this.product.mark.length > 1 ? MarkWidget(mark: this.product.mark[1],) : Container(),
        ],
      ),
    );
  }

}


// -------

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:root_inn/common/commom.dart';
// import 'package:root_inn/data/models.dart';
// import 'package:root_inn/resources/app_colors.dart';

// class ProductDetailPage extends StatefulWidget {


//   ProductDetailPage({Key key, this.product}) : super(key: key);
//   final Product product;

//   @override
//   _ProductDetailPageState createState() {
//     return _ProductDetailPageState();
//   }
// }
// class _ProductDetailPageState extends State<ProductDetailPage> with TickerProviderStateMixin {

//   Animation<double> animation;
//   AnimationController animationController;

//   double scale = 1.0;

//    ///滑动位置超过这个位置，会滚到顶部；小于，会滚动底部。
//   double maxOffsetDistance;
//   Offset endDragOffset;
//   bool canScaleStatus = false;
//   bool onResetControllerValue = false;

//   Color backgroundColor = AppColors.topNaviColor;



//   @override
//   void initState() {
//     super.initState();

    
//     maxOffsetDistance = 100.0;

//     animationController = new AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
//     // animation = new Tween(begin: 1.0, end: 1.0).animate(controller);
//   }

//   @override
//   void dispose() {
//     animationController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return Material(
//       // backgroundColor: this.backgroundColor,
//       color: Colors.black54,
//       child: GestureDetector(
//         child: Transform.scale(
//           scale: scale,
//           child: Center(
//             child: _crearCuerpo(),
//           ),
//         ),
//         // onScaleStart: (ScaleStartDetails detail)=>onScaleStart(detail),
//         // onScaleUpdate: (ScaleUpdateDetails detail)=>onScaleUpdate(detail),
//         // onScaleEnd: (ScaleEndDetails detail)=>onScaleEnd(detail),
//         onHorizontalDragStart: (DragStartDetails detail)=>onHorizontalDragStart(detail),
//         onHorizontalDragUpdate: (DragUpdateDetails detail)=>onHorizontalDragUpdate(detail),
//         onHorizontalDragEnd: (DragEndDetails detail)=>onHorizontalDragEnd(detail),
        
//       ),
      
//     );
    
//   }

//   Widget _crearCuerpo() {

//     return Column(
//       children: <Widget>[
//         Hero(
//           child: CachedNetworkImage(
//             imageUrl:'${Constant.DUMEI_RESOURCE_SERVER}${widget.product.image}',
//             fit: BoxFit.cover,
//           ),
//           tag: '${widget.product.id}${widget.product.image}', 
//         ),
//         Expanded(
//           child: Container(
//             alignment: Alignment.center,
//             color: Colors.black12,
//             child: Text(widget.product.name, style: TextStyle(fontSize: 40),)
//           )
//         )
//       ],
//     );

//   }


//   onHorizontalDragStart(DragStartDetails detail) {
//     Offset globalPosition = detail.globalPosition;
//     if(globalPosition.dx == 0.0){
//       this.canScaleStatus = true;
//     }else{
//       this.canScaleStatus = false;
//     }
//     print('onHorizontalDragStart------------->>>>Start----->>>>$canScaleStatus');

//   }

//   onHorizontalDragUpdate(DragUpdateDetails detail){
//     double screepWidth = MediaQuery.of(context).size.width;
//     Offset globalPosition = detail.globalPosition;
//     // print('onHorizontalDragUpdate-----$screepWidth----+++$canScaleStatus++----->>>>${globalPosition.dx}');
//     if(!this.canScaleStatus) return;
//     double currentScale = (screepWidth - globalPosition.dx) / screepWidth;
//     this.endDragOffset = globalPosition;

//     if(this.endDragOffset.dx >= this.maxOffsetDistance)  {
//       // Navigator.of(context).pop();
//     }else{
//       if(mounted){
//         setState(() {
//           this.scale = currentScale;
//           this.backgroundColor = Colors.transparent;
//         }); 
//       }
//     }
//     // print('onHorizontalDragUpdate-------$canScaleStatus------>>>>$globalPosition------->>>$currentScale');
    
//   }

//   onHorizontalDragEnd(DragEndDetails detail){
//     if(!this.canScaleStatus) return;
//     // print('onHorizontalDragEnd----------$canScaleStatus--${this.scale}->>>>End--->>${this.endDragOffset.dx}------${this.endDragOffset.dx >= this.maxOffsetDistance}');
//     if(this.endDragOffset.dx >= this.maxOffsetDistance)  {
//       Navigator.of(context).pop();
//     }else{
//       animationController.value = 0.0;
//       final CurvedAnimation curve =  new CurvedAnimation(parent: animationController, curve: Curves.easeOut);
//       // print('animation------------------1>>>>');
//       animation = Tween(begin: this.scale, end: 1.0).animate(curve)
//         ..addListener(() {
//             // print('animation--------addListener---------->>>>');
//           // if (!onResetControllerValue) {
//             scale = animation.value;
//             setState(() {});
//           // }
//         });
//       ///自己滚动
//       animationController.forward();
//     }
//   }

//   onScaleStart(ScaleStartDetails detail) {
//     print('onScaleStart------------->>>>Start');
//   }

//   onScaleUpdate(ScaleUpdateDetails detail){
//     print('onScaleUpdate------------->>>>Update');
//   }

//   onScaleEnd(ScaleEndDetails detail){
//     print('onScaleEnd------------->>>>End');
//   }

// }