import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/entities/question.dart';
import '../../../domain/usecase/quiz_usecase.dart';
import 'quiz_state.dart';

final quizViewModelProvider =
    StateNotifierProvider.autoDispose<QuizViewModel, QuizState>(
  (ref) => QuizViewModel(
    ref.read(quizUseCaseProvider),
  ),
);
final questionProvider = FutureProvider.autoDispose<List<Question>>(
  (ref) => ref.read(quizViewModelProvider.notifier).getQuestion(),
);

class QuizViewModel extends StateNotifier<QuizState> {
  final QuizUseCase _useCase;

  QuizViewModel(this._useCase) : super(QuizState.initial());

  Future<List<Question>> getQuestion() {
    return _useCase.getQuestions();
  }

  void submitQUestion(Question currentQuestion, String answer) {
    if (state.answered) return;
    if (currentQuestion.correctAnswer == answer) {
      state = state.copyWith(
        selectedAnswer: answer,
        status: QuizStatus.correct,
        correct: state.nbCorrect! + 1,
      );
    } else {
      state = state.copyWith(
        selectedAnswer: answer,
        status: QuizStatus.incorrect,
      );
    }
  }

  void nextQuestion(List<Question> questions, int currentIndex) {
    state = state.copyWith(
      selectedAnswer: '',
      status: currentIndex + 1 < questions.length
          ? QuizStatus.initial
          : QuizStatus.complete,
    );
  }

  void reset() {
    state = QuizState.initial();
  }
}
