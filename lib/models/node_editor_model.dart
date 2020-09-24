import 'package:flutter/cupertino.dart';
import 'package:graph_collection/graph.dart';
import 'package:node_editor/models/node_model.dart';

class NodeEditorModel extends ChangeNotifier {
  UndirectedGraph nodes = UndirectedGraph();
  final GlobalKey painterKey = GlobalKey();
  final TransformationController transformationController =
      TransformationController();

  void updateNodes() {
    for (var node in nodes) {
      node.update(painterKey);
    }
  }

  void update() {
    notifyListeners();
  }
}
