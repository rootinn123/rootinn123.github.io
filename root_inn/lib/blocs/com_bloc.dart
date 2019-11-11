
import 'package:root_inn/data/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';

class ComBloc<T> implements BlocBase {

  ComBloc({this.com});

  BehaviorSubject<T> comData = BehaviorSubject<T>();

  Sink<T> get _comSink => comData.sink;

  Stream<T> get comStream => comData.stream;

  T com;

  DumeiRepository dumeiRepository = DumeiRepository.getInstance();

  @override
  void dispose() {
    comData.close();
  }

  @override
  Future getData({String labelId}) {
    return null;
  }

  @override
  Future onLoadMore({String labelId}) {
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
    return null;
  }
  
}