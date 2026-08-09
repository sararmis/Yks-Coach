import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

const _background = Color(0xFF050B18);
const _surface = Color(0xFF101A2E);
const _surfaceLight = Color(0xFF16233B);
const _purple = Color(0xFF7451FF);
const _green = Color(0xFF42D985);
const _yellow = Color(0xFFFFBE45);
const _red = Color(0xFFFF5E61);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YKS Coach',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _background,
        colorScheme: const ColorScheme.dark(primary: _purple, surface: _surface),
        fontFamily: 'Roboto',
      ),
      home: const CoachShell(),
    );
  }
}

class CoachShell extends StatefulWidget {
  const CoachShell({super.key});

  @override
  State<CoachShell> createState() => _CoachShellState();
}

class _CoachShellState extends State<CoachShell> {
  int _selectedIndex = 0;

  final _pages = const [
    HomeScreen(),
    HeatmapScreen(),
    StudyPlanScreen(),
    PomodoroScreen(),
    BadgesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: NavigationBar(
        height: 68,
        backgroundColor: const Color(0xFF081221),
        indicatorColor: _purple.withValues(alpha: .22),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) => setState(() => _selectedIndex = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Ana Sayfa'),
          NavigationDestination(icon: Icon(Icons.hexagon_outlined), selectedIcon: Icon(Icons.hexagon), label: 'Harita'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: 'Program'),
          NavigationDestination(icon: Icon(Icons.timer_outlined), selectedIcon: Icon(Icons.timer), label: 'Pomodoro'),
          NavigationDestination(icon: Icon(Icons.workspace_premium_outlined), selectedIcon: Icon(Icons.workspace_premium), label: 'Rozetler'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      children: [
        Row(
          children: [
            const Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Merhaba, Ahmet! 👋', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
                SizedBox(height: 4),
                Text('Bugün harika bir gün!', style: TextStyle(color: Colors.white60)),
              ]),
            ),
            _roundIcon(Icons.notifications_none_rounded, showDot: true),
          ],
        ),
        const SizedBox(height: 24),
        const Row(children: [
          Expanded(child: _ProgressCard(title: 'Günlük Seri', value: '12', suffix: 'gün', icon: Icons.local_fire_department_rounded, color: Color(0xFFFF7A37))),
          SizedBox(width: 12),
          Expanded(child: _ProgressCard(title: 'Seviye', value: '7', suffix: '1.250 XP', icon: Icons.auto_awesome_rounded, color: _purple)),
        ]),
        const SizedBox(height: 28),
        const _SectionTitle(title: 'Günlük Görevlerin', action: 'Tümünü gör'),
        const SizedBox(height: 12),
        const _TaskTile(title: '20 soru çöz', value: '20/20', progress: 1, icon: Icons.quiz_rounded, done: true),
        const _TaskTile(title: '1 konu tekrarı yap', value: '1/1', progress: 1, icon: Icons.menu_book_rounded, done: true),
        const _TaskTile(title: 'Pomodoro ile 2 oturum yap', value: '1/2', progress: .5, icon: Icons.timer_outlined),
        const _TaskTile(title: '1 deneme bölümünü çöz', value: '0/1', progress: 0, icon: Icons.edit_note_rounded),
        const SizedBox(height: 28),
        const _SectionTitle(title: 'İstatistiklerin', action: 'Bu hafta'),
        const SizedBox(height: 12),
        const Row(children: [
          Expanded(child: _StatCard(label: 'Net', value: '72.5', change: '+4.5', color: _green)),
          SizedBox(width: 10),
          Expanded(child: _StatCard(label: 'Doğru', value: '85%', change: '+6%', color: _green)),
          SizedBox(width: 10),
          Expanded(child: _StatCard(label: 'Yanlış', value: '15', change: '-3', color: _red)),
        ]),
      ],
    );
  }
}

class HeatmapScreen extends StatelessWidget {
  const HeatmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const topics = [
      ('Temel\nKavramlar', _green), ('Sayı\nBasamakları', _green), ('Bölme\nBölünebilme', _green),
      ('OBEB\nOKEK', _green), ('Rasyonel\nSayılar', _green), ('Üslü\nSayılar', _yellow),
      ('Oran\nOrantı', _green), ('Problemler', _yellow), ('Fonksiyonlar', _red),
      ('Denklemler', _red), ('Polinomlar', _red), ('Mantık', _green),
    ];
    return ListView(padding: const EdgeInsets.all(20), children: [
      const _PageHeader(title: 'Konu Bilgi Haritası'),
      const SizedBox(height: 22),
      const _SegmentedLabels(labels: ['TYT', 'AYT']),
      const SizedBox(height: 14),
      const _DropDownLabel(label: 'Matematik'),
      const SizedBox(height: 28),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: topics.map((item) => _TopicHexagon(label: item.$1, color: item.$2)).toList(),
      ),
      const SizedBox(height: 28),
      const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _Legend(color: _green, label: 'İyi'), SizedBox(width: 18), _Legend(color: _yellow, label: 'Orta'), SizedBox(width: 18), _Legend(color: _red, label: 'Zayıf'),
      ]),
    ]);
  }
}

