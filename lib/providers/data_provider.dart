import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/createtodo_api_response.dart';
import 'package:todoapp/models/updatetodo_api_response.dart';

import '../models/data.dart';
import '../models/delete_todo_response.dart';
import '../models/todolist_api_response.dart';
import '../services/data_service.dart';


class DataProvider with ChangeNotifier {
  TodoListApiResponse apiTodoListResponse = TodoListApiResponse(data: List.empty());
  CreateTodoApiResponse createTodoApiResponse = CreateTodoApiResponse.empty();
  UpdateTodoApiResponse updateTodoApiResponse = UpdateTodoApiResponse.empty();
  DeleteTodoApiResponse deleteTodoApiResponse = DeleteTodoApiResponse.empty();

  bool loading = false;
  bool isBack = false;

  Services services = Services();

  fetchTodoList(context) async {
    loading = true;
    isBack = false;
    apiTodoListResponse = await services.getTodoListApiResponse(context);
    loading = false;
    notifyListeners();
  }

  callCreateTodoApi(context, todoName) async {
    loading = true;
    isBack = false;
    notifyListeners();
    createTodoApiResponse = await services.createTodoApiRequest( todoName);
    if (kDebugMode) {
      print('Create Todo Api Response ${createTodoApiResponse.toJson()}');
    }
    if(CreateTodoApiResponse.isNotEmpty(createTodoApiResponse)) {
      loading = false;
      isBack =true;
      notifyListeners();
    }else{
      if (kDebugMode) {
        print('Create Todo Response is empty');
      }
    }

  }

  callUpdateTodoApi(context, todoId, isComplete) async {
    loading = true;
    isBack = false;
    notifyListeners();
    updateTodoApiResponse = await services.updateTodoData( todoId, isComplete);
    if (kDebugMode) {
      print('Update Todo Api Response ${updateTodoApiResponse.toJson()}');
    }
    if(UpdateTodoApiResponse.isNotEmpty(updateTodoApiResponse)) {
      loading = false;
      isBack =true;
      notifyListeners();
    }else{
      if (kDebugMode) {
        print('Update Todo Response is empty');
      }
    }

  }

  callDeleteTodoApi(context, todoId) async {
    if (kDebugMode) {
      print('Delete Todo Id $todoId');
    }
    loading = true;
    isBack = false;
    notifyListeners();
    deleteTodoApiResponse = await services.deleteTodo( todoId);
    if (kDebugMode) {
      print('In Data Provider, Delete Todo Api Response ${deleteTodoApiResponse.toJson()}');
    }

    if(DeleteTodoApiResponse.isNotEmpty(deleteTodoApiResponse)) {
      loading = false;
      isBack =true;
      notifyListeners();
    }else{
      if (kDebugMode) {
        print('Delete Todo Response is empty');
      }
    }

  }
}
