
import 'package:flutter/material.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/ui/lottery_rule_view_page.dart';
import 'package:root_inn/ui/lottery_view_page.dart';
import 'package:root_inn/ui/main_page.dart';
import 'package:root_inn/ui/main_view_more_page.dart';
import 'package:root_inn/ui/order_list_page.dart';
import 'package:root_inn/ui/product_detail_page.dart.dart';

import '../order_confirm_result_page.dart';


class AppRoutes{
  AppRoutes._();

  static AppRoutes _instance;

  static AppRoutes getInstance() {
    if (_instance == null) {
      _instance = AppRoutes._();
    }
    return _instance;
  }

  Widget get mainPage => MainPage();

  Widget get orderListPage => const OrderListPage();

   Widget get lotteryRuleViewPage => const LotteryRuleViewPage();

  Widget mainViewMorePage({@required Menu menu}) => MainViewMorePage(menu: menu, );

  Widget productDetailPage({@required Product product, bool isHero=true}) => ProductDetailPage(product: product, isHero: isHero);

  Widget get lotteryViewPage => const LotteryViewPage();

  Widget get orderConfirmResultPage => OrderConfirmResultPage();

  
}