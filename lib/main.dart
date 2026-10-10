import 'package:flutter/material.dart';

void main() {
  runApp(const TumaneenaApp());
}

class TumaneenaApp extends StatelessWidget {
  const TumaneenaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'طمأنينة',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E17),
        cardColor: const Color(0xFF121B2A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37),
          secondary: Color(0xFF1E293B),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// ----------------- الشاشة الرئيسية والتنقل -----------------
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const LibraryScreen(),
    const SearchScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0F172A),
        selectedItemColor: const Color(0xFFD4AF37),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'المكتبة'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'البحث'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}

// ----------------- الصفحة الرئيسية -----------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'طَمَأْنِينَة',
          style: TextStyle(color: Color(0xFFD4AF37), fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // أوقات الصلاة والنجف
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF121B2A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.location_on, color: Color(0xFFD4AF37), size: 18),
                          SizedBox(width: 4),
                          Text('النجف الأشرف', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                      Text('الأثنين، 2 ربيع الثاني 1448 هـ', style: TextStyle(color: Colors.amber.shade200, fontSize: 12)),
                    ],
                  ),
                  const Divider(color: Colors.white10, height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildPrayerTime('الفجر', '4:37'),
                      _buildPrayerTime('الشروق', '6:00'),
                      _buildPrayerTime('الظهر', '12:10'),
                      _buildPrayerTime('العصر', '3:42'),
                      _buildPrayerTime('المغرب', '6:12', isNext: true),
                      _buildPrayerTime('العشاء', '7:32'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // آية الطمأنينة واليوم
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF1E293B), Color(0xFF0F172A)]),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.2)),
              ),
              child: const Column(
                children: [
                  Text(
                    '﴿ أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ ﴾',
                    style: TextStyle(color: Color(0xFFD4AF37), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'آية اليوم: ﴿ وَإِذَا سَأَلَكَ عِبَادِي عَنِّي فَإِنِّي قَرِيبٌ ﴾',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // الأقسام الرئيسية
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                _buildGridCard(context, 'القرآن الكريم', Icons.menu_book, const QuranScreen()),
                _buildGridCard(context, 'الأدعية', Icons.volunteer_activism, const DuasScreen()),
                _buildGridCard(context, 'المناجاة', Icons.nights_stay, const MonajatScreen()),
                _buildGridCard(context, 'الزيارات', Icons.mosque, const ZiyaratScreen()),
                _buildGridCard(context, 'الأذكار', Icons.wb_sunny, const AzkarScreen()),
                _buildGridCard(context, 'المسبحة', Icons.grain, const TasbeehScreen()),
              ],
            ),
            const SizedBox(height: 12),

            _buildWideCard(context, 'صلاة الليل', 'كيفية صلاة الليل والفضل والأدعية', Icons.bedtime, const NightPrayerScreen()),
            const SizedBox(height: 10),
            _buildWideCard(context, 'سيرة وفضائل أهل البيت', 'سيرة المعصومين وأقوال مفيدة للشباب', Icons.auto_awesome, const AhlAlBaytScreen()),
            const SizedBox(height: 10),
            _buildWideCard(context, 'المسائل الفقهية (Gemini AI)', 'إجابات مباشرة واستفسارات عقائدية', Icons.smart_toy, const FiqhAiScreen()),
          ],
        ),
      ),
    );
  }

  static Widget _buildPrayerTime(String name, String time, {bool isNext = false}) {
    return Column(
      children: [
        Text(name, style: TextStyle(color: isNext ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 11)),
        const SizedBox(height: 4),
        Text(time, style: TextStyle(color: isNext ? const Color(0xFFD4AF37) : Colors.white, fontWeight: isNext ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
      ],
    );
  }

  static Widget _buildGridCard(BuildContext context, String title, IconData icon, Widget targetScreen) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: const Color(0xFFD4AF37).withOpacity(0.15))),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => targetScreen)),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 38, color: const Color(0xFFD4AF37)),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
          ],
        ),
      ),
    );
  }

  static Widget _buildWideCard(BuildContext context, String title, String subtitle, IconData icon, Widget targetScreen) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: const Color(0xFFD4AF37).withOpacity(0.15))),
      child: ListTile(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => targetScreen)),
        leading: Icon(icon, color: const Color(0xFFD4AF37), size: 30),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white30, size: 14),
      ),
    );
  }
}

// ----------------- 1. شاشة القرآن الكريم -----------------
class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('القرآن الكريم والتفسير'), backgroundColor: const Color(0xFF0F172A)),
      body: ListView.builder(
        itemCount: 114,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(backgroundColor: const Color(0xFF1E293B), child: Text('${index + 1}', style: const TextStyle(color: Color(0xFFD4AF37)))),
            title: Text('سورة رقم ${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: const Text('قراءة، استماع صوتي، وتفسير الآيات', style: TextStyle(color: Colors.grey, fontSize: 12)),
            trailing: const Icon(Icons.volume_up, color: Color(0xFFD4AF37)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => QuranDetailScreen(surahNumber: index + 1)));
            },
          );
        },
      ),
    );
  }
}

