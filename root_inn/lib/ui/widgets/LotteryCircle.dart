import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/blocs/bloc_index.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'dart:math';
import 'LotteryAwardAlert.dart';

typedef void OnTapClickBlock();

class LotteryCirclePan extends StatefulWidget {

  LotteryCirclePan({this.tapClickBlock});
  final OnTapClickBlock tapClickBlock;
  @override
  _LotteryCirclePanState createState() => new _LotteryCirclePanState();
}




class _LotteryCirclePanState extends State<LotteryCirclePan> with SingleTickerProviderStateMixin {
  
  List<LotteryItemModel>_lotteryList;
  int totalCoefficient = 0;
  // final List<LotteryItemModel>_lotteryList = <LotteryItemModel>[
  //   LotteryItemModel(
  //     title: '10颗星星',
  //     icon: 'item_stars@3x',
  //   ),
  //   LotteryItemModel(
  //     title: '悠悠球',
  //     icon: 'item_ball@3x',
  //   ),
  //   LotteryItemModel(
  //     title: '100g蜂蜜',
  //     icon: 'item_honeys@3x',
  //   ),
  //   LotteryItemModel(
  //     title: '谢谢参与',
  //     icon: 'item_thanks@3x',
  //   ),
  //   LotteryItemModel(
  //     title: '10g蜂蜜',
  //     icon: 'item_honey@3x',
  //   ),
  //   LotteryItemModel(
  //     title: '油画棒',
  //     icon: 'item_draw@3x',
  //   ),
  //   LotteryItemModel(
  //     title: '2颗星星',
  //     icon: 'item_star@3x',
  //   ),
  //   LotteryItemModel(
  //     title: '字母笔',
  //     icon: 'item_wordPen@3x',
  //   ),
  // ];

  List<Widget>getItemWidgets(){

    List<Widget>_itemWidgets = <Widget>[];
    for (int i = 0; i < _lotteryList.length; i++) {

      LotteryItemModel itemModel = _lotteryList[i];
      Widget item = MyTransitionItem(
        angle: pi / 180.0 * (i * 1.0 / _lotteryList.length) * 360.0,
        child: Transform.rotate(
          angle: pi / 180.0 * (i * 1.0 / _lotteryList.length) * 360.0 + 90 * pi / 180.0,
          child: Container(
            width: 250.0,
            height: 250.0,
            // color: Colors.yellow,
            // color: Colors.yellow,
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  itemModel.title,
                  style: TextStyle(
                    color: Color(0xFF974500),
                    fontSize: AppDimens.font_16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
  //              HeroGiftView(
  //                isAlertStyle: false,
  //                giftImg: 'assets/lotteryImgs/' + itemModel.icon + '.png',
  //              ),
                Container(
                  width: 80.0,
                  height: 80.0,
                  // child: Image.asset(
                  //   'assets/lotteryImgs/' + itemModel.icon + '.png',
                  //   fit: BoxFit.fill,
                  // ),
                  child: CachedNetworkImage(
                    imageUrl: '${Constant.DUMEI_RESOURCE_SERVER}${itemModel.icon}',
                    fit: BoxFit.fill,
                    errorWidget: (BuildContext context, String url, o){
                      return Image.asset(
                        'assets/lotteryImgs/item_star@3x.png',
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ),
      );
      _itemWidgets.add(item);
    }
    return _itemWidgets;
  }

  Animation<double> tween;
  AnimationController controller;
  bool _isAnimating = false;
  var _statusListener;

  @override
  void initState() {
    super.initState();

    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    this._lotteryList =  bloc.lotteryItemModelListBloc.comList ?? <LotteryItemModel>[];
    if(!ObjectUtil.isEmptyList(this._lotteryList )){
      for(LotteryItemModel lotteryItemModel in this._lotteryList){
        this.totalCoefficient += lotteryItemModel.coefficient ?? 10;
      }
    }
    //控制类对象
    controller = new AnimationController(
        duration: const Duration(milliseconds: 5000),
        vsync: this);
  }

  /// 获取抽中的奖品下标
  int _getRewardIndex(){
    int rewardIndex = Random().nextInt(this.totalCoefficient);
    int tem = 0;
    for(int i =0; i < this._lotteryList.length; i++){
      tem += this._lotteryList[i].coefficient;
      if(rewardIndex <= tem) return i;
    }
  }

  void _gestureTap() {
    // int rewardIndex = Random().nextInt(8);
    int rewardIndex = this._getRewardIndex();
    if (widget.tapClickBlock != null) {
      widget.tapClickBlock();
    }
    _statusListener = (AnimationStatus status) {
      print('$status');
      if (status == AnimationStatus.completed) {
        _isAnimating = false;
        showAwardAlert(context: context, itemModel: _lotteryList[rewardIndex]);
        tween.removeStatusListener(_statusListener);
      }
    };

    double rewardAngle = pi / 180.0 *
        (270 - (rewardIndex * 1.0 / _lotteryList.length) * 360.0);
    //补间动画
    tween = Tween<double>(
      begin: 0.0,
      end: pi * 2 * 3 + rewardAngle,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    )
      ..addListener(() {
        setState(() {

        });
      })
      ..addStatusListener(_statusListener);
    controller.reset();
    controller.forward();
    _isAnimating = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      transform: Matrix4.identity()..rotateZ(tween.value),
      padding: EdgeInsets.only(top: 31, left: 18, right: 18),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Transform.rotate(
            angle: tween != null?tween.value : 0,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                //转盘背景
                Image.asset(
                  'assets/lotteryImgs/pic_circlePan@3x.png',
                ),
                //转盘奖励内容
                Stack(
                  children: getItemWidgets(),
                ),
              ],
            ),
          ),
          //转盘中间开启按钮
          GestureDetector(
            onTap: _isAnimating?null:_gestureTap,
            child: Container(
              width: 94,
              height: 94,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/lotteryImgs/startLottery@3x.png',
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 14),
                        child: Text(
                          '开始抽奖',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(left: 14,),
                      //   child: Stack(
                      //     alignment: Alignment.center,
                      //     children: <Widget>[
                      //       ClipRRect(
                      //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      //         child: Container(
                      //           width: 46,
                      //           height: 20,
                      //           color: Colors.red,
                      //           child: Container(
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: <Widget>[
                      //                 Text(
                      //                   '-6',
                      //                   style: TextStyle(
                      //                     color: Color(0xFFFFFFFF),
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //                 Image.asset(
                      //                   'assets/lotteryImgs/item_star@3x.png',
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}

class MyTransitionItem extends StatelessWidget {

  MyTransitionItem({this.angle, this.child});
  final double angle;
  final Widget child;

  final double radius = 90.0;
  @override
  Widget build(BuildContext context) {
    final x = radius * cos(angle);
    final y = radius * sin(angle);
    return Transform(
      transform: Matrix4.translationValues(x, y, 0.0),
      child: child,
    );
  }
}