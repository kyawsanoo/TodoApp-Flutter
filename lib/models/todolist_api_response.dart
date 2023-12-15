/*
    {
  "todos": [
    {
      "id": 1,
      "todo": "Do something nice for someone I care about",
      "completed": true,
      "userId": 26
    },
    {...},
    {...}
    // 30 items
  ],
  "total": 150,
  "skip": 0,
  "limit": 30
}

 */
import 'data.dart';

class TodoListApiResponse {
  List<Data>? data;


  TodoListApiResponse({this.data});


  TodoListApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['todos'] != null) {
      data = <Data>[];
      json['todos'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (data != null) {
      json['todos'] = data!.map((v) => v.toJson()).toList();
    }
    return json;
  }
}