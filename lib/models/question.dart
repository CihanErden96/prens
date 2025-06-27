// lib/models/question.dart
class Question {
  final int soruId;
  final String soruMetni;

  Question({required this.soruId, required this.soruMetni});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(soruId: json['soru_id'], soruMetni: json['soru_metni']);
  }

  Map<String, dynamic> toJson() {
    return {'soru_id': soruId, 'soru_metni': soruMetni};
  }
}
