import 'package:flutter/material.dart';

class LotteryRuleViewPage extends StatelessWidget {

  const LotteryRuleViewPage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '抽奖规则',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 17.0,
            ),
          ),
        ),
        body: Image.asset(
          'assets/lotteryImgs/pic_rule@3x.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}