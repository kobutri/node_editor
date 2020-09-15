import 'package:flutter/cupertino.dart';

class NodeModel {
  NodeModel(this.key);

  final GlobalKey key;
  Offset offset = Offset.infinite;
  Size size = Size.zero;

  void update(GlobalKey key) {
    // if (this.key.currentContext == null || key.currentContext == null) {
    //   return;
    // }

    RenderBox thisBox = this.key.currentContext.findRenderObject();
    RenderBox thatBox = key.currentContext.findRenderObject();
    this.offset = thatBox.globalToLocal(thisBox.localToGlobal(Offset.zero));
    size = thisBox.size;
  }
}
