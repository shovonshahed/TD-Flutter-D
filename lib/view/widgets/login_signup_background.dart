import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginSignupBackgroundWidget extends StatelessWidget {
  final Widget child;
  const LoginSignupBackgroundWidget({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(
              411.w,
              (411.w * 0.7292682926829268)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(),
        ),
        CustomPaint(
          size: Size(
              411.w,
              (411.w * 0.5902439024390244)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPS2CustomPainter(),
        ),
        child
      ],
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.00004523756, 0);
    path_0.lineTo(size.width, 0);
    path_0.cubicTo(
        size.width * 0.9987829,
        size.height * 0.2173913,
        size.width * 0.8914805,
        size.height * 0.5267559,
        size.width * 0.4719951,
        size.height * 0.5267559);
    path_0.cubicTo(
        size.width * 0.1240027,
        size.height * 0.5267559,
        size.width * 0.01652556,
        size.height * 0.8524381,
        size.width * -0.00004523488,
        size.height * 0.9634482);
    path_0.lineTo(size.width * -0.00004523488, size.height);
    path_0.cubicTo(
        size.width * -0.003017098,
        size.height,
        size.width * -0.003449488,
        size.height * 0.9862542,
        size.width * -0.00004523488,
        size.height * 0.9634482);
    path_0.lineTo(size.width * -0.00004523756, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff256DFF).withOpacity(0.1);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPS2CustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.002066116);
    path_0.lineTo(size.width * -0.00004525537, size.height * 0.002066116);
    path_0.lineTo(size.width * -0.00004525537, size.height);
    path_0.cubicTo(
        size.width * -0.00004525537,
        size.height * 0.9421488,
        size.width * 0.05251195,
        size.height * 0.6053719,
        size.width * 0.4719951,
        size.height * 0.6053719);
    path_0.cubicTo(size.width * 0.8914805, size.height * 0.6053719, size.width,
        size.height * 0.2706612, size.width, size.height * 0.002066116);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff50AFFF).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
