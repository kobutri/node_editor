import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_editor/models/element_model.dart';
import 'package:node_editor/models/node_editor_model.dart';
import 'package:provider/provider.dart';
import 'element_widget.dart' as el;

class ElementControl extends StatefulWidget {
  ElementControl({Key key, @required this.elementModel}) : super(key: key);

  final ElementModel elementModel;

  @override
  _ElementControlState createState() => _ElementControlState();
}

class _ElementControlState extends State<ElementControl> {
  el.Element element;

  @override
  void initState() {
    super.initState();
    element = el.Element(
      key: widget.elementModel.key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(
      builder: (context, model, _) {
        return GestureDetector(
          onSecondaryTap: () {
            model.elements.remove(widget.elementModel);
            model.update();
          },
          child: Draggable(
            data: widget.elementModel,
            child: element,
            childWhenDragging: Container(),
            feedback: ChangeNotifierProvider<NodeEditorModel>.value(
              value: model,
              builder: (context, child) {
                return Transform.scale(
                  scale:
                      model.transformationController.value.getMaxScaleOnAxis(),
                  child: element,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
