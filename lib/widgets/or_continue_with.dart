import 'package:flutter/material.dart';

class OrContinueWith extends StatelessWidget {
  const OrContinueWith({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        //Line
        Expanded(
          child: Divider(
            color: Color(0xff8CAAB9),
          ),
        ),
        //Or continue with
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Or continue with",
            style: TextStyle(
              color: Color(0xff8CAAB9),
              fontSize: 18,
            ),
          ),
        ),
        //Line
        Expanded(
            child: Divider(
          color: Color(0xff8CAAB9),
        )),
        SizedBox(
          height: 10,
        )
      ],
    );
    //Space
  }
}
