import 'package:flutter/material.dart';
import 'package:todoapp/models/createtodo_api_response.dart';
import 'package:todoapp/models/updatetodo_api_response.dart';

import '../models/data.dart';
import '../models/delete_todo_response.dart';
import '../models/todolist_api_response.dart';
import '../services/data_service.dart';


class DataProvider with ChangeNotifier {
  TodoListApiResponse apiTodoListResponse = TodoListApiResponse(data: List.empty());
  CreateTodoApiResponse createTodoApiResponse = CreateTodoApiResponse(data: Data.empty());
  UpdateTodoApiResponse updateTodoApiResponse = UpdateTodoApiResponse(data: Data.empty());
  DeleteTodoApiResponse deleteTodoApiResponse = DeleteTodoApiResponse(data: Data.empty());

  bool loading = false;
  bool isBack = false;

  Services services = Services();

  fetchTodoList(context) async {
    loading = true;
    apiTodoListResponse = await services.getTodoListApiResponse(context);
    loading = false;
    notifyListeners();
  }

  callCreateTodoApi(context, todoName) async {
    loading = true;
    notifyListeners();
    createTodoApiResponse = await services.createTodoApiRequest( todoName);
    if(createTodoApiResponse.data!=null) {
      loading = false;
      isBack =true;
      notifyListeners();
    }

  }

  callUpdateTodoApi(context, String todoId, bool isComplete) async {
    loading = true;
    notifyListeners();
    updateTodoApiResponse = await services.updateTodoData( todoId, isComplete);
    if(updateTodoApiResponse.code==200) {
      loading = false;
      isBack =true;
      notifyListeners();
    }

  }

  callDeleteTodoApi(context, todoId) async {
    loading = true;
    notifyListeners();
    deleteTodoApiResponse = await services.deleteTodo( todoId);
    if(deleteTodoApiResponse.code== 200 ) {
      loading = false;
      isBack =true;
      notifyListeners();
    }

  }
}
