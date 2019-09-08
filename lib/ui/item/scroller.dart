import 'dart:html';

import 'package:common/models.dart';
import '../view.dart';

class ScrollerItemView implements PageItemView {
  final ScrollerItem item;

  final root = DivElement();

  ScrollerItemView(this.item) {
    _build();
  }

  void _build() {
    final holder = DivElement()..classes.add('holder');

    for (int i = 0; i < item.lines.length; i++) {
      holder.nodes.add(SpanElement()
        ..text = item.lines[i]
        ..style.marginRight = '${item.gap}px');
      if (item.separator != null && item.separator.isNotEmpty) {
        if (i < item.lines.length - 1) {
          holder.children.add(SpanElement()
            ..text = item.separator
            ..style.marginRight = '${item.gap}px');
        }
      }
    }

    holder.style.animationDuration = '${item.duration}s';

    root.classes
        .addAll(['page-item', 'page-item-scroller', 'page-item-${item.id}']);

    root.children.add(holder);

    root.style.width = '${item.width}px';
    root.style.height = '${item.height}px';

    root.style.left = '${item.left}px';
    root.style.top = '${item.top}px';

    root.style.backgroundColor = item.color;

    root.style.fontSize = '${item.font.size}px';
    root.style.color = item.font.color;
    root.style.fontWeight = item.font.bold ? 'bold' : 'normal';
    root.style.textDecoration = item.font.underline ? 'underline' : 'none';
    root.style.fontStyle = item.font.italic ? 'italic' : 'normal';

    root.style.display = 'flex';
    root.style.alignItems = 'center';
  }

  @override
  void play() {
  }

  @override
  void stop() {}
}
