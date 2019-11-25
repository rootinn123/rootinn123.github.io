
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/ui/route/app_routes.dart';

class Demo1 extends StatelessWidget {
   Demo1({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  Widget build(BuildContext context) {
    LogUtil.e('demo1-----build');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onTap: (){
            // routePage(context, AppRoutes.getInstance().orderListPage);
            routePage(context, Demo2());

          },
          child: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.blue,
            child: Text('Demo1----$title'),
          ),
        ),
      ),
    );
  }

}


class Demo2 extends StatelessWidget {
  Demo2({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  Widget build(BuildContext context) {
    LogUtil.e('demo2-----build');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onTap: (){
            routePage(context, Demo3());

          },
          child: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.blue,
            child: Text('Demo2----$title'),
          ),
        ),
      ),
    );
  }

}

class Demo3 extends StatefulWidget {
  Demo3({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _Demo3State();

}

class _Demo3State extends State<Demo3>{
  @override
  Widget build(BuildContext context) {
    LogUtil.e('demo3-----build');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onTap: (){
            routePage(context, Demo4());

          },
          child: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.blue,
            child: Text('Demo3---${widget.title}'),
          ),
        ),
      ),
    );
  }

}

class Demo4 extends StatelessWidget {
  Demo4({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  Widget build(BuildContext context) {
    LogUtil.e('Demo4-----build');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onTap: (){
          

          },
          child: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.blue,
            child: Text('Demo4----$title'),
          ),
        ),
      ),
    );
  }

}

void routePage(BuildContext context, Widget page){
  Navigator.of(context).push(
      MaterialPageRoute(
      builder: (BuildContext context){
        return page;
      },
      settings: RouteSettings(),
      maintainState: false
    ),
  );

  // Navigator.push(
  //   context, 
  //   PageRouteBuilder(
  //     opaque: false,
  //     transitionDuration: Duration(milliseconds: 300),
  //     pageBuilder: (_, __, ___) => page,
  //   ),
  // );
}