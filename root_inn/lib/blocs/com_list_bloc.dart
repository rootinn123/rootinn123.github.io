
import 'dart:collection';

import 'package:flustars/flustars.dart';
import 'package:root_inn/common/commom.dart';
import 'package:root_inn/data/models.dart';
import 'package:root_inn/data/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_provider.dart';

class ComListBloc<T> implements BlocBase {

  ComListBloc({this.comList});

  BehaviorSubject<List<T>> comListData = BehaviorSubject<List<T>>();

  Sink<List<T>> get _comListSink => comListData.sink;

  Stream<List<T>> get comListStream => comListData.stream;

  List<T> comList;


  DumeiRepository _dumeiRepository = DumeiRepository.getInstance();


  @override
  void dispose() {
    comListData?.close();
    // _comListEvent.close();
  }

 @override
  Future getData({String labelId, String cid, Map<String, dynamic> comReq}) {
    switch (labelId) {
      case AppLocalLabel.InitialData:
        return _getInitialData(labelId);  
      case AppLocalLabel.DeskData:
        return _getDeskData(labelId); 
      default:
        return Future.delayed(new Duration(milliseconds: 1));
        break;
    }
  }

  @override
  Future onLoadMore({String labelId, String cid, Map<String, dynamic> comReq}) {
    return null;
  }

  @override
  Future<void> onRefresh({String labelId, String cid, Map<String, dynamic> comReq, int greatThan = 0}) {
    return null;
  }

  Future _getInitialData(String labelId) {

    return this._dumeiRepository.getInitialData(null).then((List<Menu> result){
      LogUtil.v('_getInitialData----->>>>>>handle');
     this.handleResultData(result);
    }).catchError((e){
      LogUtil.v('_getInitialData-----error-->>>>>>$e');
    });

  }

  Future _getDeskData(String labelId) {

    return this._dumeiRepository.getDeskData(null).then((List<Desk> result){
      LogUtil.v('_getDeskData----->>>>>>handle');
     this.handleResultData(result);
    }).catchError((e){
      LogUtil.v('_getDeskData-----error-->>>>>>$e');
    });

  }

  void handleResultData(List<dynamic> result){
    List<T> list = result as List<T>;
    if(null != list && list.length > 0){
      this.comList = this.comList ?? List<T>();
      this.comList.clear();
      this.comList.addAll(List.castFrom(list));
      this._comListSink.add(UnmodifiableListView<T>(this.comList));
    }
  }

}