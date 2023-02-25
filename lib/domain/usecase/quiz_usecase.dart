import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repository/quiz_repository_impl.dart';
import '../entities/question.dart';
import '../repository/quiz_repository.dart';

final quizUseCaseProvider = Provider<QuizUseCase>(
  (ref) => QuizUseCase(
    ref.read(quizRepositoryProvider),
  ),
);

class QuizUseCase {
  final QuizRepository _repository;

  QuizUseCase(this._repository);
  Future<List<Question>> getQuestions() {
    return _repository.getQuestions(
      categoryId: 5,
      numQuestions: Random().nextInt(24) + 9,
    );
  }
}
