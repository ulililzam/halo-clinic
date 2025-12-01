import 'package:get/get.dart';
import '../models/stress_test_model.dart';

class StressTestController extends GetxController {
  // Current page (1-4)
  final RxInt currentPage = 1.obs;
  
  // Profile data (Page 1)
  final profile = StressTestProfile().obs;
  
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

  /// Set gender
  void setGender(String gender) {
    profile.update((val) {
      val?.gender = gender;
    });
  }

  /// Set age range
  void setAgeRange(String? ageRange) {
    profile.update((val) {
      val?.ageRange = ageRange;
    });
  }

  /// Toggle health condition
  void toggleHealthCondition(String condition) {
    profile.update((val) {
      if (val!.healthConditions.contains(condition)) {
        val.healthConditions = List.from(val.healthConditions)..remove(condition);
      } else {
        val.healthConditions = List.from(val.healthConditions)..add(condition);
      }
    });
  }

  /// Check if page 1 is complete
  bool isPage1Complete() {
    return profile.value.gender != null && profile.value.ageRange != null;
  }

  /// Select answer for a question
  void selectAnswer(int questionId, int answerIndex) {
    answers[questionId] = answerIndex;
  }

  /// Check if current page questions are answered
  bool areCurrentPageQuestionsAnswered() {
    if (currentPage.value == 2) {
      return StressTestData.page2Questions.every((q) => answers.containsKey(q.id));
    } else if (currentPage.value == 3) {
      return StressTestData.page3Questions.every((q) => answers.containsKey(q.id));
    } else if (currentPage.value == 4) {
      return StressTestData.page4Questions.every((q) => answers.containsKey(q.id));
    }
    return false;
  }

  /// Check if all questions are answered
  bool areAllQuestionsAnswered() {
    return answers.length >= 10;
  }

  /// Go to next page
  void nextPage() {
    if (currentPage.value < 4) {
      currentPage.value++;
    }
  }

  /// Go to previous page
  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

  /// Calculate total score
  void calculateScore() {
    int score = 0;
    
    // Calculate score from all questions (1-10)
    for (int i = 1; i <= 10; i++) {
      if (answers.containsKey(i)) {
        final answerIndex = answers[i]!;
        score += StressTestData.answers[answerIndex].score;
      }
    }
    
    totalScore.value = score;
    level.value = StressTestData.getLevel(score);
  }

  /// Reset test
  void resetTest() {
    currentPage.value = 1;
    profile.value = StressTestProfile();
    answers.clear();
    totalScore.value = 0;
    level.value = '';
  }

  /// Get color for current level
  String getColorHex() {
    return StressTestData.getColorHex(totalScore.value);
  }

  /// Get description for current score
  String getDescription() {
    return StressTestData.getDescription(totalScore.value);
  }
}
