class Todo {
  int? id;
  final String title;
  DateTime creationDate;
  bool isCheched;


  ///////// create constructor
Todo({
    this.id,
  required this.title,
  required this.creationDate,
  required this.isCheched,
});
  // ignore: non_constant_identifier_names
  Map <String ,dynamic> ToMap(){
    return {
      'id':id,
      'title':title,
      'creationDate':creationDate,
      'isChecked':isCheched?0:1,
    };

  }
  @override
  String toString(){
    return 'Todo(id:$id, title:$title, creationDate:$creationDate, isChecked:$isCheched)';
  }
}

