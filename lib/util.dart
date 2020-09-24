import 'package:graph_collection/graph.dart';

import 'models/node_model.dart';

Set<MapEntry<NodeModel, NodeModel>> edges(UndirectedGraph graph) {
  Set<NodeModel> visited = Set();
  Set<MapEntry<NodeModel, NodeModel>> _edges = Set();
  for (var node in graph) {
    for (var node2 in graph.links(node)) {
      if (!visited.contains(node2)) {
        _edges.add(MapEntry(node, node2));
      }
    }
    visited.add(node);
  }
  return _edges;
}
