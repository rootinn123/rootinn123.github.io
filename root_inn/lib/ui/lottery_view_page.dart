import 'package:flutter/material.dart';
import 'package:root_inn/ui/lottery_rule_view_page.dart';
import 'package:root_inn/ui/main_page.dart';
import 'package:root_inn/ui/widgets/LotteryCircle.dart';
import 'package:root_inn/ui/widgets/ScrollListView.dart';
import 'package:root_inn/ui/widgets/widgets.dart';

class LotteryViewPage extends StatelessWidget {

  const LotteryViewPage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                child: Image.asset(
                  'assets/lotteryImgs/bg_raffle@3x.png',
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Positioned(
              top: MainPage.appHeaderHeight,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                child: LotteryColumn(),
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child:Appheader(title: '幸运抽奖', bgColor: Colors.transparent,),
            ),
          ],
        ),
      ),
    );
  }
}


class LotteryColumn extends StatefulWidget {

  @override
  _LotteryColumnState createState() => new _LotteryColumnState();
}

class _LotteryColumnState extends State<LotteryColumn> {

  int _lotteryCount = 5;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   margin: EdgeInsets.only(top: 11),
          //   child: LotteryFirstView(),
          // ),
          
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              
              Container(
                // color: Colors.red,
                padding: EdgeInsets.all(5),
                child: LotteryCirclePan(
                  tapClickBlock: () {
                    setState(() {
                      _lotteryCount--;
                    });
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 110),
                width: 32,
                height: 44,
                // color: Colors.green,
                child: Image.asset(
                  'assets/lotteryImgs/pic_sel@3x.png',
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 38),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                      'assets/lotteryImgs/pic_gft@3x.png'
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7),
                  child: Text(
                    // '今天还剩 ' + '$_lotteryCount' + ' 次抽奖机会',
                    '',
                    style: TextStyle(
                      color: Color(0xFFB25200),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LotteryFirstView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //第一行
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 32,
              width: 210,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/lotteryImgs/bg_user message@3x.png',
                     fit: BoxFit.fill,
                  ),
                  ScrollListView(),
                ],
              ),
            ),
            Container(
              width: 72,
              height: 28,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width - 210 - 72),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/lotteryImgs/bg_regular@3x.png',
                    fit: BoxFit.fill,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(new PageRouteBuilder(
                        pageBuilder: (BuildContext context, _, __) {
                          return LotteryRuleViewPage();
                        },
                        transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                            Widget child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(1.0, 0),
                              end: Offset(0, 0),
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 13),
                      child: Center(
                        child: Text(
                          '游戏规则',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        //第二行
        Container(
          height: 59,
          margin: EdgeInsets.only(top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              MyStarView(),
              Container(
                width: 72,
                height: 28,
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width - 167 - 72, bottom: 25),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/lotteryImgs/bg_regular@3x.png',
                      fit: BoxFit.fill,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 13,),
                      child: Center(
                        child: Text(
                          '实物奖品',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}

class MyStarView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 167,
      height: 39,
      margin: EdgeInsets.only(top: 14),
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/lotteryImgs/bg_my star@3x.png',
            fit: BoxFit.fill,
          ),
          Container(
            margin: EdgeInsets.only(left: 13, top: 8.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '我的星星',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 22,
                  height: 22,
                  margin: EdgeInsets.only(left: 15),
                  child: Image.asset(
                    'assets/lotteryImgs/picStar@3x.png',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 11),
                  child: Text(
                    '42',
                    style: TextStyle(
                      color: Color(0xFFFFEAB0),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}