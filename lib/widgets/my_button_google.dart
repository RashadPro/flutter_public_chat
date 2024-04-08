import 'package:flutter/material.dart';

class MyButtonGoogle extends StatelessWidget {
  const MyButtonGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 367,
      height: 67,
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.white,
        width: 2.0,
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset(
              "assets/images/google.png",
              width: 25,
              height: 25,
            ),
          ),
          const Text(
            "Google",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
