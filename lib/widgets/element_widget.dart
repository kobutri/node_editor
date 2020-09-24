import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_editor/models/node_editor_model.dart';
import 'package:node_editor/models/node_model.dart';
import 'package:node_editor/widgets/node_control_widget.dart';
import 'package:provider/provider.dart';

class Element extends StatefulWidget {
  Element({Key key}) : super(key: key);

  @override
  _ElementState createState() => _ElementState();
}

class _ElementState extends State<Element> {
  NodeModel input1;
  NodeModel input2;
  NodeModel output;

  @override
  void initState() {
    super.initState();
    NodeEditorModel model = Provider.of(context, listen: false);
    input1 = NodeModel(data: 0, type: NodeType.Sink, key: GlobalKey());
    input2 = NodeModel(data: 0, type: NodeType.Sink, key: GlobalKey());
    output = NodeModel(data: 0, type: NodeType.Source, key: GlobalKey());
    model.nodes.add(input1);
    model.nodes.add(input2);
    model.nodes.add(output);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      color: Colors.amberAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: NodeControl(nodeModel: input1),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: NodeControl(nodeModel: input2),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: NodeControl(nodeModel: output),
            ),
          ],
        ),
      ),
    );
  }
}
