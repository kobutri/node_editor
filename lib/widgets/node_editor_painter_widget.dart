import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_editor/models/node_editor_model.dart';

import '../util.dart';

class NodeEditorPainter extends CustomPainter {
  final NodeEditorModel model;

  NodeEditorPainter(this.model);

  static Paint painter = Paint()
    ..color = Colors.greenAccent
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    for (var edge in edges(model.nodes)) {
      Offset start = edge.key.offset +
          Offset(edge.key.size.width / 2, edge.key.size.height / 2);
      Offset end = edge.value.offset +
          Offset(edge.value.size.width / 2, edge.value.size.height / 2);
      Path path = Path()
        ..moveTo(start.dx, start.dy)
        ..cubicTo(start.dx + 0.6 * (end.dx - start.dx), start.dy,
            end.dx + 0.6 * (start.dx - end.dx), end.dy, end.dx, end.dy);
      canvas.drawPath(path, painter);
    }
  }

  @override
  bool shouldRepaint(NodeEditorPainter oldDelegate) {
    return true;
  }

  @override
  bool shouldRebuildSemantics(NodeEditorPainter oldDelegate) => false;
}
