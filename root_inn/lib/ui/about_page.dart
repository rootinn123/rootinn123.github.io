
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/common/commom.dart';
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
    return Positioned(
      top:AppConfig.appHeaderHeight,
      left: 10.0,
      right: 10.0,
      bottom: 0.0,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: '${Constant.SERVER_ADDRESS}/images/about/图-1.png',
                fit: BoxFit.fitWidth,
              ),
              CachedNetworkImage(
                imageUrl: '${Constant.SERVER_ADDRESS}/images/about/图-2.png',
                fit: BoxFit.fitWidth,
              ),
              CachedNetworkImage(
                imageUrl: '${Constant.SERVER_ADDRESS}/images/about/图-3.png',
                fit: BoxFit.fitWidth,
              ),
              CachedNetworkImage(
                imageUrl: '${Constant.SERVER_ADDRESS}/images/about/图-4.png',
                fit: BoxFit.fitWidth,
              ),
              CachedNetworkImage(
                imageUrl: '${Constant.SERVER_ADDRESS}/images/about/图-5.png',
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        )
      ),
    );
}

// class AboutPage extends StatefulWidget{
//   AboutPage({Key key}) : super(key: key);

//   @override
//   _AboutPageState createState() => _AboutPageState();
// }
// class _AboutPageState extends State<AboutPage>{

//   bool mask = true;

//    @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: <Widget>[
//           this._buildPageWidget(context),
//           Positioned(
//             top: 0.0,
//             left: 0.0,
//             right: 0.0,
//             child:Appheader(title: 'What is ROOT INN ?',),
//           ),
//         ],
//       ),
//     );
//   }

  
  
//   Widget _buildPageWidget(BuildContext context){
//     return Positioned(
//       top:AppConfig.appHeaderHeight,
//       left: 4.0,
//       right: 4.0,
//       bottom: 0.0,
//       child: Container(
//         child: WebView(
//           initialUrl: Constant.SERVER_ADDRESS,  //Constant.SERVER_ADDRESS
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController webViewController) {
//             Future.delayed(Duration(milliseconds: 500)).then((_){
//               if(mounted){
//                 setState(() => mask = false);
//               }
//             });
//           },
//           javascriptChannels: <JavascriptChannel>[].toSet(),
//           gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//             Factory<OneSequenceGestureRecognizer>(
//               () => EagerGestureRecognizer(),
//             ),
//           ].toSet(),
//           onPageFinished: (String url) {
//           },
//         ),
//         foregroundDecoration: BoxDecoration(
//           color: mask ? Colors.black : null,
//         ),
//       ),
//     );
//   }

  

 
// }