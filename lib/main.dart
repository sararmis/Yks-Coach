import 'package:flutter/material.dart';

void main() {
  runApp(const YksCoachApp());
}

class YksCoachApp extends StatelessWidget {
  const YksCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YKS Coach',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0E27),
        primaryColor: const Color(0xFFB92BFF),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFB92BFF),
          secondary: Color(0xFFFF2A7A),
          surface: Color(0xFF151A3C),
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0E27),
          elevation: 0,
          centerTitle: true,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF0A0E27),
          selectedItemColor: Color(0xFFB92BFF),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: const MainNavigator(),
    );
  }
}

// ---------------------------------------------------------
// ANA NAVİGASYON (Alt Bar)
// ---------------------------------------------------------
class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const HeatmapScreen(),
    const ExamPlaceholderScreen(),
    const PomodoroScreen(),
    const BadgesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white.withAlpha(25), width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.hexagon_outlined), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40, color: Color(0xFFB92BFF)), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.timer_outlined), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.military_tech), label: ''),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 1. EKRAN: ANA SAYFA (Dashboard)
// ---------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Merhaba, Talha! 👋", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            Text("Bugün harika bir gün!", style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.white.withAlpha(25),
              child: const Icon(Icons.notifications_none, color: Colors.white),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _buildInfoCard("Günlük Seri", "12", "gün", Icons.local_fire_department, Colors.orange)),
                const SizedBox(width: 16),
                Expanded(child: _buildInfoCard("Seviye", "7", "1.250 XP", Icons.star, Colors.blue)),
              ],
            ),
            const SizedBox(height: 24),
            const Text("Günlük Görevlerin", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            _buildTaskItem("20 soru çöz", "20/20", true),
            _buildTaskItem("1 konu tekrarı yap", "1/1", true),
            _buildTaskItem("Pomodoro ile 2 oturum yap", "1/2", false),
            
            const SizedBox(height: 24),
            const Text("Diğer Ekranlara Git", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _navButton(context, "Çalışma Programı", const StudyPlanScreen()),
                _navButton(context, "Analiz", const AnalysisScreen()),
                _navButton(context, "Yanlış Soru Havuzu", const WrongQuestionsScreen()),
                _navButton(context, "Sınıf Durumu", const ClassOverviewScreen()),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String val1, String val2, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151A3C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(75)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 4),
              Text(val1, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text(val2, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          Icon(icon, color: color, size: 36),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String title, String progress, bool isCompleted) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF151A3C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(isCompleted ? Icons.check_circle : Icons.radio_button_unchecked, color: isCompleted ? Colors.greenAccent : Colors.grey),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14))),
          Text(progress, style: TextStyle(color: isCompleted ? Colors.greenAccent : Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _navButton(BuildContext context, String title, Widget screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF151A3C), foregroundColor: Colors.white),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
      child: Text(title),
    );
  }
}

// ---------------------------------------------------------
// 2. EKRAN: KONU BİLGİ HARİTASI (Heatmap)
// ---------------------------------------------------------
class HeatmapScreen extends StatelessWidget {
  const HeatmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Konu Bilgi Haritası")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.hexagon, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text("Petek Harita Alanı", style: TextStyle(color: Colors.white, fontSize: 20)),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Buradaki altıgen tasarımı çizmek için ileride 'flutter_polygon' veya CustomPaint kullanılacak.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _legendItem(Colors.green, "İyi"),
                const SizedBox(width: 16),
                _legendItem(Colors.orange, "Orta"),
                const SizedBox(width: 16),
                _legendItem(Colors.red, "Zayıf"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

// ---------------------------------------------------------
// 3. EKRAN: ÇALIŞMA PROGRAMI
// ---------------------------------------------------------
class StudyPlanScreen extends StatelessWidget {
  const StudyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Çalışma Programı")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDayPlan("Pzt", "Fonksiyonlar", "Konu Tekrarı", Colors.blue),
          _buildDayPlan("Sal", "Problemler", "Konu Tekrarı", Colors.green),
          _buildDayPlan("Çar", "Türev", "Konu Tekrarı", Colors.green),
          _buildDayPlan("Per", "İntegral", "Soru Çözümü", Colors.orange),
        ],
      ),
    );
  }

  Widget _buildDayPlan(String day, String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: const Color(0xFF151A3C), borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withAlpha(50), child: Text(day, style: TextStyle(color: color, fontWeight: FontWeight.bold))),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      ),
    );
  }
}

// ---------------------------------------------------------
// 7. EKRAN: YANLIŞ SORU HAVUZU
// ---------------------------------------------------------
class WrongQuestionsScreen extends StatelessWidget {
  const WrongQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yanlış Soru Havuzu")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSubjectProgress("Fonksiyonlar", "12 soru", 0.4, Colors.redAccent),
          _buildSubjectProgress("Problemler", "18 soru", 0.6, Colors.orangeAccent),
          _buildSubjectProgress("Türev", "9 soru", 0.3, Colors.redAccent),
          _buildSubjectProgress("İntegral", "7 soru", 0.25, Colors.redAccent),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB92BFF), padding: const EdgeInsets.symmetric(vertical: 16)),
          onPressed: () {},
          child: const Text("Yanlışlardan Deneme Oluştur", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildSubjectProgress(String title, String subtitle, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              Text("%${(progress * 100).toInt()}", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress, backgroundColor: Colors.white.withAlpha(25), color: color, minHeight: 6),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 8. EKRAN: POMODORO
// ---------------------------------------------------------
class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pomodoro")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250, height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.greenAccent.withAlpha(125), width: 8),
                boxShadow: [BoxShadow(color: Colors.greenAccent.withAlpha(50), blurRadius: 30, spreadRadius: 10)],
              ),
              child: const Center(child: Text("25:00", style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.white))),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent.shade400,
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text("Başlat", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 9. EKRAN: ROZETLER
// ---------------------------------------------------------
class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rozetler")),
      body: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildBadge(Icons.local_fire_department, "7 Gün Serisi", Colors.orange),
          _buildBadge(Icons.calendar_month, "30 Gün", Colors.orangeAccent),
          _buildBadge(Icons.lock, "100 Gün", Colors.grey),
          _buildBadge(Icons.star, "Türev Ustası", Colors.blue),
          _buildBadge(Icons.menu_book, "Paragraf", Colors.purple),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label, Color color) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF151A3C),
              shape: BoxShape.circle,
              border: Border.all(color: color.withAlpha(125), width: 2),
            ),
            child: Center(child: Icon(icon, color: color, size: 40)),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center),
      ],
    );
  }
}

// ---------------------------------------------------------
// YER TUTUCU EKRANLAR (Sınav, Analiz, Sınıf)
// ---------------------------------------------------------
class ExamPlaceholderScreen extends StatelessWidget {
  const ExamPlaceholderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Deneme Modülü")), body: const Center(child: Text("Sınav ve Zamanlayıcı Ekranları Buraya Gelecek", style: TextStyle(color: Colors.white))));
  }
}

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Analiz")), body: const Center(child: Text("Grafikler (fl_chart kütüphanesi ile) buraya çizilecek.", style: TextStyle(color: Colors.white))));
  }
}

class ClassOverviewScreen extends StatelessWidget {
  const ClassOverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("12-A Sınıfı")), body: const Center(child: Text("Öğrenci Sınıf İstatistikleri Buraya Gelecek", style: TextStyle(color: Colors.white))));
  }
}