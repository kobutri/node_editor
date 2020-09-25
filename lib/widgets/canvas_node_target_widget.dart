import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_editor/models/node_editor_model.dart';
import 'package:node_editor/models/node_model.dart';
import 'package:node_editor/widgets/element_stack_widget.dart';
import 'package:provider/provider.dart';

class CanvasNodeTarget extends StatelessWidget {
  const CanvasNodeTarget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(
      builder: (context, model, _) {
        return DragTarget<NodeModel>(
          builder: (context, candidates, rejects) {
            return SizedBox.expand(
              child: ElementStack(),
            );
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
