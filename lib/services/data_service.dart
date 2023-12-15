import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/models/createtodo_api_response.dart';
import 'package:todoapp/models/delete_todo_response.dart';
import 'package:todoapp/models/updatetodo_api_response.dart';

import '../models/todolist_api_response.dart';

class Services {
  final String baseUrl = "https://dummyjson.com";

  Future<TodoListApiResponse> getTodoListApiResponse(context) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/todos'),
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (kDebugMode) {
          print('TodoList Response $responseBody');
        }
        TodoListApiResponse apiResponse = TodoListApiResponse.fromJson(
            responseBody);
        return apiResponse;
      } else {
        if (kDebugMode) {
          print('Error Occurred');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error Occurred $e');
      }
    }
    return TodoListApiResponse();
  }

  Future<CreateTodoApiResponse> createTodoApiRequest(String todoName) async {
    if (kDebugMode) {
      print('CreateTodo Api Call Starting $todoName');
    }
    try {
      var response = await http.post(
          Uri.parse('$baseUrl/todos/add'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "todo": todoName,
            "completed":false,
            "userId":5
          })
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (kDebugMode) {
          print('CreateTodo Api Response $responseBody');
        }
        CreateTodoApiResponse apiResponse = CreateTodoApiResponse.fromJson(
            responseBody);
        return apiResponse;
      } else {
        if (kDebugMode) {
          print('Create todo api call Error Occurred');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Create to do api call Error Occurred $e');
      }
    }
    return CreateTodoApiResponse();
  }


  Future<DeleteTodoApiResponse> deleteTodo(todoId) async {
    if (kDebugMode) {
      print('Delete Todo Api Call Starting $todoId');
    }
    try {
      var response = await http.delete(
        Uri.parse('$baseUrl/todos/$todoId'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (kDebugMode) {
          print('Delete Todo Api Response $responseBody');
        }
        DeleteTodoApiResponse apiResponse = DeleteTodoApiResponse.fromJson(
            responseBody);
        return apiResponse;
      } else {
        if (kDebugMode) {
          print('Delete todo api call Error Occurred');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Delete Api call Error Occurred $e');
      }
    }
    return DeleteTodoApiResponse();
  }

  Future<UpdateTodoApiResponse> updateTodoData( todoId,
      isComplete) async {
    try {
      final response = await http.put(
          Uri.parse('$baseUrl/todos/$todoId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'completed': isComplete,

          }));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (kDebugMode) {
          print('Update Todo Api Response $responseBody');
        }
        UpdateTodoApiResponse apiResponse = UpdateTodoApiResponse.fromJson(
            responseBody);
        return apiResponse;
      } else {
        if (kDebugMode) {
          print('Update todo api call Error Occurred');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Update Api call Error Occurred $e');
      }
    }
    return UpdateTodoApiResponse();
  }
}