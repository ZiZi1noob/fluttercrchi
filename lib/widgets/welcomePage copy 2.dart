import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    final isDesktop = screenWidth > 600;

    return Scaffold(
      // 添加科技感背景
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.purple.shade800,
              Colors.black,
            ],
          ),
        ),
        child: Stack(
          children: [
            // 背景科技感元素
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -80,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purple.withOpacity(0.1),
                ),
              ),
            ),

            // 网格线背景
            CustomPaint(
              painter: _GridPainter(),
              size: Size(screenWidth, screenHeight),
            ),

            // 玻璃效果内容
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isDesktop
                            ? screenWidth * 0.5
                            : screenWidth * 0.9,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.15),
                              Colors.white.withOpacity(0.05),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Animated Title
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [_Title(), _CatLottie()],
                            ),
                            const SizedBox(height: 40),
                            const _Username(),
                            SizedBox(height: screenHeight * 0.03),
                            // 添加科技感按钮
                            _TechButton(onPressed: () {}, text: '进入系统'),
                            SizedBox(height: screenHeight * 0.02),
                            // 添加科技感文字链接
                            _TechTextLink(text: '没有账号？立即注册', onTap: () {}),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 添加浮动科技感元素
            Positioned(
              top: screenHeight * 0.2,
              left: screenWidth * 0.1,
              child: _FloatingTechElement(),
            ),
            Positioned(
              bottom: screenHeight * 0.2,
              right: screenWidth * 0.1,
              child: _FloatingTechElement(),
            ),
          ],
        ),
      ),
    );
  }
}

// 网格背景绘制
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.05)
      ..strokeWidth = 0.5;

    // 绘制垂直线
    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // 绘制水平线
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 科技感按钮
class _TechButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const _TechButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.cyanAccent,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Colors.cyanAccent.withOpacity(0.8),
                width: 1,
              ),
            ),
            shadowColor: Colors.cyanAccent.withOpacity(0.5),
            elevation: 8,
          ),
          child: Text(text),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.2));
  }
}

// 科技感文字链接
class _TechTextLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _TechTextLink({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.cyanAccent.withOpacity(0.8),
          fontSize: 14,
          decoration: TextDecoration.underline,
          decorationColor: Colors.cyanAccent.withOpacity(0.5),
          shadows: [
            Shadow(color: Colors.cyanAccent.withOpacity(0.3), blurRadius: 10),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 500.ms);
  }
}

// 浮动科技感元素
class _FloatingTechElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.cyanAccent.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(
            Icons.star,
            color: Colors.cyanAccent.withOpacity(0.5),
            size: 24,
          ),
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .move(duration: 3000.ms, curve: Curves.easeInOut)
        .scale(
          begin: Offset(0.8, 0.8),
          end: Offset(1.2, 1.2),
          duration: 3000.ms,
          curve: Curves.easeInOut,
        );
  }
}

// 假设的其他组件（需要根据实际情况实现）
class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      '科技系统',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: [
          Shadow(color: Colors.cyanAccent.withOpacity(0.5), blurRadius: 10),
        ],
      ),
    );
  }
}

class _CatLottie extends StatelessWidget {
  const _CatLottie();

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.pets, color: Colors.white, size: 40);
  }
}

class _Username extends StatelessWidget {
  const _Username();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: '用户名',
        labelStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.cyanAccent.withOpacity(0.5),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.cyanAccent.withOpacity(0.5),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.cyanAccent, width: 2),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        prefixIcon: Icon(Icons.person, color: Colors.white70),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
