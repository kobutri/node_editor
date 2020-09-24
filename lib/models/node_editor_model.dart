import 'package:flutter/cupertino.dart';
import 'package:graph_collection/graph.dart';
import 'package:node_editor/models/element_model.dart';

class NodeEditorModel extends ChangeNotifier {
  NodeEditorModel() {
    transformationController = TransformationController()
      ..addListener(() {
        update();
      });
  }

  UndirectedGraph nodes = UndirectedGraph();
  final GlobalKey painterKey = GlobalKey();
  TransformationController transformationController;
  List<ElementModel> elements = List();

  void updateNodes() {
    for (var node in nodes) {
      node.update(painterKey);
    }
  }

  void update() {
    notifyListeners();
  }
}
