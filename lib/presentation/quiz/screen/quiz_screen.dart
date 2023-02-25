import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_architecture/domain/entities/question.dart';
import 'package:riverpod_architecture/presentation/quiz/viewmodel/qui_view_model.dart';

import '../../common/widgets/custom_button.dart';
import '../../common/widgets/error.dart';
import '../viewmodel/quiz_state.dart';

class QuizScreen extends HookConsumerWidget {
  const QuizScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final viewModelState = ref.watch(quizViewModelProvider);
    final questionsFuture = ref.watch(questionProvider);
    //  final viewModel =
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF22293E),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: questionsFuture.when(
          data: (questions) =>
              _buildBody(ref, viewModelState, pageController, questions),
          error: (error, s) => ErrorWidgets(
              message: error.toString(), callback: () => refreshAll(ref)),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
        bottomSheet: questionsFuture.maybeWhen(
          data: (questions) {
            if (viewModelState.answered) return const SizedBox.shrink();
            var currentIndex =  pageController.page?.toInt() ?? 0 ;
            return CustomButton(
              title: currentIndex + 1 < questions.length
                  ? "Next Questions"
                  : "See results",
              onTap: () {
                ref.read(quizViewModelProvider.notifier).nextQuestion(questions, currentIndex);
                if (currentIndex + 1 < questions.length){
                  pageController.nextPage(duration: duration, curve: curve)
                }
              },
            );
          },
          orElse: () => const SizedBox.shrink(),
        ),
      ),
    );
  }

  refreshAll(WidgetRef ref) {
    ref.refresh(questionProvider);
    ref.read(quizViewModelProvider.notifier).reset();
  }

  Widget _buildBody(WidgetRef ref, QuizState state,
      PageController pageController, List<Question> questions) {
    if (questions.isEmpty) {
      return ErrorWidgets(
        message: "No questions found",
        callback: () => refreshAll(ref),
      );
    }
    return state.status == QuizStatus.complete
        ? Quizresult(state: state, totalQuestions: questions)
        : QuizQuestion(
            pageController: pageController,
            state = state,
            questions: questions);
  }
}
