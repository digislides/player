import 'dart:html';
import 'page.dart';

import 'package:common/models.dart';
import 'view.dart';

class FrameView {
  final Frame frame;

  FrameView(this.frame);

  final _children = <View>[];

  DivElement build() {
    final root = DivElement()..classes.addAll(['frame', 'frame-${frame.id}']);

    root.style.left = '${frame.left}px';
    root.style.top = '${frame.top}px';
    root.style.width = '${frame.width}px';
    root.style.height = '${frame.height}px';

    root.style.backgroundColor = frame.color;

    for (final page in frame.pages) {
      final child = PageView(page);
      _children.add(child);
      root.children.add(child.build());
    }

    return root;
  }
}
