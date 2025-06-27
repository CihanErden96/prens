// lib/services/question_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prens/models/question.dart';
import 'package:prens/constants/global_variables.dart';

class QuestionService {
  final String _baseUrl =
      'https://firstappcihannode.azurewebsites.net'; // Your backend base URL

  Future<Map<String, String>> _getHeaders() async {
    final token = await authService.getToken();
    if (token == null) {
      throw Exception('Authentication token not available.');
    }
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<List<Question>> fetchQuestions() async {
    try {
      final headers = await _getHeaders();
      final url = Uri.parse('$_baseUrl/question');
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return responseData.map((json) => Question.fromJson(json)).toList();
      } else {
        print('Failed to load questions: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      print('Error fetching questions: $e');
      throw e; // Re-throw the exception for handling in the UI
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
        // Assuming the POST response returns the newly created question with ID
        // Adjust parsing if the response structure is different
        // The swagger shows a message and soru_id, we might need to fetch again or assume structure
        // For simplicity, let's assume the response body can be used to construct a Question object
        // If not, a refetch after adding would be necessary in the UI component.
        // Based on swagger, the response is {"message": "Question added successfully", "soru_id": 123}
        // We need the full question object to add to the list, so refetching is safer or the API should return the full object on POST.
        // Let's adjust to reflect swagger - the UI will need to refetch.
        if (responseData['soru_id'] != null && questionText.isNotEmpty) {
          // This isn't ideal as we don't have the full Question object, just ID.
          // A refetch is necessary or the API should return the created Question.
          // Let's proceed assuming the UI handles the list update, perhaps by refetching.
          print(
            'Question added successfully with ID: ${responseData['soru_id']}',
          );
          // Returning a placeholder or the ID might be useful, but the UI needs the full object for the list.
          // Let's adjust the UI logic to refetch after adding.
          // This method will simply indicate success/failure.
          return Future.value(
            Question(soruId: responseData['soru_id'], soruMetni: questionText),
          ); // Return a partial object or adjust based on actual API return
        } else {
          throw Exception('Failed to parse added question response');
        }
      } else {
        print('Failed to add question: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to add question');
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
        print('Question deleted successfully');
      } else if (response.statusCode == 404) {
        print('Question with ID $questionId not found.');
        throw Exception('Question not found');
      } else {
        print('Failed to delete question: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to delete question');
      }
    } catch (e) {
      print('Error deleting question: $e');
      throw e;
    }
  }
}
