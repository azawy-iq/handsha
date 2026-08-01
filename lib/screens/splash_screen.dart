import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _stage = 0; // 0: الشعار والاسم, 1: انيميشن التحميل, 2: عبارة افتخار عراقية

  @override
  void initState() {
    super.initState();
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // 1. عرض اسم وشعار التطبيق لمدة 2.5 ثانية
    await Future.delayed(const Duration(milliseconds: 2500));
    if (!mounted) return;
    setState(() => _stage = 1);

    // 2. انيميشن نقاط التحميل الانتقالي
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => _stage = 2);

    // 3. عرض "بفخر منتج عراقي"
    await Future.delayed(const Duration(milliseconds: 2500));
    if (!mounted) return;

    // 4. الانتقال للشاشة الرئيسية
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // إضاءة بلور خفيفة في الخلفية
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white10,
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white12,
              ),
            ),
          ),

          // تأثير البلور الزجاجي على الخلفية
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
            child: Container(color: Colors.transparent),
          ),

          // المحتوى المتحرك
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: _buildStageContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStageContent() {
    if (_stage == 0) {
      // المرحلة الأولى: الشعار واسم التطبيق
      return Column(
        key: const ValueKey(0),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 1000),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white30, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.05),
                    blurRadius: 20,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: const Icon(
                Icons.architecture_rounded,
                size: 85,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 28),
          FadeInUp(
            duration: const Duration(milliseconds: 1200),
            child: const Text(
              'هندسها',
              style: TextStyle(
                fontSize: 46,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 2.5,
              ),
            ),
          ),
          const SizedBox(height: 10),
          FadeInUp(
            delay: const Duration(milliseconds: 400),
            child: const Text(
              'عالم الديكور والتصاميم الحديثة',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      );
    } else if (_stage == 1) {
      // المرحلة الثانية: انيميشن النقاط الانتقالية
      return Column(
        key: const ValueKey(1),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ZoomIn(
            duration: const Duration(milliseconds: 500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      // المرحلة الثالثة: الفخر العراقي
      return Column(
        key: const ValueKey(2),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: const Text(
              'بفخر منتج',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ZoomIn(
            duration: const Duration(milliseconds: 1000),
            child: const Text(
              'عِرَاقِي',
              style: TextStyle(
                fontSize: 54,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),
          ),
        ],
      );
    }
  }
}