class StudyPlanScreen extends StatelessWidget {
  const StudyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const days = [('Pzt', 'Fonksiyonlar', '20 Soru', _purple), ('Sal', 'Problemler', '20 Soru', _green), ('Çar', 'Türev', '15 Soru', _green), ('Per', 'İntegral', '20 Soru', _yellow), ('Cum', 'Deneme', '1 Bölüm', _purple)];
    return ListView(padding: const EdgeInsets.all(20), children: [
      const _PageHeader(title: 'Çalışma Programı'),
      const SizedBox(height: 20),
      const _SegmentedLabels(labels: ['Günlük', 'Haftalık', 'Aylık'], selected: 1),
      const SizedBox(height: 22),
      const Center(child: Text('12 - 18 Ağustos', style: TextStyle(fontWeight: FontWeight.w700))),
      const SizedBox(height: 18),
      ...days.map((day) => _PlanTile(day: day.$1, title: day.$2, detail: day.$3, color: day.$4)),
      const SizedBox(height: 8),
      FilledButton(onPressed: () {}, style: FilledButton.styleFrom(backgroundColor: _purple, minimumSize: const Size.fromHeight(48)), child: const Text('Programı Düzenle')),
    ]);
  }
}

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const _PageHeader(title: 'Pomodoro'),
        const SizedBox(height: 24),
        const _SegmentedLabels(labels: ['Odaklanma', 'Geçmiş']),
        const Spacer(),
        const Text('Odaklanma Süresi', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 24),
        SizedBox(width: 220, height: 220, child: Stack(alignment: Alignment.center, children: [
          SizedBox(width: 220, height: 220, child: CircularProgressIndicator(value: .72, strokeWidth: 9, color: _green, backgroundColor: _surfaceLight)),
          const Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.eco_rounded, color: _green, size: 28), SizedBox(height: 8), Text('25:00', style: TextStyle(fontSize: 45, fontWeight: FontWeight.w800))]),
        ])),
        const Spacer(),
        FilledButton(onPressed: () {}, style: FilledButton.styleFrom(backgroundColor: _green, foregroundColor: _background, minimumSize: const Size.fromHeight(52)), child: const Text('Başlat', style: TextStyle(fontWeight: FontWeight.w800))),
        const SizedBox(height: 16),
        const Row(children: [Expanded(child: _TimeChip('25 dk', selected: true)), SizedBox(width: 10), Expanded(child: _TimeChip('50 dk')), SizedBox(width: 10), Expanded(child: _TimeChip('75 dk'))]),
      ]),
    );
  }
}

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const badges = [(Icons.local_fire_department_rounded, '7 Gün Serisi', _yellow), (Icons.workspace_premium_rounded, '30 Gün Serisi', Color(0xFFFF8C24)), (Icons.star_rounded, 'Türev Ustası', _purple), (Icons.menu_book_rounded, 'Paragraf Kralı', _yellow), (Icons.military_tech_rounded, 'İlk Deneme', Color(0xFFFF8C24)), (Icons.lock_rounded, 'Net Rekoru', Colors.blueGrey)];
    return ListView(padding: const EdgeInsets.all(20), children: [
      const _PageHeader(title: 'Rozetler'),
      const SizedBox(height: 20),
      const _SegmentedLabels(labels: ['Tümü', 'Kazanılan', 'Kazanılmayan']),
      const SizedBox(height: 28),
      const Text('Süreklilik Rozetleri', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
      const SizedBox(height: 18),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: badges.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 22, crossAxisSpacing: 12, childAspectRatio: .78),
        itemBuilder: (_, index) => _Badge(icon: badges[index].$1, label: badges[index].$2, color: badges[index].$3),
      ),
    ]);
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.title, required this.value, required this.suffix, required this.icon, required this.color});
  final String title, value, suffix; final IconData icon; final Color color;
  @override Widget build(BuildContext context) => _Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.white60, fontSize: 12)), const SizedBox(height: 12), Row(children: [Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)), const Spacer(), Icon(icon, color: color, size: 34)]), Text(suffix, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600))]));
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({required this.title, required this.value, required this.progress, required this.icon, this.done = false});
  final String title, value; final double progress; final IconData icon; final bool done;
  @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 10), child: _Panel(padding: const EdgeInsets.all(12), child: Column(children: [Row(children: [CircleAvatar(radius: 15, backgroundColor: (done ? _green : _purple).withValues(alpha: .18), child: Icon(icon, size: 16, color: done ? _green : const Color(0xFFA895FF))), const SizedBox(width: 11), Expanded(child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))), Text(value, style: TextStyle(color: done ? _green : Colors.white70, fontSize: 12)), const SizedBox(width: 8), Icon(done ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, color: done ? _green : Colors.white38, size: 20)]), const SizedBox(height: 9), ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: progress, minHeight: 3, color: done ? _green : _purple, backgroundColor: Colors.white.withValues(alpha: .08)))])));
}

