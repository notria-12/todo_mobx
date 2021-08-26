import 'package:mobx/mobx.dart';
import 'package:mobx_example2/stores/todo_store.dart';
part 'list_store.g.dart';

class ListStore = _ListStoreBase with _$ListStore;

abstract class _ListStoreBase with Store {
  @observable
  String newTodoTitle = "";

  @computed
  bool get isEmpty => newTodoTitle.isEmpty;

  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();

  @action
  void addTodo() {
    todoList.add(TodoStore(newTodoTitle));
  }

  @action
  void setNewTodoTitle(String value) {
    newTodoTitle = value;
  }
}
