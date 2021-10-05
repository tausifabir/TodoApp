class TaskModel {
  String title;
  bool complete;

  TaskModel({
    required this.title,
    this.complete = false,
  });

  String get getTitle => title;
  bool get getComplete => complete;

  TaskModel.fromMap(Map map)
      : this.title = map['title'],
        this.complete = map['complete'];

  Map toMap() {
    return {
      'title': this.title,
      'complete': this.complete,
    };
  }
}
