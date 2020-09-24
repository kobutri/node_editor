import 'package:flutter/cupertino.dart';

class NodeModel<T> {
  NodeModel(
      {@required this.key,
      @required this.type,
      @required this.data,
      GlobalKey painterKey}) {
    if (key.currentContext != null) {
      update(painterKey);
    }
  }

  final GlobalKey key;
  final NodeType type;
  T data;
  Offset offset = Offset.infinite;
  Size size = Size.zero;

  void update(GlobalKey key) {
    if (key.currentContext == null || this.key.currentContext == null) return;
    RenderBox thisBox = this.key.currentContext.findRenderObject();
    RenderBox thatBox = key.currentContext.findRenderObject();
    this.offset = thatBox.globalToLocal(thisBox.localToGlobal(Offset.zero));
    size = thisBox.size;
  }
}

enum NodeType {
  Sink,
  Source,
  Shadow,
}
