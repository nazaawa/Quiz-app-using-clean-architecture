import 'package:equatable/equatable.dart';

import '../../../domain/entities/question.dart';

class QuestionResponse extends Equatable {
  final String category;
  final String difficulty;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  const QuestionResponse(
      {required this.category,
      required this.difficulty,
      required this.correctAnswer,
      required this.incorrectAnswers});

  @override
  List<Object> get props =>
      [category, difficulty, correctAnswer, incorrectAnswers];

  Question toEntity() {
    return Question(
        category: category,
        difficulty: difficulty,
        correctAnswer: correctAnswer,
        answers: incorrectAnswers
          ..add(correctAnswer)
          ..shuffle());
  }

  factory QuestionResponse.fromMap(Map<String, dynamic> map) {
    return QuestionResponse(
      category: map['category'] ?? '',
      difficulty: map['difficulty'] ?? '',
      correctAnswer: map['correctAnswer'] ?? '',
      incorrectAnswers: List<String>.from(map['incorrectAnswers'] ?? [] ),
    );
  }
}
