import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Node extends StatelessWidget {
  const Node({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("build node");
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.yellow,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.orange,
          width: 3.0,
        ),
      ),
    );
  }
}
