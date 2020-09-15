import 'package:flutter/cupertino.dart';

import 'edge_model.dart';
import 'node_model.dart';

class NodeEditorModel extends ChangeNotifier {
  NodeEditorModel() {
    sources = [NodeModel(GlobalKey()), NodeModel(GlobalKey())];
    targets = [NodeModel(GlobalKey())];
    //_edges = [EdgeModel(_nodes[0], _nodes[1])];
    edges = Map();
  }

  Map<GlobalKey, EdgeModel> _edges;

  Map<GlobalKey, EdgeModel> get edges => _edges;

  set edges(Map<GlobalKey, EdgeModel> edges) {
    _edges = edges;
    notifyListeners();
  }

  void updateEdges() {
    for (var edge in edges.values) {
      edge.update();
    }
    //notifyListeners();
  }

  List<NodeModel> _sources;

  List<NodeModel> get sources => _sources;

  set sources(List<NodeModel> sources) {
    _sources = sources;
    notifyListeners();
  }

  List<NodeModel> _targets;

  List<NodeModel> get targets => _targets;

  set targets(List<NodeModel> targets) {
    _targets = targets;
    notifyListeners();
  }

  void updateNodes() {
    for (var node in sources) {
      node.update(painterKey);
    }
    for (var node in targets) {
      node.update(painterKey);
    }
    //notifyListeners();
  }

  final GlobalKey painterKey = GlobalKey();
  final TransformationController transformationController =
      TransformationController();

  void update() {
    notifyListeners();
  }
}
