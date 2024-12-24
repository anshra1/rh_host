import 'package:rh_host/src/core/learning/keys/comment_keys.dart';

class Comment {
  const Comment({
    required this.id,
    required this.author,
    required this.text,
    required this.dateAdded,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json[CommentKeys.id] as String? ?? '',
        author: json[CommentKeys.author] as String? ?? '',
        text: json[CommentKeys.text] as String? ?? '',
        dateAdded: DateTime.tryParse(json[CommentKeys.dateAdded] as String? ?? '') ?? DateTime.now(),
      );

  final String id;
  final String author;
  final String text;
  final DateTime dateAdded;

  Map<String, dynamic> toJson() => {
        CommentKeys.id: id,
        CommentKeys.author: author,
        CommentKeys.text: text,
        CommentKeys.dateAdded: dateAdded.toIso8601String(),
      };
}