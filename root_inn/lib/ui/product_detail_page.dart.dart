
import 'package:flutter/material.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/ui/widgets/block_show_image_widget.dart';


class ProductDetailPage extends StatelessWidget{

  ProductDetailPage({
    Key key, 
    @required this.product, 
    @required  this.isHero,
  }) : super(key: key);
  final Product product;
  final bool isHero;

  @override
  Widget build(BuildContext context) {
    Widget productCard = ProductCard(product: product, type: 2, ratio: 0.8,);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: this.isHero ? 
        Hero(
          tag: '${product.id}${product.image}',
          child: productCard,
          transitionOnUserGestures: true
        )
      :
        productCard,
    );
  }
 

}
