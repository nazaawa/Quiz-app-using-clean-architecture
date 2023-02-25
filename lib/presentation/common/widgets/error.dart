import 'package:flutter/material.dart';
import 'package:riverpod_architecture/presentation/common/widgets/custom_button.dart';

class ErrorWidgets extends StatelessWidget {
  final String message;
  final VoidCallback callback;
  const ErrorWidgets({Key? key, required this.message, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 20.0),
        CustomButton(title: "Retry", onTap: () => callback)
      ],
    ));
  }
}
