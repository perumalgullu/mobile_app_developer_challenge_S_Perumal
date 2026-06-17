import 'package:flutter/material.dart';
import '../models/quiz_model.dart';

class QuizWidget extends StatelessWidget {
  final QuizModel quiz;
  final Function(String) onAnswer;

  const QuizWidget({
    super.key,
    required this.quiz,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quiz.question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          ...quiz.options.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => onAnswer(option),
                  child: Text(option),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}