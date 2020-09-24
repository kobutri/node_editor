import 'package:flutter/cupertino.dart';
import 'package:node_editor/models/node_editor_model.dart';
import 'package:node_editor/models/node_model.dart';
import 'package:node_editor/widgets/node_widget.dart';
import 'package:provider/provider.dart';

import '../util.dart';

class NodeControl extends StatefulWidget {
  NodeControl({Key key, @required this.nodeModel}) : super(key: key);

  final NodeModel nodeModel;

  @override
  _NodeControlState createState() => _NodeControlState();
}

class _NodeControlState extends State<NodeControl> {
  NodeModel dragModel;

  @override
  void initState() {
    super.initState();
    NodeEditorModel model = Provider.of(context, listen: false);
    dragModel = NodeModel(
        key: GlobalKey(),
        type: NodeType.Shadow,
        data: null,
        painterKey: model.painterKey);
    model.nodes.add(dragModel);
  }

  @override
  void dispose() {
    NodeEditorModel model = Provider.of(context, listen: false);
    model.nodes.remove(dragModel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(
      builder: (context, model, _) {
        return DragTarget<NodeModel>(
          onWillAccept: (data) {
            return !model.nodes.hasLink(widget.nodeModel, data) &&
                data.type != widget.nodeModel.type &&
                data.data.runtimeType == widget.nodeModel.data.runtimeType;
          },
          onAccept: (data) {
            if (widget.nodeModel.type == NodeType.Sink) {
              for (var node in model.nodes.links(widget.nodeModel)) {
                model.nodes.unLink(node, widget.nodeModel);
              }
            }
            model.nodes.unLink(
                data,
                model.nodes
                    .links(data)
                    .firstWhere((element) => element.type == NodeType.Shadow));
            model.nodes.link(data, widget.nodeModel);
            model.update();
          },
          onMove: (details) {
            model.updateNodes();
            model.update();
          },
          builder: (context, candidateData, rejectedData) {
            return Draggable(
              data: widget.nodeModel,
              child: Node(
                type: widget.nodeModel.type,
                key: widget.nodeModel.key,
              ),
              feedback: Transform.scale(
                scale: model.transformationController.value.getMaxScaleOnAxis(),
                child: Node(
                  type: widget.nodeModel.type,
                  key: dragModel.key,
                ),
              ),
              childWhenDragging: Node(
                type: widget.nodeModel.type,
                //key: widget.nodeModel.key,
              ),
              onDragStarted: () {
                if (widget.nodeModel.type == NodeType.Sink) {
                  for (var node in model.nodes.links(widget.nodeModel)) {
                    if (model.nodes.unLink(node, widget.nodeModel)) {}
                  }
                }
                model.nodes.link(widget.nodeModel, dragModel);
                model.update();
              },
              onDraggableCanceled: (vel, pos) {
                model.nodes.unLink(widget.nodeModel, dragModel);
              },
            );
          },
        );
      },
    );
  }
}