class QuranDetailScreen extends StatelessWidget {
  final int surahNumber;
  const QuranDetailScreen({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('سورة رقم $surahNumber'), backgroundColor: const Color(0xFF0F172A)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('[نص الآيات كاملة هنا مع التفسير الميسر وأزرار تشغيل الصوت في الخلفية]', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.8)),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------- 2. شاشة الأدعية -----------------
class DuasScreen extends StatelessWidget {
  const DuasScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> duas = [
      {'title': 'دعاء كميل بن زياد', 'content': 'اللَّهُمَّ إِنِّي أَسْأَلُكَ بِرَحْمَتِكَ الَّتِي وَسِعَتْ كُلَّ شَيْﺀٍ...'},
      {'title': 'دعاء التوسل', 'content': 'اللَّهُمَّ إِنِّي أَسْأَلُكَ وَأَتَوَجَّهُ إِلَيْكَ بِنَبِيِّكَ نَبِيِّ الرَّحْمَةِ...'},
      {'title': 'دعاء الصباح', 'content': 'اللَّهُمَّ يَا مَنْ دَلَعَ لِسَانَ الصَّبَاحِ بِبَشَائِرِ إِشْرَاقِهِ...'},
      {'title': 'دعاء العهد', 'content': 'اللَّهُمَّ رَبَّ النُّورِ الْعَظِيمِ وَرَبَّ الْكُرْسِيِّ الرَّفِيعِ...'},
      {'title': 'دعاء مكارم الأخلاق', 'content': 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَآلِ مُحَمَّدٍ، وَبَلِّغْ بِإِيمَانِي أَكْمَلَ الْإِيمَانِ...'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('الأدعية المباركة كاملة'), backgroundColor: const Color(0xFF0F172A)),
      body: ListView.builder(
        itemCount: duas.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(duas[index]['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.menu_book, color: Color(0xFFD4AF37)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContentDetailScreen(title: duas[index]['title']!, content: duas[index]['content']!)));
              },
            ),
          );
        },
      ),
    );
  }
}

// ----------------- 3. شاشة المناجاة -----------------
class MonajatScreen extends StatelessWidget {
  const MonajatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المناجيات الخمس عشرة'), backgroundColor: const Color(0xFF0F172A)),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('المناجاة رقم ${index + 1} للإمام السجاد (ع)', style: const TextStyle(color: Colors.white)),
            subtitle: const Text('إِلَهِي أَلْبَسَتْنِي الْخَطَايَا ثَوْبَ مَذَلَّتِي...', style: TextStyle(color: Colors.grey, fontSize: 12)),
            trailing: const Icon(Icons.nightlight_round, color: Color(0xFFD4AF37)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContentDetailScreen(title: 'المناجاة رقم ${index + 1}', content: 'النص الكامل للمناجاة مع الترجمة والفضيلة...')));
            },
          );
        },
      ),
    );
  }
}

// ----------------- 4. شاشة الزيارات -----------------
class ZiyaratScreen extends StatelessWidget {
  const ZiyaratScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> ziyarats = ['زيارة عاشوراء', 'زيارة أمين الله', 'الزيارة الجامعة الكبيرة', 'زيارة وارث', 'زيارة الإمام الحسين (ع)', 'زيارة الإمام الرضا (ع)'];
    return Scaffold(
      appBar: AppBar(title: const Text('الزيارات المأثورة كاملة'), backgroundColor: const Color(0xFF0F172A)),
      body: ListView.builder(
        itemCount: ziyarats.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ziyarats[index], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            trailing: const Icon(Icons.mosque, color: Color(0xFFD4AF37)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContentDetailScreen(title: ziyarats[index], content: 'النص الكامل للزيارة مباركاً بالحركات...')));
            },
          );
        },
      ),
    );
  }
}

// ----------------- 5. شاشة الأذكار -----------------
class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> azkar = ['أذكار الصباح والمساء', 'أذكار النوم', 'أذكار الاستيقاظ', 'تعقيبات الصلوات'];
    return Scaffold(
      appBar: AppBar(title: const Text('الأذكار اليومية'), backgroundColor: const Color(0xFF0F172A)),
      body: ListView.builder(
        itemCount: azkar.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(azkar[index], style: const TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.wb_sunny, color: Color(0xFFD4AF37)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContentDetailScreen(title: azkar[index], content: 'الأذكار الواردة كاملة مع عدد التكرار...')));
            },
          );
        },
      ),
    );
  }
}

