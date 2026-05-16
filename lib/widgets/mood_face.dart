import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mood_tracker/extensions.dart';
import 'package:mood_tracker/models.dart';

class MoodFace extends StatelessWidget {
  final Mood mood;
  final double size;

  const MoodFace({super.key, required this.mood, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: MoodFacePainter(mood),
        size: Size.square(size),
      ),
    );
  }
}

class MoodFacePainter extends CustomPainter {
  final Mood mood;

  MoodFacePainter(this.mood);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final faceRadius = size.width * 0.55;
    final outerCircleRadius = size.width * 0.48;
    
    // Outer circle
    final outerCirclePaint = Paint()
      ..color = mood.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.02;
    canvas.drawCircle(center, outerCircleRadius, outerCirclePaint);

    final facePaint = Paint()..color = mood.color.withAlpha(30);
    canvas.drawCircle(center, faceRadius, facePaint);

    final borderPaint = Paint()
      ..color = mood.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04;
    canvas.drawCircle(center, faceRadius, borderPaint);

    final eyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04
      ..strokeCap = StrokeCap.round;

    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04
      ..strokeCap = StrokeCap.round;

    final browPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03
      ..strokeCap = StrokeCap.round;

    final leftEye = Offset(size.width * 0.32, size.height * 0.37);
    final rightEye = Offset(size.width * 0.68, size.height * 0.37);
    final leftBrow = Offset(size.width * 0.32, size.height * 0.37);
    final rightBrow = Offset(size.width * 0.68, size.height * 0.37);
    final focusedLeftBrow = Offset(size.width * 0.22, size.height * 0.29);
    final focusedRightBrow = Offset(size.width * 0.58, size.height * 0.29);

    final eyeRadius = size.width * 0.09;
 
