/*
{
    "code": 200,
    "data": {
        "_id": "65748e3124a857544617ee86",
        "todoName": "Pay Bills",
        "isComplete": false,
        "createdAt": "2023-12-09T15:56:11.240Z",
        "updatedAt": "2023-12-09T17:19:20.856Z",
        "__v": 0
    }
}
 */
class Data {
  String? todoId;
  String? todoName;
  bool? isComplete;
  String? createdAt;
  String? updatedAt;
  int? v;

  static Data empty(){
    return Data();
  }

  Data({this.todoId, this.todoName, this.isComplete,  this.createdAt, this.updatedAt, this.v});

  Data.fromJson(Map<String, dynamic> json) {
    todoId = json['_id'];
    todoName = json['todoName'];
    isComplete = json['isComplete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = todoId;
    data['todoName'] = todoName;
    data['isComplete'] = isComplete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = v;
    return data;
  }
}