/*
{"id":1,"todo":"Do something nice for someone I care about","completed":true,"userId":26} */
import 'package:flutter/foundation.dart';

class Data {
  int? todoId;
  String? todoName;
  bool? isComplete;

  static Data empty(){
    return Data();
  }

  static bool isNotEmpty(Data todo){
    if (kDebugMode) {
      print('Delete Todo Response: ${todo.toJson()}');
    }
    return todo.todoId != null;
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