    switch (mood) {
      case Mood.happy:
        _drawHappyEyes(canvas, leftEye, rightEye, eyeRadius, eyePaint);
        _drawHappyBrows(canvas, leftEye, rightEye, faceRadius, browPaint);
        _drawHappyMouth(canvas, center, size, mouthPaint);
        break;
      case Mood.calm:
        _drawCalmEyes(canvas, leftEye, rightEye, eyeRadius, eyePaint);
        _drawCalmBrows(canvas, leftEye, rightEye, faceRadius, browPaint);
        _drawCalmMouth(canvas, center, size, mouthPaint);
        break;
      case Mood.sad:
        _drawSadEyes(canvas, leftEye, rightEye, eyeRadius, eyePaint);
        _drawSadBrows(canvas, leftBrow, rightBrow, faceRadius, browPaint);
        _drawSadMouth(canvas, center, size, mouthPaint);
        break;
      case Mood.annoyed:
        _drawAnnoyedEyes(canvas, leftEye, rightEye, eyeRadius, eyePaint);
        _drawAnnoyedBrows(canvas, focusedLeftBrow, focusedRightBrow, faceRadius, browPaint);
        _drawAnnoyedMouth(canvas, center, size, mouthPaint);
        break;
      case Mood.angry:
        _drawAngryEyes(canvas, leftEye, rightEye, eyeRadius, eyePaint);
        _drawAngryBrows(canvas, focusedLeftBrow, focusedRightBrow, faceRadius, browPaint);
        _drawAngryMouth(canvas, center, size, mouthPaint);
        break;
  
    }
  }
  // Focused: Slanted brows, eyes and slightly upwards curved mouth
  void _drawAnnoyedEyes(Canvas canvas, Offset leftEye, Offset rightEye, double radius, Paint paint) {
    canvas.drawCircle(leftEye, radius * 0.5, paint..style = PaintingStyle.fill);
    canvas.drawCircle(rightEye, radius * 0.5, paint..style = PaintingStyle.fill);
    paint.style = PaintingStyle.stroke;
  }
  void _drawAngryEyes(Canvas canvas, Offset leftEye, Offset rightEye, double radius, Paint paint) {
    canvas.drawCircle(leftEye, radius * 0.5, paint..style = PaintingStyle.fill);
    canvas.drawCircle(rightEye, radius * 0.5, paint..style = PaintingStyle.fill);
    paint.style = PaintingStyle.stroke;
  }

  void _drawAnnoyedBrows(Canvas canvas, Offset leftBrow, Offset rightBrow, double radius, Paint paint){
      final leftPath = Path();
      leftPath.moveTo(leftBrow.dx, leftBrow.dy);
      leftPath.lineTo(leftBrow.dx + 10, leftBrow.dy);
      canvas.drawPath(leftPath, paint);

      final rightPath = Path();
      rightPath.moveTo(rightBrow.dx, rightBrow.dy);
      rightPath.lineTo(rightBrow.dx + 10, rightBrow.dy);
      canvas.drawPath(rightPath, paint);
  }
  void _drawAnnoyedMouth(Canvas canvas, Offset center, Size size, Paint paint) {
      final mouthRect = Rect.fromCenter(
      center: center.translate(0, size.height * 0.15),
      width: size.width * 0.35,
      height: size.height * 0.25,
    );
    canvas.drawArc(mouthRect, -pi * 0.1, -pi * 0.8, false, paint);

  }
  // HAPPY: curved eyes (arcs), curved brows, smile
  void _drawHappyEyes(Canvas canvas, Offset leftEye, Offset rightEye, double radius, Paint paint) {
    final leftRect = Rect.fromCircle(center: leftEye, radius: radius);
    final rightRect = Rect.fromCircle(center: rightEye, radius: radius);
    canvas.drawArc(leftRect, 0, -pi, false, paint);
    canvas.drawArc(rightRect, 0, -pi, false, paint);
  }

  void _drawHappyBrows(Canvas canvas, Offset leftEye, Offset rightEye, double radius, Paint paint) {
    // No visible brows in happy face from image
  }

  void _drawHappyMouth(Canvas canvas, Offset center, Size size, Paint paint) {
    final mouthRect = Rect.fromCenter(
      center: center.translate(0, size.height * 0.15),
      width: size.width * 0.35,
      height: size.height * 0.25,
    );
    canvas.drawArc(mouthRect, pi * 0.1, pi * 0.8, false, paint);
  }

  // CALM: closed eyes (downward curves), gentle brows, slight smile
  void _drawCalmEyes(Canvas canvas, Offset leftEye, Offset rightEye, double radius, Paint paint) {
   final leftRect = Rect.fromCircle(center: leftEye, radius: radius);
    final rightRect = Rect.fromCircle(center: rightEye, radius: radius);
    canvas.drawArc(leftRect, 0, pi, false, paint);
    canvas.drawArc(rightRect, 0, pi, false, paint);
  }

  void _drawCalmBrows(Canvas canvas, Offset leftEye, Offset rightEye, double radius, Paint paint) {
    // No visible brows in calm face from image
  }

  void _drawCalmMouth(Canvas canvas, Offset center, Size size, Paint paint) {
    final mouthRect = Rect.fromCenter(
      center: center.translate(0, size.height * 0.15),
      width: size.width * 0.35,
      height: size.height * 0.25,
    );
    canvas.drawArc(mouthRect, pi * 0.1, pi * 0.8, false, paint);
  }

  // SAD: dots for eyes, sad brows (inverted V), frown
  void _drawSadEyes(Canvas canvas, Offset leftEye, Offset rightEye, double radius, Paint paint) {
    canvas.drawCircle(leftEye, radius * 0.5, paint..style = PaintingStyle.fill);
    canvas.drawCircle(rightEye, radius * 0.5, paint..style = PaintingStyle.fill);
    paint.style = PaintingStyle.stroke;
  }

  void _drawSadBrows(Canvas canvas, Offset leftBrow, Offset rightBrow, double radius, Paint paint) {
    // Left brow (shorter and curved - inverted V)
    final leftPath = Path();
    leftPath.moveTo(leftBrow.dx - radius * 0.3, leftBrow.dy - radius * 0.25);
    leftPath.quadraticBezierTo(
      leftBrow.dx,                    // Control point x
      leftBrow.dy - radius * 0.2,     // Control point y (peak)
      leftBrow.dx + radius * 0.15,    // End point x
      leftBrow.dy - radius * 0.35     // End point y
    );
    canvas.drawPath(leftPath, paint);
    
    // Right brow (shorter and curved - inverted V)
    final rightPath = Path();
    rightPath.moveTo(rightBrow.dx - radius * 0.15, rightBrow.dy - radius * 0.35);
    rightPath.quadraticBezierTo(
      rightBrow.dx,                   // Control point x
      rightBrow.dy - radius * 0.2,    // Control point y (peak)
      rightBrow.dx + radius * 0.3,    // End point x
      rightBrow.dy - radius * 0.25    // End point y
    );
    canvas.drawPath(rightPath, paint);
  }

  void _drawSadMouth(Canvas canvas, Offset center, Size size, Paint paint) {
     final mouthRect = Rect.fromCenter(
      center: center.translate(0, size.height * 0.30),
      width: size.width * 0.30,
      height: size.height * 0.30,
    );
    canvas.drawArc(mouthRect,-pi * 0.1, -pi * 0.8, false, paint);
  }

  // FOCUSED: Same eyes as annoyed, straight brows angled inward, shallow mouth arc
  void _drawAngryBrows(Canvas canvas, Offset leftBrow, Offset rightBrow, double radius, Paint paint) {
    // Left brow - straight line angled down to the right
    final leftPath = Path();
    leftPath.moveTo(leftBrow.dx, leftBrow.dy);              // Start higher on left
    leftPath.lineTo(leftBrow.dx + 10, leftBrow.dy + 3);     // End lower on right
    canvas.drawPath(leftPath, paint);

    // Right brow - straight line angled down to the left
    final rightPath = Path();
    rightPath.moveTo(rightBrow.dx, rightBrow.dy + 3);       // Start lower on left
    rightPath.lineTo(rightBrow.dx + 10, rightBrow.dy);      // End higher on right
    canvas.drawPath(rightPath, paint);
  }

  void _drawAngryMouth(Canvas canvas, Offset center, Size size, Paint paint) {
    // Shallower arc than annoyed
    final mouthRect = Rect.fromCenter(
      center: center.translate(0, size.height * 0.15),
      width: size.width * 0.35,
      height: size.height * 0.2,  // Reduced height for shallower curve
    );
    canvas.drawArc(mouthRect, -pi * 0.1, -pi * 0.8, false, paint);
  }

  @override
  bool shouldRepaint(covariant MoodFacePainter oldDelegate) {
    return oldDelegate.mood != mood;
  }
}
