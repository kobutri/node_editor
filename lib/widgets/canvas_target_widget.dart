import 'package:flutter/cupertino.dart';
import 'package:node_editor/models/node_editor_model.dart';
import 'package:node_editor/models/node_model.dart';
import 'package:provider/provider.dart';

class CanvasTarget extends StatefulWidget {
  CanvasTarget({Key key}) : super(key: key);

  @override
  _CanvasTargetState createState() => _CanvasTargetState();
}

class _CanvasTargetState extends State<CanvasTarget> {
  @override
  Widget build(BuildContext context) {
    //print("build canvas target");
    return Consumer<NodeEditorModel>(
      builder: (context, model, _) {
        return DragTarget<NodeModel>(
          builder: (context, candidates, rejects) {
            return SizedBox.expand();
          },
          onWillAccept: (_) => false,
          onMove: (details) {
            model.updateNodes();
            model.update();
          },
        );
      },
    );
  }
}
