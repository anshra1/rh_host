import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:rh_host/src/core/learning/domain/comment.dart';
import 'package:rh_host/src/core/learning/domain/solution.dart';
import 'package:rh_host/src/core/learning/keys/error_solution_keys.dart';

enum ErrorCategory {
  stateManagement,
  navigation,
  networking,
  layout,
  lifecycle,
  resources,
  other
}

class ErrorSolution extends Equatable {
  const ErrorSolution({
    required this.id,
    required this.errorKey,
    required this.errorType,
    required this.errorMessage,
    required this.projectVersion,
    required this.author,
    required this.filePath,
    required this.lineNumber,
    required this.dateAdded,
    required this.category,
    this.solutions = const [],
    this.tags = const [],
    this.comments = const [],
  });

  factory ErrorSolution.fromJson(Map<String, dynamic> json) => ErrorSolution(
        id: json[ErrorSolutionKeys.id] as String? ?? '',
        errorKey: json[ErrorSolutionKeys.errorKey] as String? ?? '',
        errorType: json[ErrorSolutionKeys.errorType] as String? ?? '',
        errorMessage: json[ErrorSolutionKeys.errorMessage] as String? ?? '',
        category: ErrorCategory.values.firstWhere(
          (e) => e.name == json[ErrorSolutionKeys.category],
          orElse: () => ErrorCategory.other,
        ),
        tags: (json[ErrorSolutionKeys.tags] as List<dynamic>).cast<String>(),
        author: json[ErrorSolutionKeys.author] as String? ?? '',
        filePath: json[ErrorSolutionKeys.filePath] as String? ?? '',
        lineNumber: json[ErrorSolutionKeys.lineNumber] as int? ?? 0,
        dateAdded: DateTime.parse(
          json[ErrorSolutionKeys.dateAdded] as String? ??
              DateTime.now().toIso8601String(),
        ),
        solutions: ((json[ErrorSolutionKeys.solutions] as List<dynamic>?) ?? [])
            .map((s) => Solution.fromJson(s as Map<String, dynamic>))
            .toList(),
        comments: ((json[ErrorSolutionKeys.comments] as List<dynamic>?) ?? [])
            .map((c) => Comment.fromJson(c as Map<String, dynamic>))
            .toList(),
        projectVersion: json[ErrorSolutionKeys.projectVersion] as String? ?? '',
      );

  factory ErrorSolution.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    // ignore: avoid_unused_constructor_parameters
    StackTrace stackTrace,
  ) {
    final data = snapshot.data()!;
    return ErrorSolution.fromJson({
      ErrorSolutionKeys.id: snapshot.id,
      ...data,
    });
  }

  final String id;
  final String errorKey;
  final String errorType;
  final String errorMessage;
  final ErrorCategory category;
  final List<String> tags;
  final String author;
  final String filePath;
  final int lineNumber;
  final DateTime dateAdded;
  final List<Solution> solutions;
  final List<Comment> comments;
  final String projectVersion;

  Map<String, dynamic> toJson() => {
        ErrorSolutionKeys.id: id,
        ErrorSolutionKeys.errorKey: errorKey,
        ErrorSolutionKeys.errorType: errorType,
        ErrorSolutionKeys.errorMessage: errorMessage,
        ErrorSolutionKeys.category: category.name,
        ErrorSolutionKeys.tags: tags,
        ErrorSolutionKeys.author: author,
        ErrorSolutionKeys.filePath: filePath,
        ErrorSolutionKeys.lineNumber: lineNumber,
        ErrorSolutionKeys.dateAdded: dateAdded.toIso8601String(),
        ErrorSolutionKeys.solutions: solutions.map((s) => s.toJson()).toList(),
        ErrorSolutionKeys.comments: comments.map((c) => c.toJson()).toList(),
        ErrorSolutionKeys.projectVersion: projectVersion,
      };

  ErrorSolution copyWith({
    String? errorKey,
    String? errorType,
    String? errorMessage,
    ErrorCategory? category,
    List<String>? tags,
    List<Solution>? solutions,
    List<Comment>? comments,
  }) {
    return ErrorSolution(
      id: id,
      errorKey: errorKey ?? this.errorKey,
      errorType: errorType ?? this.errorType,
      errorMessage: errorMessage ?? this.errorMessage,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      author: author,
      filePath: filePath,
      lineNumber: lineNumber,
      dateAdded: dateAdded,
      solutions: solutions ?? this.solutions,
      comments: comments ?? this.comments,
      projectVersion: projectVersion,
    );
  }

  @override
  List<Object?> get props => [id, errorKey, errorType, errorMessage];
}
