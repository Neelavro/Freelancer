import 'package:flutter/material.dart';

class BalanceBoxPainter extends CustomPainter {
  final Color color;

  BalanceBoxPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.003030697, size.height * 0.1000000);
    path_0.cubicTo(size.width * 0.003030697, size.height * 0.04477150,
        size.width * 0.01388442, 0, size.width * 0.02727312, 0);
    path_0.lineTo(size.width * 0.7333333, 0);
    path_0.cubicTo(
        size.width * 0.7333333,
        size.height * 0.05578950,
        size.width * 0.8318182,
        size.height * 0.3636375,
        size.width * 0.8832212,
        size.height * 0.3277638);
    path_0.cubicTo(
        size.width * 0.9242424,
        size.height * 0.2991350,
        size.width * 0.9755758,
        size.height * 0.5392988,
        size.width * 0.9967727,
        size.height * 0.6625000);
    path_0.lineTo(size.width * 0.9967727, size.height * 0.7375000);
    path_0.cubicTo(
        size.width * 0.9968515,
        size.height * 0.7337975,
        size.width * 0.9967212,
        size.height * 0.8160262,
        size.width * 0.9967727,
        size.height * 0.8125000);
    path_0.lineTo(size.width * 0.9969697, size.height * 0.9000000);
    path_0.cubicTo(
        size.width * 0.9969697,
        size.height * 0.9552288,
        size.width * 0.9861152,
        size.height,
        size.width * 0.9727273,
        size.height);
    path_0.lineTo(size.width * 0.2668476, size.height);
    path_0.cubicTo(
        size.width * 0.2668476,
        size.height * 0.9442100,
        size.width * 0.1683627,
        size.height * 0.6363625,
        size.width * 0.1169594,
        size.height * 0.6722362);
    path_0.cubicTo(
        size.width * 0.07593848,
        size.height * 0.7008650,
        size.width * 0.02460415,
        size.height * 0.4607012,
        size.width * 0.003407848,
        size.height * 0.3375000);
    path_0.lineTo(size.width * 0.003029958, size.height * 0.2375000);
    path_0.cubicTo(
        size.width * 0.002780921,
        size.height * 0.2493400,
        size.width * 0.003408121,
        size.height * 0.2018213,
        size.width * 0.003030697,
        size.height * 0.1437500);
    path_0.lineTo(size.width * 0.003030697, size.height * 0.1000000);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color.withOpacity(.07);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9695212, 0);
    path_1.lineTo(size.width * 0.7333333, 0);
    path_1.cubicTo(
        size.width * 0.7333333,
        size.height * 0.05578950,
        size.width * 0.8318182,
        size.height * 0.3636375,
        size.width * 0.8832212,
        size.height * 0.3277638);
    path_1.cubicTo(
        size.width * 0.9242424,
        size.height * 0.2991350,
        size.width * 0.9755758,
        size.height * 0.5392988,
        size.width * 0.9967727,
        size.height * 0.6625000);
    path_1.lineTo(size.width * 0.9967727, size.height * 0.1534213);
    path_1.cubicTo(
        size.width, 0, size.width * 0.9818182, 0, size.width * 0.9695212, 0);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = color.withOpacity(.24);
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.03065970, size.height);
    path_2.lineTo(size.width * 0.2668473, size.height);
    path_2.cubicTo(
        size.width * 0.2668473,
        size.height * 0.9442100,
        size.width * 0.1683624,
        size.height * 0.6363625,
        size.width * 0.1169591,
        size.height * 0.6722362);
    path_2.cubicTo(
        size.width * 0.07593818,
        size.height * 0.7008650,
        size.width * 0.02460376,
        size.height * 0.4607012,
        size.width * 0.003407455,
        size.height * 0.3375000);
    path_2.lineTo(size.width * 0.003407424, size.height * 0.8465787);
    path_2.cubicTo(
        size.width * 0.0001805161,
        size.height,
        size.width * 0.01836233,
        size.height,
        size.width * 0.03065970,
        size.height);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = color.withOpacity(.24);
    canvas.drawPath(path_2, paint2Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
