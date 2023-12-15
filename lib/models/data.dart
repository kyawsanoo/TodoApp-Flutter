/*
{"id":1,"todo":"Do something nice for someone I care about","completed":true,"userId":26} */
class Data {
  int? todoId;
  String? todoName;
  bool? isComplete;

  static Data empty(){
    return Data();
  }

  Data({this.todoId, this.todoName, this.isComplete});

  Data.fromJson(Map<String, dynamic> json) {
    todoId = json['id'];
    todoName = json['todo'];
    isComplete = json['completed'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = todoId;
    data['todo'] = todoName;
    data['completed'] = isComplete;
    return data;
  }
}