import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_architecture/presentation/quiz/screen/quiz_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Quiz",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          bottomSheetTheme:
          const    BottomSheetThemeData(modalBackgroundColor: Colors.transparent)),
      home: const QuizScreen(),
    );
  }
}
