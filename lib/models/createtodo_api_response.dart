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

class CreateTodoApiResponse {
  int? code;
  Data? data;

  CreateTodoApiResponse({this.code, this.data});

  CreateTodoApiResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = Data.fromJson(json);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['code'] = code;
    if (data != null) {
      json['data'] = data?.toJson();
    }
    return json;
  }
}