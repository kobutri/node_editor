import 'package:flutter/cupertino.dart';
import 'package:node_editor/models/element_model.dart';
import 'package:node_editor/models/node_editor_model.dart';
import 'package:provider/provider.dart';

class CanvasElementTarget extends StatelessWidget {
  const CanvasElementTarget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(
      builder: (context, model, _) {
        return DragTarget<ElementModel>(
          builder: (context, candidates, rejects) {
            return SizedBox.expand();
          },
          onWillAccept: (data) {
            return true;
          },
          onAccept: (data) {
            RenderBox canvasBox = context.findRenderObject();
            RenderBox elementBox = data.key.currentContext.findRenderObject();
            Offset off = model.transformationController.toScene(
              canvasBox.globalToLocal(
                elementBox.localToGlobal(Offset.zero),
              ),
            );
            data.offset = off;
            model.updateNodes();
            model.update();
          },
          onMove: (_) {
            model.updateNodes();
            model.update();
          },
        );
      },
    );
  }
}
