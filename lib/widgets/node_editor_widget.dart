import 'package:flutter/cupertino.dart';
import 'package:node_editor/models/node_editor_model.dart';
import 'package:provider/provider.dart';

import 'canvas_target_widget.dart';
import 'node_editor_painter_widget.dart';
import 'node_end_widget.dart';
import 'node_start_widget.dart';

class NodeEditor extends StatefulWidget {
  const NodeEditor({Key key}) : super(key: key);

  @override
  _NodeEditorState createState() => _NodeEditorState();
}

class _NodeEditorState extends State<NodeEditor> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(
      builder: (context, model, _) {
        return InteractiveViewer(
          transformationController: model.transformationController,
          boundaryMargin: EdgeInsets.all(double.infinity),
          minScale: 0.1,
          maxScale: 10.0,
          child: Stack(
            children: [
              CustomPaint(
                key: model.painterKey,
                child: SizedBox.expand(),
                painter: NodeEditorPainter(model),
                willChange: true,
              ),
              CanvasTarget(),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(128.0),
                  child: NodeStart(
                    node: model.sources[0],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(128.0),
                  child: NodeStart(
                    node: model.sources[1],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(128.0),
                  child: NodeEnd(
                    node: model.targets[0],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      afterLayout(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void afterLayout(BuildContext context) {
    NodeEditorModel model =
        Provider.of<NodeEditorModel>(context, listen: false);
    model.updateNodes();
    model.updateEdges();
    model.update();
    //print("update");
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    setState(() {});
  }
}
