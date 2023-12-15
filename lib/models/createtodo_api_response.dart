/*
    {
  "id": 151,
  "todo": "Use DummyJSON in the project",
  "completed": false,
  "userId": 5
}
 */
import 'data.dart';

class CreateTodoApiResponse {
  int? todoId;
  String? todoName;
  bool? isComplete;

  static CreateTodoApiResponse empty(){
    return CreateTodoApiResponse();
  }

  static bool isNotEmpty(CreateTodoApiResponse createTodoApiResponse){
    return createTodoApiResponse.todoName!.isNotEmpty;
  }

  CreateTodoApiResponse({this.todoId, this.todoName, this.isComplete});

  CreateTodoApiResponse.fromJson(Map<String, dynamic> json) {
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