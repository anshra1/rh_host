import 'package:rh_host/src/core/learning/keys/solution.dart';

class Solution {
  const Solution({
    required this.id,
    required this.solution,
    required this.author,
    required this.dateAdded,
    this.upvotes = 0,
    this.downvotes = 0,
    this.isVerified = false,
  });

  factory Solution.fromJson(Map<String, dynamic> json) => Solution(
        id: json[SolutionKeys.id] as String? ?? '',
        solution: json[SolutionKeys.solution] as String? ?? '',
        author: json[SolutionKeys.author] as String? ?? '',
        dateAdded: DateTime.parse(json[SolutionKeys.dateAdded] as String? ?? DateTime.now().toIso8601String()),
        upvotes: json[SolutionKeys.upvotes] as int? ?? 0,
        downvotes: json[SolutionKeys.downvotes] as int? ?? 0,
        isVerified: json[SolutionKeys.isVerified] as bool? ?? false,
      );

  final String id;
  final String solution;
  final String author;
  final DateTime dateAdded;
  final int upvotes;
  final int downvotes;
  final bool isVerified;

  Map<String, dynamic> toJson() => {
        SolutionKeys.id: id,
        SolutionKeys.solution: solution,
        SolutionKeys.author: author,
        SolutionKeys.dateAdded: dateAdded.toIso8601String(),
        SolutionKeys.upvotes: upvotes,
        SolutionKeys.downvotes: downvotes,
        SolutionKeys.isVerified: isVerified,
      };
}