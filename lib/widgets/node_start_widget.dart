import 'package:flutter/cupertino.dart';
import 'package:node_editor/models/edge_model.dart';
import 'package:node_editor/models/node_editor_model.dart';
import 'package:node_editor/models/node_model.dart';
import 'package:provider/provider.dart';

import 'node_widget.dart';

class NodeStart extends StatefulWidget {
  const NodeStart({Key key, this.node}) : super(key: key);

  final NodeModel node;

  @override
  _NodeStartState createState() => _NodeStartState();
}

class _NodeStartState extends State<NodeStart> with WidgetsBindingObserver {
  bool dragging = false;

  @override
  Widget build(BuildContext context) {
    if (!dragging) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        NodeEditorModel model = Provider.of(context, listen: false);
        widget.node.update(model.painterKey);
        if (model.edges[widget.node.key] != null) {
          model.edges[widget.node.key].update();
        }
      });
    }
    return Consumer<NodeEditorModel>(
      builder: (context, model, _) => Draggable<NodeModel>(
        data: widget.node,
        child: Node(
          key: widget.node.key,
        ),
        feedback: Transform.scale(
          scale: model.transformationController.value.getMaxScaleOnAxis(),
          child: Node(
            key: widget.node.key,
          ),
        ),
        childWhenDragging: Node(),
        onDragStarted: () {
          dragging = true;
          if (model.edges[widget.node.key] != null) {
            model.edges[widget.node.key].destroyed = true;
            model.edges.remove(widget.node.key);
          }
          model.edges[widget.node.key] = EdgeModel(start: widget.node);
        },
        onDraggableCanceled: (_, __) {
          model.edges.remove(widget.node.key);
          model.update();
        },
        onDragEnd: (details) {
          dragging = false;
        },
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    setState(() {});
  }
}
