import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:node_editor/models/node_editor_model.dart';
import 'package:provider/provider.dart';

import 'element_control_widget.dart';

class ElementStack extends StatelessWidget {
  const ElementStack({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(
      builder: (context, model, _) {
        return Stack(
          clipBehavior: Clip.none,
          children: model.elements.map(
            (e) {
              return Transform(
                transform: model.transformationController.value *
                    Matrix4.translation(Vector3(e.offset.dx, e.offset.dy, 0)),
                child: ElementControl(elementModel: e),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
