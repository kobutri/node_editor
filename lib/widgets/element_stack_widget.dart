import 'package:flutter/cupertino.dart';
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
              return Positioned(
                top: e.offset.dy,
                left: e.offset.dx,
                child: ElementControl(elementModel: e),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
