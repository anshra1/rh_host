// lib/src/core/error_learning/services/error_solution_service.dart
// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:rh_host/src/core/learning/domain/comment.dart';
import 'package:rh_host/src/core/learning/domain/error_solution.dart';
import 'package:rh_host/src/core/learning/domain/solution.dart';

class ErrorSolutionService {
  ErrorSolutionService._();
  static final ErrorSolutionService instance = ErrorSolutionService._();

  final _firestore = FirebaseFirestore.instance;
  static const _collection = 'error_solutions';

  String _createErrorKey(Object error, StackTrace stack) {
    final errorType = error.runtimeType.toString();
    final errorMessage = error
        .toString()
        .replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .toLowerCase()
        .trim();

    return '$errorType:$errorMessage';
  }

  StackInfo _extractStackInfo(StackTrace stack) {
    final frames = stack.toString().split('\n');
    for (final frame in frames) {
      if (!frame.contains('package:flutter/') &&
          !frame.contains('dart:') &&
          frame.contains(RegExp(r'\((.+?)\)'))) {
        final fileMatch = RegExp(r'\((.+?):[0-9]+:[0-9]+\)').firstMatch(frame);
        final lineMatch = RegExp(r':([0-9]+):[0-9]+\)').firstMatch(frame);

        if (fileMatch != null && lineMatch != null) {
          return StackInfo(
            fileName: fileMatch.group(1) ?? 'unknown',
            lineNumber: int.parse(lineMatch.group(1) ?? '0'),
            fullFrame: frame,
          );
        }
      }
    }
    throw Exception('Could not extract stack info');
  }

  Future<List<ErrorSolution>> getSolutions(Object error, StackTrace stack) async {
    try {
      final errorKey = _createErrorKey(error, stack);
      final snapshot = await _firestore
          .collection(_collection)
          .where('errorKey', isEqualTo: errorKey)
          .orderBy('dateAdded', descending: true)
          .get();

      return snapshot.docs.map((doc) => ErrorSolution.fromFirestore(doc, stack)).toList();
    } catch (e, s) {
      debugPrint('Error fetching solutions: $e\n$s');
      return [];
    }
  }

  Future<void> addSolution({
    required Object error,
    required StackTrace stack,
    required List<Solution> solution,
    String? codeExample,
    ErrorCategory category = ErrorCategory.other,
    List<String> tags = const [],
  }) async {
    try {
      final errorKey = _createErrorKey(error, stack);
      final stackInfo = _extractStackInfo(stack);

      final newSolution = ErrorSolution(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        solutions: solution,
        errorKey: errorKey,
        errorType: error.runtimeType.toString(),
        errorMessage: error.toString(),

        category: category,
        tags: tags,
        author: Platform.environment['USER'] ?? 'unknown',
        filePath: stackInfo.fileName,
        lineNumber: stackInfo.lineNumber,
        dateAdded: DateTime.now(),
        projectVersion: '1.0.0', // Get from your config
      );

      await _firestore.collection(_collection).add(newSolution.toJson());
    } catch (e, s) {
      debugPrint('Error adding solution: $e\n$s');
    }
  }

  Stream<List<ErrorSolution>> watchSolutions(Object error, StackTrace stack) {
    final errorKey = _createErrorKey(error, stack);
    return _firestore
        .collection(_collection)
        .where('errorKey', isEqualTo: errorKey)
        .orderBy('dateAdded', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ErrorSolution.fromFirestore(doc, stack))
              .toList(),
        );
  }

  Future<void> voteSolution(String solutionId, bool isUpvote) async {
    try {
      await _firestore.collection(_collection).doc(solutionId).update({
        isUpvote ? 'upvotes' : 'downvotes': FieldValue.increment(1),
      });
    } catch (e) {
      debugPrint('Error voting on solution: $e');
    }
  }

  Future<void> addComment(String solutionId, String text) async {
    try {
      final comment = Comment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        author: Platform.environment['USER'] ?? 'unknown',
        text: text,
        dateAdded: DateTime.now(),
      );

      await _firestore.collection(_collection).doc(solutionId).update({
        'comments': FieldValue.arrayUnion([comment.toJson()]),
      });
    } catch (e) {
      debugPrint('Error adding comment: $e');
    }
  }

  Future<void> verifySolution(String solutionId) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(solutionId)
          .update({'isVerified': true});
    } catch (e) {
      debugPrint('Error verifying solution: $e');
    }
  }
}

class StackInfo {
  const StackInfo({
    required this.fileName,
    required this.lineNumber,
    required this.fullFrame,
  });
  
  final String fileName;
  final int lineNumber;
  final String fullFrame;
}
