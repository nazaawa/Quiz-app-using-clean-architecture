import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_architecture/domain/entities/question.dart';

import '../../domain/repository/quiz_repository.dart';
import '../api/remote_api.dart';
import '../models/request/question_request.dart';

final quizRepositoryProvider = Provider<QuizRepository>(
    (ref) => QuizRepositoryImpl(ref.read(remoteApiProvider)));

class QuizRepositoryImpl extends QuizRepository {
  QuizRepositoryImpl(this._remoteApi);
  final RemoteApi _remoteApi;
  @override
  Future<List<Question>> getQuestions(
      {required int numQuestions, required int categoryId}) {
    return _remoteApi
        .getQuestion(QuestionRequest(
          type: 'multiple',
          amount: numQuestions,
          category: categoryId,
        ))
        .then(
          (value) => value.map((e) => e.toEntity()).toList(),
        );
  }
}
