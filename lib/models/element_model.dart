import 'package:flutter/cupertino.dart';

class ElementModel {
  ElementModel({@required this.key, GlobalKey painterKey}) {
    if (key.currentContext != null) {
      update(painterKey);
    }
  }

  final GlobalKey key;
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