// ----------------- 6. المسبحة الإلكترونية -----------------
class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});
  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int count = 0;
  int total = 0;
  String tasbeehText = 'اللهم صل على محمد وآل محمد';

  void increment() {
    setState(() {
      count++;
      total++;
      if (count <= 34) {
        tasbeehText = 'الله أكبر';
      } else if (count <= 67) {
        tasbeehText = 'الحمد لله';
      } else if (count <= 100) {
        tasbeehText = 'سبحان الله';
      } else {
        count = 1;
        tasbeehText = 'الله أكبر';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مسبحة فاطمة الزهراء (ع)'), backgroundColor: const Color(0xFF0F172A)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tasbeehText, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFD4AF37), width: 4)),
              child: Center(
                child: Text('$count', style: const TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() { count = 0; total = 0; tasbeehText = 'الله أكبر'; }),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade800),
                  child: const Text('إعادة'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: increment,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
                  child: const Text('تسبيح (+1)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('إجمالي التسبيحات: $total', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// ----------------- 7. صلاة الليل -----------------
class NightPrayerScreen extends StatelessWidget {
  const NightPrayerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('صلاة الليل'), backgroundColor: const Color(0xFF0F172A)),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('كيفية صلاة الليل:', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('تتكون صلاة الليل من 11 ركعة:\n- 8 ركعات (أربع صلوات كل صلاة ركعتان كصلاة الصبح بنية نافلة الليل).\n- ركعتا الشفع.\n- ركعة الوتر (يقنت فيها ويستغفر للاربعين مؤمناً).', style: TextStyle(color: Colors.white70, height: 1.6)),
              SizedBox(height: 20),
              Text('من أقوال أهل البيت في فضلها:', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('عن الإمام الصادق (ع): "شرف المؤمن صلاته بالليل وعزه استغناؤه عن الناس."', style: TextStyle(color: Colors.white70, height: 1.6)),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------- 8. سيرة وفضائل أهل البيت وأقوال الشباب -----------------
class AhlAlBaytScreen extends StatelessWidget {
  const AhlAlBaytScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> imams = [
      {'name': 'الإمام علي بن أبي طالب (ع)', 'sayings': ['إنما قلب الحدث كالارض الخالية ما أُلقي فيها من شيء قبلته.', 'عجبت لمن يعجز عن إصلاح نفسه كيف يصلح غيره.', 'الأدب يغني عن الحسب.', 'قيمة كل امرئ ما يحسنه.', 'من تساوى يوماه فهو مغبون.']},
      {'name': 'الإمام الحسن المجتبى (ع)', 'sayings': ['لا تعجل بالعقوبة واجعل بينهما للإعتذار طريقاً.', 'حسن السؤال نصف العلم.', 'علم الناس علمك وتعلم علم غيرك.', 'أبخل الناس من بخل بالسلام.', 'إن أحسن الحسن الخلق الحسن.']},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('سيرة وفضائل أهل البيت للشباب'), backgroundColor: const Color(0xFF0F172A)),
      body: ListView.builder(
        itemCount: imams.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(imams[index]['name'], style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
            subtitle: const Text('السيرة العطرة و 10 أقوال مفيدة للشباب', style: TextStyle(color: Colors.grey, fontSize: 12)),
            children: (imams[index]['sayings'] as List).map((s) => ListTile(title: Text(s, style: const TextStyle(color: Colors.white70, fontSize: 13)))).toList(),
          );
        },
      ),
    );
  }
}

// ----------------- 9. المسائل الفقهية مع Gemini AI -----------------
class FiqhAiScreen extends StatefulWidget {
  const FiqhAiScreen({super.key});
  @override
  State<FiqhAiScreen> createState() => _FiqhAiScreenState();
}

class _FiqhAiScreenState extends State<FiqhAiScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _chat = [];

  void _sendQuestion() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _chat.add('سؤالك: ${_controller.text}');
        _chat.add('الرد الذكي (Gemini): بحسب فتاوى السيد السيستاني (دام ظله)، الإجابة هي كذا وكذا...');
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المسائل الفقهية (مساعد Gemini)'), backgroundColor: const Color(0xFF0F172A)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _chat.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(_chat[index], style: TextStyle(color: index.isEven ? Colors.white : Colors.amber.shade200, fontSize: 14)),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'اكتب سؤالك الفقهي أو العقائدي...',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Color(0xFF121B2A),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send, color: Color(0xFFD4AF37)), onPressed: _sendQuestion),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// صفحة عامة لعرض محتوى الدعاء أو الزيارة كاملة
class ContentDetailScreen extends StatelessWidget {
  final String title;
  final String content;
  const ContentDetailScreen({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: const Color(0xFF0F172A)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(content, textAlign: TextAlign.right, style: const TextStyle(color: Colors.white, fontSize: 18, height: 2.0)),
        ),
      ),
    );
  }
}

// الشاشات السفلية التكميلية
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('المكتبة الشاملة للكتب والخطب', style: TextStyle(color: Colors.white))));
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('البحث الشامل في التطبيق', style: TextStyle(color: Colors.white))));
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('قائمة المفضلة الخاصة بك', style: TextStyle(color: Colors.white))));
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('إعدادات التطبيق والمظهر', style: TextStyle(color: Colors.white))));
}
