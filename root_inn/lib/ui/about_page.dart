
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/resources/app_dimens.dart';
import 'package:root_inn/ui/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutPage extends StatelessWidget{
  AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          this._buildPageWidget(context),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child:Appheader(title: 'What is ROOT INN ?',),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPageWidget(BuildContext context){
    return Positioned.fill(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: AppConfig.appHeaderHeight, bottom: AppConfig.bottomNaviHeight + 10.0, ),
          color: Colors.transparent,
          child: WebView(
            initialUrl: Constant.SERVER_ADDRESS,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {},
            javascriptChannels: <JavascriptChannel>[].toSet(),
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            ].toSet(),
            onPageFinished: (String url) {
            },
          ),
        ),
      ),
    );
  }

  

 
}