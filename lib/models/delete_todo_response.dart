/*
   {id: 1, todo: Do something nice for someone I care about, completed: true, userId: 26, isDeleted: true, deletedOn: 2023
-12-15T02:25:29.841Z}
 */
import 'package:flutter/foundation.dart';

import 'data.dart';


class DeleteTodoApiResponse {
  int? todoId;
  String? todoName;
  bool? isComplete;
  bool? isDeleted;

  static DeleteTodoApiResponse empty(){
    return DeleteTodoApiResponse();
  }

  static bool isNotEmpty(DeleteTodoApiResponse deleteTodoApiResponse){
    if (kDebugMode) {
      print('Delete Todo Response: ${deleteTodoApiResponse.toJson()}');
    }
    return deleteTodoApiResponse.isDeleted==true;
  }

  DeleteTodoApiResponse({this.todoId, this.todoName, this.isComplete, this.isDeleted});

  DeleteTodoApiResponse.fromJson(Map<String, dynamic> json) {
    todoId = json['id'];
    todoName = json['todo'];
    isComplete = json['completed'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = todoId;
    data['todo'] = todoName;
    data['completed'] = isComplete;
    data['isDeleted'] = isDeleted;
    return data;
  }
}