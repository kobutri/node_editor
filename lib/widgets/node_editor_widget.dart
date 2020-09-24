import 'package:flutter/cupertino.dart';
import 'package:node_editor/models/node_editor_model.dart';
import 'package:node_editor/models/node_model.dart';
import 'package:node_editor/widgets/node_control_widget.dart';
import 'package:provider/provider.dart';

import 'canvas_target_widget.dart';
import 'node_editor_painter_widget.dart';

class NodeEditor extends StatefulWidget {
  const NodeEditor({Key key}) : super(key: key);

  @override
  _NodeEditorState createState() => _NodeEditorState();
}

class _NodeEditorState extends State<NodeEditor> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      afterLayout(context);
    });

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
                  child: NodeControl(
                    nodeModel: model.nodes.elementAt(0),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(128.0),
                  child: NodeControl(
                    nodeModel: model.nodes.elementAt(1),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(128.0),
                  child: NodeControl(
                    nodeModel: model.nodes.elementAt(2),
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
    NodeEditorModel model =
        Provider.of<NodeEditorModel>(context, listen: false);
    model.nodes.add(NodeModel(
      data: 0,
      key: GlobalKey(),
      type: NodeType.Source,
      painterKey: model.painterKey,
    ));
    model.nodes.add(NodeModel(
      data: 1,
      key: GlobalKey(),
      type: NodeType.Source,
      painterKey: model.painterKey,
    ));
    model.nodes.add(NodeModel(
      data: 2,
      key: GlobalKey(),
      type: NodeType.Sink,
      painterKey: model.painterKey,
    ));
    model.nodes.add(NodeModel(
      data: 3,
      key: GlobalKey(),
      type: NodeType.Sink,
      painterKey: model.painterKey,
    ));
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
    //print("update");
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    setState(() {});
  }
}
