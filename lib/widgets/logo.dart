import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/images/logo.png",
              width: 90,
              height: 90,
            ),
            const Row(
              children: [
                Text(
                  "Public",
                  style: TextStyle(
                    color: Color(0xff006EF1),
                    fontFamily: "PilatExtended-Regular",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  " Chat",
                  style: TextStyle(
                    color: Color(0xffFEA92E),
                    fontFamily: "PilatExtended-Regular",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
