import 'package:root_inn/common/commom.dart';

class DumeiApi {

  /// Home 接口 begin
  static const String initialData = "data/initial_data.json";                  // 初始数据

  static String getPath({String path: '', int page, String resType: 'json'}) {
    StringBuffer sb = new StringBuffer(Constant.SERVER_ADDRESS + path);
    if (page != null) {
      sb.write('/$page');
    }
    return sb.toString();
  }
  
}
