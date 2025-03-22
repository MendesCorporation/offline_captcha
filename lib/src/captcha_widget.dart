import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'captcha_controller.dart';
import 'captcha_theme.dart';

class CaptchaWidget extends StatelessWidget {
  final CaptchaController controller;
  final CaptchaTheme theme;
  final double width;
  final double height;

  const CaptchaWidget({
    Key? key,
    required this.controller,
    this.theme = const CaptchaTheme(),
    this.width = 300,
    this.height = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        return RepaintBoundary(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              borderRadius: theme.borderRadius,
              boxShadow: theme.boxShadow != null ? [theme.boxShadow!] : null,
            ),
            child: ClipRRect(
              borderRadius: theme.borderRadius,
              child: _buildCaptchaPaint(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCaptchaPaint() {
    return CustomPaint(
      painter: CaptchaPainter(
        code: controller.code,
        theme: theme,
        isWeb: kIsWeb,
        seed: controller.seed,
      ),
    );
  }
}

class CaptchaPainter extends CustomPainter {
  final String code;
  final CaptchaTheme theme;
  final bool isWeb;
  final int seed;
  late final Random random;

  CaptchaPainter({
    required this.code,
    required this.theme,
    required this.seed,
    this.isWeb = false,
  }) {
    random = Random(seed);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    final paint = Paint()
      ..color = theme.backgroundColor
      ..filterQuality = FilterQuality.high;
    canvas.drawRect(Offset.zero & size, paint);

    if (isWeb) {
      canvas.scale(1.0, 1.0);
      canvas.save();
    }

    // First draw all numbers
    final numberPositions = _calculateNumberPositions(size);
    for (var i = 0; i < code.length; i++) {
      _drawNumber(canvas, numberPositions[i], code[i]);
    }

    // Then draw scribbles on top
    _drawScribbles(canvas, size, numberPositions);
  }

  void _drawScribbles(Canvas canvas, Size size, List<Offset> numberPositions) {
    final scribbleCount = (35 * theme.scribbleIntensity).round(); // Increased count
    final random = Random();
    
    for (var i = 0; i < scribbleCount; i++) {
      final paint = Paint()
        ..color = theme.scribbleColors[random.nextInt(theme.scribbleColors.length)]
        ..strokeWidth = isWeb ? 2.5 : 2.0 // Thicker lines
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final path = Path();
      
      // Get random position across whole canvas
      var x = random.nextDouble() * size.width;
      var y = random.nextDouble() * size.height;
      path.moveTo(x, y);

      // Create shorter, more dynamic scribbles
      final segments = random.nextInt(2) + 2; // 2-3 segments
      for (var j = 0; j < segments; j++) {
        // Shorter movements for more controlled scribbles
        x += (random.nextDouble() - 0.5) * 30;
        y += (random.nextDouble() - 0.5) * 30;
        
        // Add some randomness to line style
        if (random.nextBool()) {
          // Curved line
          final controlX = x + (random.nextDouble() - 0.5) * 20;
          final controlY = y + (random.nextDouble() - 0.5) * 20;
          path.quadraticBezierTo(controlX, controlY, x, y);
        } else {
          // Straight line
          path.lineTo(x, y);
        }
      }

      // Add some small decorative dots occasionally
      if (random.nextDouble() < 0.3) {
        paint.style = PaintingStyle.fill;
        canvas.drawCircle(
          Offset(x + random.nextDouble() * 4, y + random.nextDouble() * 4),
          random.nextDouble() * 2 + 1,
          paint
        );
      }

      canvas.drawPath(path, paint);
    }
  }

  List<Offset> _calculateNumberPositions(Size size) {
    final positions = <Offset>[];
    final spacing = size.width / (code.length + 1);
    
    for (var i = 0; i < code.length; i++) {
      final x = spacing * (i + 1);
      // Add slight vertical randomization
      final y = size.height / 2 + (random.nextDouble() - 0.5) * 10;
      positions.add(Offset(x, y));
    }
    return positions;
  }

  void _drawNumber(Canvas canvas, Offset position, String digit) {
    final textStyle = TextStyle(
      color: theme.numberColor,
      fontSize: theme.fontSize,
      fontFamily: theme.fontFamily,
      fontWeight: FontWeight.bold,
    );

    final textSpan = TextSpan(text: digit, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    
    canvas.save();
    canvas.translate(position.dx, position.dy);
    canvas.rotate((random.nextDouble() - 0.5) * 0.3);
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(CaptchaPainter oldDelegate) {
    return oldDelegate.code != code || oldDelegate.seed != seed;
  }
}
