import 'package:flutter/material.dart';

class button extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback onPressed;

  const button(
      {super.key,
      required this.child,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
          onPressed: onPressed,
          child: child,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(color),
              padding: MaterialStateProperty.all(EdgeInsets.all(10)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              )))),
    );
  }
}

class button2 extends StatelessWidget {
  final Widget child;
  final color;
  final VoidCallback onPressed;
  const button2(
      {super.key,
      required this.child,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              maximumSize: Size(400, 70),
              minimumSize: Size(400, 70),
              backgroundColor: Color.fromARGB(255, 223, 236, 220),
            ),
            onPressed: () {},
            child: Stack(children: <Widget>[
              // Stroked text as border.
              Text(
                '',
                style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.blue[700]!,
                ),
              ),
              // Solid text as fill.
              Text(
                '',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.grey[300],
                ),
              )
            ])),
      ],
    ));
  }
}
