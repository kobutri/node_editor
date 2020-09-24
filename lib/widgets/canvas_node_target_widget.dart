import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_editor/models/node_editor_model.dart';
import 'package:node_editor/models/node_model.dart';
import 'package:provider/provider.dart';

class CanvasNodeTarget extends StatefulWidget {
  CanvasNodeTarget({Key key}) : super(key: key);

  @override
  _CanvasNodeTargetState createState() => _CanvasNodeTargetState();
}

class _CanvasNodeTargetState extends State<CanvasNodeTarget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(
      builder: (context, model, _) {
        return DragTarget<NodeModel>(
          builder: (context, candidates, rejects) {
            return SizedBox.expand();
          },
          onWillAccept: (data) => false,
          onMove: (details) {
            model.updateNodes();
            model.update();
          },
        );
      },
    );
  }
}
