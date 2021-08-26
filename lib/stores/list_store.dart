import 'package:mobx/mobx.dart';
part 'list_store.g.dart';

class ListStore = _ListStoreBase with _$ListStore;

abstract class _ListStoreBase with Store {
  @observable
  String newTodoTitle = "";

  @computed
  bool get isEmpty => newTodoTitle.isEmpty;

  @action
  void setNewTodoTitle(String value) {
    newTodoTitle = value;
  }
}