class _StatCard extends StatelessWidget { const _StatCard({required this.label, required this.value, required this.change, required this.color}); final String label, value, change; final Color color; @override Widget build(BuildContext context) => _Panel(padding: const EdgeInsets.all(13), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)), const SizedBox(height: 7), Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)), Text(change, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold))])); }
class _SectionTitle extends StatelessWidget { const _SectionTitle({required this.title, required this.action}); final String title, action; @override Widget build(BuildContext context) => Row(children: [Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)), const Spacer(), Text('$action  ›', style: const TextStyle(color: Color(0xFFA895FF), fontSize: 12))]); }
class _Panel extends StatelessWidget { const _Panel({required this.child, this.padding = const EdgeInsets.all(16)}); final Widget child; final EdgeInsets padding; @override Widget build(BuildContext context) => Container(padding: padding, decoration: BoxDecoration(color: _surface, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white.withValues(alpha: .045))), child: child); }
Widget _roundIcon(IconData icon, {bool showDot = false}) => Stack(clipBehavior: Clip.none, children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: _surface, shape: BoxShape.circle, border: Border.all(color: Colors.white12)), child: Icon(icon)), if (showDot) const Positioned(right: 1, top: 1, child: CircleAvatar(radius: 4, backgroundColor: _red))]);

class _PageHeader extends StatelessWidget { const _PageHeader({required this.title}); final String title; @override Widget build(BuildContext context) => Row(children: [const Icon(Icons.arrow_back_ios_new_rounded, size: 18), const SizedBox(width: 16), Expanded(child: Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800))), const SizedBox(width: 34)]); }
class _SegmentedLabels extends StatelessWidget {
  const _SegmentedLabels({required this.labels, this.selected = 0});

  final List<String> labels;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: List.generate(
          labels.length,
          (index) => Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: index == selected ? _purple : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                labels[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: index == selected ? Colors.white : Colors.white60,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class _DropDownLabel extends StatelessWidget { const _DropDownLabel({required this.label}); final String label; @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13), decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), border: Border.all(color: Colors.white24)), child: Row(children: [Text(label), const Spacer(), const Icon(Icons.keyboard_arrow_down_rounded)])); }
class _TopicHexagon extends StatelessWidget { const _TopicHexagon({required this.label, required this.color}); final String label; final Color color; @override Widget build(BuildContext context) => ClipPath(clipper: _HexagonClipper(), child: Container(width: 82, height: 92, alignment: Alignment.center, decoration: BoxDecoration(gradient: LinearGradient(colors: [color.withValues(alpha: .82), color.withValues(alpha: .42)]), border: Border.all(color: color)), child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700)))); }
class _HexagonClipper extends CustomClipper<Path> { @override Path getClip(Size s) { final p = Path(); p.moveTo(s.width * .5, 0); p.lineTo(s.width, s.height * .25); p.lineTo(s.width, s.height * .75); p.lineTo(s.width * .5, s.height); p.lineTo(0, s.height * .75); p.lineTo(0, s.height * .25); p.close(); return p; } @override bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false; }
class _Legend extends StatelessWidget { const _Legend({required this.color, required this.label}); final Color color; final String label; @override Widget build(BuildContext context) => Row(children: [CircleAvatar(radius: 5, backgroundColor: color), const SizedBox(width: 6), Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70))]); }
class _PlanTile extends StatelessWidget {
  const _PlanTile({required this.day, required this.title, required this.detail, required this.color});

  final String day;
  final String title;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color,
            child: Text(day, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _Panel(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                        Text('Konu Tekrarı · $detail', style: const TextStyle(color: Colors.white54, fontSize: 11)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: Colors.white54),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _TimeChip extends StatelessWidget { const _TimeChip(this.label, {this.selected = false}); final String label; final bool selected; @override Widget build(BuildContext context) => Container(alignment: Alignment.center, height: 39, decoration: BoxDecoration(color: selected ? _purple : _surface, borderRadius: BorderRadius.circular(10)), child: Text(label, style: const TextStyle(fontSize: 12))); }
class _Badge extends StatelessWidget { const _Badge({required this.icon, required this.label, required this.color}); final IconData icon; final String label; final Color color; @override Widget build(BuildContext context) => Column(children: [Container(width: 70, height: 70, decoration: BoxDecoration(shape: BoxShape.circle, color: color.withValues(alpha: .18), border: Border.all(color: color, width: 3), boxShadow: [BoxShadow(color: color.withValues(alpha: .24), blurRadius: 15)]), child: Icon(icon, color: color, size: 36)), const SizedBox(height: 8), Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600))]); }
