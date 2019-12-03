import 'package:root_inn/common/commom.dart';

class DumeiApi {

  /// Home 接口 begin
  static const String INITIAL_DATA = "data/app_menu_type.json";                  // 初始数据
  static const String DESK_DATA = "data/desk.json";      
  static const String LOTTERY_DATA = "data/lottery.json";                       // 初始数据
  // static const String MENU_AFTERNOON_TEA = "data/menu_afternoon_tea.json";                  // 下午茶
  // static const String MENU_BAR_TIME = "data/menu_bar_time.json";                            // 下午茶
  // static const String MENU_DINNER = "data/menu_dinner.json";                                // 下午茶
  // static const String MENU_LUNCH = "data/menu_lunch.json";                                  // 下午茶

  static String getPath({String path: '', int page, String resType: 'json'}) {
    StringBuffer sb = new StringBuffer(Constant.SERVER_ADDRESS + path);
    if (page != null) {
      sb.write('/$page');
    }
    return sb.toString();
  }
  
}
