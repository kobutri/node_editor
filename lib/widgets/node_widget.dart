import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_editor/models/node_model.dart';

class Node extends StatelessWidget {
  const Node({Key key, @required this.type}) : super(key: key);

  final NodeType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.yellow,
        shape: BoxShape.circle,
        border: Border.all(
          color: type == NodeType.Source ? Colors.orange : Colors.green,
          width: 3.0,
        ),
      ),
    );
  }
}
