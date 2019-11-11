import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:root_inn/utils/extended_cupertino_page_route.dart';

class NavigatorUtil {

  // static Future pushPage(
  //   BuildContext context, 
  //   Widget page, 
  //   {
  //     bool replace = false, 
  //     bool isInitialRoute = false, 
  //     bool maintainState = true, 
  //     bool fullscreenDialog = false,
  //     Object arguments 
  //   }) {
      
  //   if (context == null || page == null) return null;

  //   if(replace){
      
  //     return Navigator.pushReplacement(
  //       context, CupertinoPageRoute<void>(
  //         builder: (ctx) => page, 
  //         settings: RouteSettings(
  //           isInitialRoute: isInitialRoute
  //         ),
  //         maintainState : maintainState,
  //         fullscreenDialog: fullscreenDialog,
  //       )
  //     );
  //   }
    
  //   return Navigator.push(
  //     context, 
  //     CupertinoPageRoute<void>(
  //       builder: (ctx) => page, 
  //       settings: RouteSettings(
  //         isInitialRoute: isInitialRoute
  //       ),
  //       maintainState : maintainState,
  //       fullscreenDialog: fullscreenDialog,
  //     )
  //   );
    
    
  // }

  static Future pushPage(
    BuildContext context, 
    Widget page, 
    {
      bool replace = false, 
      bool isInitialRoute = false, 
      bool maintainState = true, 
      bool fullscreenDialog = false,
      bool useXCupertinoPageRoute = false,
      Object arguments, 
    }) {
      
    if (context == null || page == null) return null;

    if(replace){
      if(useXCupertinoPageRoute){
        return showXCupertinoModalReplacement(
          context: context,
          builder: (ctx) => page, 
        ).then((val) {
            // print(val);
        });
      } else{
        return Navigator.pushReplacement(
          context, CupertinoPageRoute<void>(
            builder: (ctx) => page, 
            settings: RouteSettings(
              isInitialRoute: isInitialRoute
            ),
            maintainState : maintainState,
            fullscreenDialog: fullscreenDialog,
          )
        );
      }
    }
    
    if(useXCupertinoPageRoute){
      return showXCupertinoModalPopup(
        context: context,
        builder: (ctx) => page, 
      );
      // return Navigator.push(
      //   context, 
      //   XCupertinoPageRoute<void>(
      //     builder: (ctx) => page, 
      //     settings: RouteSettings(
      //       isInitialRoute: isInitialRoute
      //     ),
      //     maintainState : maintainState,
      //     fullscreenDialog: fullscreenDialog,
      //   )
      // );
    } else{
      return Navigator.push(
        context, 
        CupertinoPageRoute<void>(
          builder: (ctx) => page, 
          settings: RouteSettings(
            isInitialRoute: isInitialRoute
          ),
          maintainState : maintainState,
          fullscreenDialog: fullscreenDialog,
        )
      );
    }
    
    
  }

  static Future pushByPageName(BuildContext context, String pageName, {replace = false}) {
    if (context == null || ObjectUtil.isEmpty(pageName)) return null;
    if(!replace){
      return Navigator.pushNamed(context, pageName);
    } else{
      return Navigator.pushReplacementNamed(context, pageName);
    }
    
  }
}
