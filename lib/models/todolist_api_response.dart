/*
    "data": {
        "_id": "65748e3124a857544617ee86",
        "todoName": "Pay Bills",
        "isComplete": false,
        "createdAt": "2023-12-09T15:56:11.240Z",
        "updatedAt": "2023-12-09T17:19:20.856Z",
        "__v": 0
    }
 */
import 'data.dart';

class TodoListApiResponse {
  int? code;
  List<Data>? data;


  TodoListApiResponse({this.code, this.data});

  TodoListApiResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['code'] = code;
    if (data != null) {
      json['data'] = data!.map((v) => v.toJson()).toList();
    }
    return json;
  }
}