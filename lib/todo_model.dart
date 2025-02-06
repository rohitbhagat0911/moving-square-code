// {
//     "userId": 1,
//     "id": 1,
//     "title": "delectus aut autem",
//     "completed": false
//   },

class TodoModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  TodoModel({this.userId, this.id, this.title, this.completed});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      userId: json['userId'],
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      completed: json['completed'] ?? false,
    );
  }
}

class CountriesModel {
  String? code;
  String? name;
  String? emoji;
  String? currency;

  CountriesModel({this.code, this.name, this.emoji, this.currency});

  factory CountriesModel.fromJson(Map<String, dynamic> json) {
    return CountriesModel(
        code: json['code'] ?? '',
        name: json['name'] ?? '',
        emoji: json['emoji'] ?? '',
        currency: json['currency'] ?? '');
  }
}
