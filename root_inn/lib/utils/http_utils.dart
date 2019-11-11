
//模拟网络请求数据
class HttpUtils {

  Future<String> getRecItem() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return null;
    });
  }

  Future<List<String>> getRecList() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return new List();
    });
  }
}
