import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_editor/models/element_model.dart';
import 'package:node_editor/models/node_editor_model.dart';
import 'package:positioned_tap_detector/positioned_tap_detector.dart';
import 'package:provider/provider.dart';

import 'canvas_element_target_canvas.dart';
import 'canvas_node_target_widget.dart';
import 'element_stack_widget.dart';
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
        Matrix4 inverseTransform =
            Matrix4.inverted(model.transformationController.value);
        return Stack(
          children: [
            PositionedTapDetector(
              onTap: (position) {
                ElementModel element = ElementModel(key: GlobalKey());
                element.offset =
                    model.transformationController.toScene(position.relative);
                model.elements.add(element);
                model.update();
              },
              child: SizedBox.expand(
                child: InteractiveViewer(
                  transformationController: model.transformationController,
                  boundaryMargin: EdgeInsets.all(double.infinity),
                  minScale: 0.1,
                  maxScale: 10.0,
                  child: Stack(
                    children: [
                      Transform(
                        transform: inverseTransform,
                        child: CanvasNodeTarget(),
                      ),
                      Transform(
                        transform: inverseTransform,
                        child: CanvasElementTarget(),
                      ),
                      IgnorePointer(
                        child: CustomPaint(
                          key: model.painterKey,
                          child: SizedBox.expand(),
                          painter: NodeEditorPainter(model),
                          willChange: true,
                        ),
                      ),
                      ElementStack(),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    setState(() {});
  }
}
