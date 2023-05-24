abstract class TablableEntity<T> {
  T entity;
  TablableEntity(this.entity);
  dynamic get id;
  bool get selected;
  set selected(bool isSelected);
  Map<String, dynamic> toJson();
}

abstract class TableDataSource<T> {
  String title;
  List<TablableEntity<T>> dataList;
  TableDataSource({required this.title, required this.dataList});
  Map<String, Type> get columns;
}
