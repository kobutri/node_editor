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
    return DragTarget<NodeModel>(
      builder: (context, candidates, rejects) {
        return SizedBox.expand();
      },
      onWillAccept: (_) => false,
      onMove: (details) {
        NodeModel node = details.data;
        NodeEditorModel model = Provider.of(context, listen: false);
        RenderBox box = model.painterKey.currentContext.findRenderObject();
        Offset pos = box.globalToLocal(
            details.offset + Offset(node.size.width / 2, node.size.height / 2));
        model.edges[node.key].endOffset = pos;
        model.update();
      },
    );
  }
}
