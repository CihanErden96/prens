// lib/providers/question_provider.dart
import 'package:riverpod/riverpod.dart';
import 'package:prens/models/question.dart';
import 'package:prens/services/question_service.dart';
import 'package:prens/main.dart'; // Assuming 'isar' is accessible from main.dart

// Define a provider for the QuestionService
// This allows the QuestionNotifier to access the service with the Isar instance
final questionServiceProvider = Provider<QuestionService>((ref) {
  // Access the global Isar instance initialized in main.dart
  // A more robust solution might pass the Isar instance explicitly or use dependency injection
  return QuestionService(isar: isar);
});

// Define the StateNotifier for managing the list of questions
class QuestionNotifier extends StateNotifier<List<Question>> {
  final QuestionService _questionService;

  QuestionNotifier(this._questionService) : super([]); // Initial state is an empty list

  // Load questions from Isar and sync with API
  Future<void> loadQuestions() async {
    try {
      // Load from Isar first for quick display
      state = await _questionService.getQuestionsFromIsar();

      // Then sync with API in the background
      await _questionService.syncQuestionsFromApi();

      // After syncing, fetch from Isar again to get the latest data
      state = await _questionService.getQuestionsFromIsar();

    } catch (e) {
      // Handle errors, e.g., log them or update state to indicate error
      print('Error loading questions: $e');
      // Optionally, update state to show an error message or empty list
      // state = []; // Or some error state
    }
  }

  // Add a new question
  Future<void> addQuestion(String questionText) async {
    try {
      // Add to API and Isar via the service
      final newQuestion = await _questionService.addQuestion(questionText);
      // Add the new question to the current state
      state = [...state, newQuestion];
    } catch (e) {
      print('Error adding question: $e');
      // Handle error, maybe show a snackbar in the UI
    }
  }

  // Delete a question
  Future<void> deleteQuestion(int questionId) async {
    try {
      // Delete from API and Isar via the service
      await _questionService.deleteQuestion(questionId);
      // Remove the deleted question from the current state
      state = state.where((question) => question.soruId != questionId).toList();
    } catch (e) {
      print('Error deleting question: $e');
      // Handle error, maybe show a snackbar in the UI
      // If deletion failed on backend, you might want to refetch or revert UI change
      loadQuestions(); // Refetch to ensure state is consistent with backend/Isar
    }
  }
}

// The provider that exposes the QuestionNotifier
final questionListProvider = StateNotifierProvider<QuestionNotifier, List<Question>>((ref) {
  // Get the QuestionService instance from its provider
  final questionService = ref.watch(questionServiceProvider);
  // Create and return the QuestionNotifier
  return QuestionNotifier(questionService);
});
