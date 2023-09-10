import 'dart:math';

import 'package:flutter/material.dart';

class CustomPieChart extends StatefulWidget {
  final double value;
  final Color backColor;
  final Color valueColor;
  final EdgeInsets margin;
  final double height;
  final double width;
  final double lineWidth;
  final bool animation;
  final String? text;
  final IconData? icon;
  final Color childColor;

  CustomPieChart({
    this.value = 0,
    this.backColor = Colors.grey,
    this.valueColor = Colors.blue,
    this.margin = EdgeInsets.zero,
    required this.height,
    required this.width,
    this.lineWidth = 10,
    this.animation = true,
    this.text,
    this.icon,
    this.childColor = Colors.black,
  });

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation animation;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    ));

    if (widget.animation) {
      animationController.reset();
      animationController.forward();
    } else {
      animationController.value = 1.0;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: widget.margin,
      child: Center(
        child: Column(
          children: <Widget>[
            AnimatedBuilder(
              animation: animation,
              builder: (context, _) {
                return CustomPaint(
                  size: Size(widget.width, widget.height),
                  painter: PieChart(
                    percentage: widget.value,
                    textScaleFactor: 1.0,
                    backColor: widget.backColor,
                    valueColor: widget.valueColor,
                    lineWidth: widget.lineWidth,
                    animationValue: animation.value,
                    text: widget.text,
                    icon: widget.icon,
                    childColor: widget.childColor,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class PieChart extends CustomPainter {
  double percentage;
  double textScaleFactor;
  Color backColor;
  Color valueColor;
  double lineWidth;
  double animationValue;
  String? text;
  IconData? icon;
  Color childColor;

  PieChart({
    this.percentage = 0,
    this.textScaleFactor = 1.0,
    required this.backColor,
    required this.valueColor,
    required this.lineWidth,
    required this.animationValue,
    required this.childColor,
    this.text,
    this.icon,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint() // 화면에 그릴 때 쓸 Paint를 정의합니다.
      ..color = backColor
      ..strokeWidth = lineWidth // 선의 길이를 정합니다.
      ..style =
          PaintingStyle.stroke // 선의 스타일을 정합니다. stroke면 외곽선만 그리고, fill이면 다 채웁니다.
      ..strokeCap =
          StrokeCap.round; // stroke의 스타일을 정합니다. round를 고르면 stroke의 끝이 둥글게 됩니다.

    double radius = min(
        size.width / 2 - paint.strokeWidth / 2,
        size.height / 2 -
            paint.strokeWidth / 2); // 원의 반지름을 구함. 선의 굵기에 영향을 받지 않게 보정함.
    Offset center =
        Offset(size.width / 2, size.height / 2); // 원이 위젯의 가운데에 그려지게 좌표를 정함.

    canvas.drawCircle(center, radius, paint); // 원을 그림.

    double arcAngle = 2 *
        pi *
        ((percentage * animationValue) /
            100); // 호(arc)의 각도를 정함. 정해진 각도만큼만 그리도록 함.

    paint.color = valueColor; // 호를 그릴 때는 색을 바꿔줌.
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      paint,
    ); // 호(arc)를 그림.

    if (text != null) drawText(canvas, size, text!); // 텍스트를 화면에 표시함.
    if (icon != null) drawIcon(canvas, size, icon!);
  }

  // 원의 중앙에 아이콘을 배치
  void drawIcon(Canvas canvas, Size size, IconData icon) {
    double iconSize = getIconSize(size);
    TextPainter tp = TextPainter(textDirection: TextDirection.rtl);

    tp.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
            fontSize: iconSize,
            fontFamily: icon.fontFamily,
            color: childColor));

    tp.layout();
    double dx = size.width / 2 - tp.width / 2;
    double dy = size.height / 2 - tp.height / 2;

    tp.paint(canvas, Offset(dx, dy));
  }

  // 원의 중앙에 텍스트를 적음.
  void drawText(Canvas canvas, Size size, String text) {
    double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(
        style: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: childColor),
        text: text); // TextSpan은 Text위젯과 거의 동일하다.
    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

    tp.layout(); // 필수! 텍스트 페인터에 그려질 텍스트의 크기와 방향를 정함.
    double dx = size.width / 2 - tp.width / 2;
    double dy = size.height / 2 - tp.height / 2;

    Offset offset = Offset(dx, dy);
    tp.paint(canvas, offset);
  }

  // 화면 크기에 비례하도록 텍스트 폰트 크기를 정함.
  double getFontSize(Size size, String text) {
    return size.width / text.length * textScaleFactor;
  }

  double getIconSize(Size size) {
    return size.width / 3;
  }

  @override
  bool shouldRepaint(PieChart old) {
    if (old.animationValue != animationValue) return true;

    return old.percentage != percentage;
  }
}
