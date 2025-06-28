// lib/services/question_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prens/models/question.dart';
import 'package:prens/constants/global_variables.dart'; // Assuming this contains authService
import 'package:isar/isar.dart'; // Import Isar

class QuestionService {
  final Isar isar; // Add Isar instance
  final String _baseUrl =
      'https://firstappcihannode.azurewebsites.net'; // Your backend base URL

  QuestionService({required this.isar}); // Constructor to receive Isar instance

  Future<Map<String, String>> _getHeaders() async {
    final token = await authService!.getToken(); // Use null-aware operator
    if (token == null) {
      throw Exception('Authentication token not available.');
    }
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // Fetch questions from API and store in Isar
  Future<void> syncQuestionsFromApi() async {
    try {
      final headers = await _getHeaders();
      final url = Uri.parse('$_baseUrl/question');
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<Question> fetchedQuestions = responseData.map((json) => Question.fromJson(json)).toList();

        // Clear existing data in Isar and save the new data
        await isar.writeTxn(() async {
          await isar.questions.clear(); // Clear the collection
          await isar.questions.putAll(fetchedQuestions); // Save new data
        });

        print('Questions synced from API and stored in Isar.');

      } else {
        print('Failed to load questions from API: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load questions from API');
      }
    } catch (e) {
      print('Error syncing questions from API: $e');
      throw e; // Re-throw the exception
    }
  }

  // Get questions directly from Isar
  Future<List<Question>> getQuestionsFromIsar() async {
    try {
      return await isar.questions.where().findAll();
    } catch (e) {
      print('Error getting questions from Isar: $e');
      throw e;
    }
  }

  Future<Question> addQuestion(String questionText) async {
    try {
      final headers = await _getHeaders();
      final url = Uri.parse('$_baseUrl/question');
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({'soru_metni': questionText}),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        if (responseData['soru_id'] != null && questionText.isNotEmpty) {
          final newQuestion = Question(soruId: responseData['soru_id'], soruMetni: questionText);
          // Save the new question to Isar
          await isar.writeTxn(() async {
            await isar.questions.put(newQuestion);
          });
          print('Question added successfully to API and Isar.');
          return newQuestion;
        } else {
          throw Exception('Failed to parse added question response from API');
        }
      } else {
        print('Failed to add question to API: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to add question to API');
      }
    } catch (e) {
      print('Error adding question: $e');
      throw e;
    }
  }

  Future<void> deleteQuestion(int questionId) async {
    try {
      final headers = await _getHeaders();
      final url = Uri.parse('$_baseUrl/question/$questionId');
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        // Delete the question from Isar
        await isar.writeTxn(() async {
          // Find the question by soruId (indexed field)
          final questionToDelete = await isar.questions.where().soruIdEqualTo(questionId).findFirst();
          if (questionToDelete != null) {
            await isar.questions.delete(questionToDelete.id!);
          }
        });
        print('Question deleted successfully from API and Isar.');
      } else if (response.statusCode == 404) {
        print('Question with ID $questionId not found on API.');
        throw Exception('Question not found on API');
      } else {
        print('Failed to delete question from API: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to delete question from API');
      }
    } catch (e) {
      print('Error deleting question: $e');
      throw e;
    }
  }
}
