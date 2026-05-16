import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const FlashQuestApp());
}

class FlashQuestApp extends StatelessWidget {
  const FlashQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flash Quest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MainMenuPage(),
    );
  } 
}

// --- LAYAR 1: MENU UTAMA ---
class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;
  late AnimationController _btnController;
  late Animation<double> _btnScale;

  @override 
  void initState() {
    super.initState();
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _logoAnimation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut), 
    );

    _btnController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse:true);

    _btnScale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _btnController, curve: Curves.easeInOut),
    ); 
  }

  @override
  void dispose() {
    _logoController.dispose();
    _btnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
              ),
            ),
          ),
          Opacity(
            opacity: 0.5,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(color: Colors.white.withOpacity(0.3), height: 260),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, -_logoAnimation.value),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: const Icon(Icons.stars_rounded, size: 120, color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "FlashQuest", 
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 5,
                              shadows: [Shadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 4)],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Text(
                  "Belajar & Bermain Seru",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 80),
                ScaleTransition(
                  scale: _btnScale,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CategoryPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.white, Color(0xFFF1F8E9)],
                          begin: Alignment..topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 1,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.play_arrow_rounded, color: Colors.green, size: 35),
                          const SizedBox(width: 12),
                          Text(
                            "PLAY",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- LAYAR 2: PILIH KATEGORI ---
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with SingleTickerProviderStateMixin {
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF1F8E9), Color(0xFFDCEDC8)],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 0.3,
              child: ClipPath(
                clipper: BottomWaveClipper(),
                child: Container(
                  color: Colors.green,
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.green),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mau Tebak Gambar Apa Hari Ini?",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      Text(
                        "Pilih salah satu untuk mulai menebak!",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 80),
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: [
                      _animatedCard(0, "BUAH", "🍎", const Color(0xFFFFCC80)),
                      _animatedCard(1, "SAYUR", "🥦", const Color(0xFFA5D6A7)),
                      _animatedCard(2, "IKAN", "🐟", const Color(0xFF90CAF9)),
                      _animatedCard(3, "PROFESI", "👨‍✈️", const Color(0xFFCE93D8)),
                      _animatedCard(4, "BENDA", "🎁", const Color(0xFFBCAAA4)),
                      _animatedCard(5, "HEWAN", "🦁", const Color(0xFFFFAB91)),
                      _animatedCard(6, "KENDARAAN", "🚀", const Color(0xFF80CBC4)),
                      _animatedCard(7, "WARNA", "🎨", const Color(0xFFFFF59D)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _animatedCard(int index, String title, String emoji, Color color){
   return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        double offset = sin((_floatController.value * 2 * pi) + (index * 0.5)) * 8;
        return Transform.translate(
          offset: Offset(0, offset),
          child: _card(context, title, emoji, color),
        );
      },
    ); 
  }

  Widget _card(BuildContext context, String title, String emoji, Color color) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WordGamePage(category: title)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Text(emoji,style: const TextStyle(fontSize: 45)),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1.1
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
  

                    