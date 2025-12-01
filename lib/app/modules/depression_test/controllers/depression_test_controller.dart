import 'package:get/get.dart';
import '../models/depression_test_model.dart';

class DepressionTestController extends GetxController {
  // Store answers for each question (questionId -> answerIndex)
  final RxMap<int, int> answers = <int, int>{}.obs;
  
  // Total score
  final RxInt totalScore = 0.obs;
  
  // Current level
  final RxString level = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
  }

  /// Select answer for a question
  void selectAnswer(int questionId, int answerIndex) {
    answers[questionId] = answerIndex;
  }

  /// Check if all questions are answered
  bool areAllQuestionsAnswered() {
    // Question 1 is just intro, so we need answers for questions 2-10
    return answers.length >= 9;
  }

  /// Calculate total score
  void calculateScore() {
    int score = 0;
    
    // Calculate score from questions 2-10 (question 1 is intro)
    for (int i = 2; i <= 10; i++) {
      if (answers.containsKey(i)) {
        final answerIndex = answers[i]!;
        score += DepressionTestData.answers[answerIndex].score;
      }
    }
    
    totalScore.value = score;
    level.value = DepressionTestData.getLevel(score);
  }

  /// Reset test
  void resetTest() {
    answers.clear();
    totalScore.value = 0;
    level.value = '';
  }

  /// Get color for current level
  String getColorHex() {
    return DepressionTestData.getColorHex(totalScore.value);
  }

  /// Get description for current score
  String getDescription() {
    return DepressionTestData.getDescription(totalScore.value);
  }
}
