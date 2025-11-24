import 'package:hive/hive.dart';

part 'post_model.g.dart';

@HiveType(typeId: 0)
class PostModel extends HiveObject {
  @HiveField(0)
  final int userId;

  @HiveField(1)
  final int id;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String body;

  PostModel({required this.userId, required this.id, required this.title, required this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(userId: json['userId'], id: json['id'], title: json['title'], body: json['body']);
  }
}