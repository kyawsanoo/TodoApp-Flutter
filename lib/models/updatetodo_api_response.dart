
import 'data.dart';

/*
{"id":1,"todo":"Do something nice for someone I care about","completed":true,"userId":26} */
class UpdateTodoApiResponse {
  int? todoId;
  String? todoName;
  bool? isComplete;

  static UpdateTodoApiResponse empty(){
    return UpdateTodoApiResponse();
  }

  static bool isNotEmpty(UpdateTodoApiResponse updateTodoApiResponse){
    if(updateTodoApiResponse.todoName!=null) {
      return updateTodoApiResponse.todoName!.isNotEmpty;
    }else{
      return false;
    }
  }

  UpdateTodoApiResponse({this.todoId, this.todoName, this.isComplete});

  UpdateTodoApiResponse.fromJson(Map<String, dynamic> json) {
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