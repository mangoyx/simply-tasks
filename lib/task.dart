class Task {
  String title;
  bool isDone = false;

  Task(this.title);
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
    };
}

Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        isDone = json['isDone'];
}