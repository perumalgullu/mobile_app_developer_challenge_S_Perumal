import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/story_text.dart';
import '../providers/story_provider.dart';
import '../services/tts_service.dart';
import '../models/quiz_model.dart';
import '../constants/quiz_data.dart';
import '../widgets/quiz_widget.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TTSService _ttsService = TTSService();

  final quiz = QuizModel.fromJson(quizJson);

  final ScrollController _scrollController = ScrollController();

  late ConfettiController _confettiController;

 @override
void initState() {
  super.initState();

  _ttsService.init();

  _confettiController = ConfettiController(
    duration: const Duration(seconds: 3),
  );
}
@override
void dispose() {
  _confettiController.dispose();
  _scrollController.dispose();
  super.dispose();
}

 Future<void> _readStory() async {
  final provider = Provider.of<StoryProvider>(
    context,
    listen: false,
  );

  try {
    provider.setLoading();

    await Future.delayed(
      const Duration(milliseconds: 800),
    );

    provider.setSpeaking();

    _ttsService.onComplete(() {
      provider.showQuiz();

      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        },
      );
    });

    await _ttsService.speak(storyText);
  } catch (e) {
    provider.showError(e.toString());
  }
}

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF6C63FF),
        title: const Text(
          "AI Story Buddy",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF8FAFF),
              Color(0xFFEAF4FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
  child: SingleChildScrollView(
    controller: _scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ConfettiWidget(
  confettiController: _confettiController,
  blastDirectionality: BlastDirectionality.explosive,
  shouldLoop: false,
  emissionFrequency: 0.05,
  numberOfParticles: 20,
  maxBlastForce: 20,
  minBlastForce: 8,
),
                Container(
                  height: 240,
                  width: 240,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset(
  provider.state == StoryState.success
      ? "assets/images/robot_happy.png"
      : provider.state == StoryState.wrong
          ? "assets/images/robot_sad.png"
          : "assets/images/robot_buddy.png",
  fit: BoxFit.contain,
)
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Hi Friend 👋",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Ready for a magical story?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFFE5E7FF),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.auto_stories,
                            color: Color(0xFF6C63FF),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Today's Story",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        storyText,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                if (provider.state == StoryState.loading)
                  const CircularProgressIndicator(),

                if (provider.state == StoryState.speaking)
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "📖 Reading story...",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                if (provider.state == StoryState.error)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      provider.errorMessage ?? "Unknown Error",
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                const SizedBox(height: 15),

                SizedBox(
  width: double.infinity,
  height: 60,
  child:ElevatedButton.icon(
  onPressed: provider.state == StoryState.speaking
    ? null
    : _readStory,
  icon: const Icon(Icons.volume_up),
  label: const Text(
    "Read Me A Story",
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFFB703),
    foregroundColor: Colors.white,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  ),
),
),


const SizedBox(height: 20),

if (provider.state == StoryState.quiz)
  QuizWidget(
    quiz: quiz,
    onAnswer: (selected) {
     if (selected == quiz.answer) {
  HapticFeedback.heavyImpact();

  _confettiController.play();
  provider.showSuccess();
}else {
  provider.showWrong();
  

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        "Oops! Pip needs help finding the blue gear. Try again! 😊",
      ),
    ),
  );

  Future.delayed(
    const Duration(seconds: 2),
    () {
      provider.showQuiz();
    },
  );
}
    },
  ),

if (provider.state == StoryState.success)
  Container(
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.green.shade100,
      borderRadius: BorderRadius.circular(20),
    ),
    child: const Column(
      children: [
        Text(
          "🎉 Correct Answer!",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Great job! Pip found his blue gear.",
        ),
      ],
    ),
  ),

Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: const Color(0xFFEAF4FF),
    borderRadius: BorderRadius.circular(15),
  ),
  child: const Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Listen carefully! A quiz will appear after the story.",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}