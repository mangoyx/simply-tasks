class Task {
  String title;
  bool isDone = false;
  final int id;

  Task(this.title) : id = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
      'id': id,
    };
  }

  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        isDone = json['isDone'],
        id = json['id'];
}