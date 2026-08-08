import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SubjectResult {
  const SubjectResult({
    required this.subject,
    required this.correct,
    required this.incorrect,
    required this.blank,
  });

  final String subject;
  final int correct;
  final int incorrect;
  final int blank;

  Map<String, Object> toJson() => {
    'subject': subject,
    'correct': correct,
    'incorrect': incorrect,
    'blank': blank,
  };
}

class StudyRecommendation {
  const StudyRecommendation({
    required this.subject,
    required this.net,
    required this.priority,
    required this.weeklyMinutes,
    required this.message,
  });

  final String subject;
  final double net;
  final int priority;
  final int weeklyMinutes;
  final String message;

  factory StudyRecommendation.fromJson(Map<String, dynamic> json) {
    return StudyRecommendation(
      subject: json['subject'] as String,
      net: (json['net'] as num).toDouble(),
      priority: json['priority'] as int,
      weeklyMinutes: json['weekly_minutes'] as int,
      message: json['message'] as String,
    );
  }
}

class StudyPlanApi {
  StudyPlanApi({http.Client? client, String? baseUrl})
    : _client = client ?? http.Client(),
      _baseUrl = baseUrl ?? _defaultBaseUrl;

  final http.Client _client;
  final String _baseUrl;

  static String get _defaultBaseUrl {
    const configured = String.fromEnvironment('API_BASE_URL');
    if (configured.isNotEmpty) return configured;
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8000';
    }
    return 'http://localhost:8000';
  }

  Future<List<StudyRecommendation>> createPlan({
    required String studentId,
    required List<SubjectResult> results,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/v1/study-plan'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'student_id': studentId,
        'results': results.map((item) => item.toJson()).toList(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('API ${response.statusCode}: ${response.body}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final recommendations = data['recommendations'] as List<dynamic>;
    return recommendations
        .map((item) => StudyRecommendation.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
