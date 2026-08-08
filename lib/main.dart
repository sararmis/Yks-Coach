import 'package:flutter/material.dart';

import 'services/study_plan_api.dart';

void main() {
  runApp(const YksCoachApp());
}

class YksCoachApp extends StatelessWidget {
  const YksCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YKS Coach',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const StudyPlanPage(),
    );
  }
}

class StudyPlanPage extends StatefulWidget {
  const StudyPlanPage({super.key});

  @override
  State<StudyPlanPage> createState() => _StudyPlanPageState();
}

class _StudyPlanPageState extends State<StudyPlanPage> {
  final _api = StudyPlanApi();
  bool _isLoading = false;
  String? _error;
  List<StudyRecommendation> _recommendations = const [];

  Future<void> _createPlan() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final recommendations = await _api.createPlan(
        studentId: 'demo-student',
        results: const [
          SubjectResult(subject: 'Türkçe', correct: 30, incorrect: 4, blank: 6),
          SubjectResult(subject: 'Matematik', correct: 10, incorrect: 8, blank: 22),
          SubjectResult(subject: 'Fen', correct: 12, incorrect: 5, blank: 3),
        ],
      );
      if (mounted) {
        setState(() => _recommendations = recommendations);
      }
    } on Exception catch (error) {
      if (mounted) {
        setState(() => _error = error.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YKS Coach')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text('AI çalışma planı', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          const Text(
            'Örnek deneme sonuçlarını backend üzerinden AI algoritmasına gönder.',
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _isLoading ? null : _createPlan,
            icon: _isLoading
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.auto_awesome),
            label: const Text('Çalışma planı oluştur'),
          ),
          if (_error != null) ...[
            const SizedBox(height: 16),
            Text(
              'Backend bağlantısı kurulamadı: $_error',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: 16),
          for (final item in _recommendations)
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${item.priority}')),
                title: Text('${item.subject} • ${item.net} net'),
                subtitle: Text(item.message),
                trailing: Text('${item.weeklyMinutes} dk'),
              ),
            ),
        ],
      ),
    );
  }
}
