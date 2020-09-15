import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_editor/models/node_editor_model.dart';

class NodeEditorPainter extends CustomPainter {
  final NodeEditorModel model;

  NodeEditorPainter(this.model);

  static Paint painter = Paint()
    ..color = Colors.greenAccent
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    for (var edge in model.edges.values) {
      Path path = Path()
        ..moveTo(edge.startOffset.dx, edge.startOffset.dy)
        ..cubicTo(
            edge.startOffset.dx +
                0.6 * (edge.endOffset.dx - edge.startOffset.dx),
            edge.startOffset.dy,
            edge.endOffset.dx + 0.6 * (edge.startOffset.dx - edge.endOffset.dx),
            edge.endOffset.dy,
            edge.endOffset.dx,
            edge.endOffset.dy);
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
