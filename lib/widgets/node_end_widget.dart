import 'package:flutter/cupertino.dart';
import 'package:node_editor/models/edge_model.dart';
import 'package:node_editor/models/node_editor_model.dart';
import 'package:node_editor/models/node_model.dart';
import 'package:node_editor/widgets/node_widget.dart';
import 'package:provider/provider.dart';

class NodeEnd extends StatefulWidget {
  const NodeEnd({Key key, this.node}) : super(key: key);

  final NodeModel node;

  @override
  _NodeEndState createState() => _NodeEndState();
}

class _NodeEndState extends State<NodeEnd> with WidgetsBindingObserver {
  EdgeModel edge;

  @override
  Widget build(BuildContext context) {
    if (edge != null && !edge.destroyed) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        NodeEditorModel model = Provider.of(context, listen: false);
        widget.node.update(model.painterKey);
        edge.update();
      });
    }
    return Consumer<NodeEditorModel>(
      builder: (context, model, _) => GestureDetector(
        onSecondaryTap: () {
          model.edges.remove(this.edge.start.key);
          model.update();
        },
        child: DragTarget<NodeModel>(
          onWillAccept: (details) {
            return edge == null || edge.destroyed || edge.start != details;
          },
          onAccept: (data) {
            if (this.edge != null && this.edge.end != null) {
              model.edges.remove(this.edge.start.key);
            }
            EdgeModel edge = model.edges[data.key];
            edge.end = widget.node;
            edge.update();
            this.edge = edge;
            model.update();
          },
          builder: (context, candidates, rejects) => Node(
            key: widget.node.key,
          ),
          onMove: (details) {
            NodeModel node = details.data;
            RenderBox box = model.painterKey.currentContext.findRenderObject();
            Offset pos = box.globalToLocal(details.offset +
                Offset(node.size.width / 2, node.size.height / 2));
            model.edges[node.key].endOffset = pos;
            model.update();
          },
        ),
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
