import 'dart:html';

import 'package:common/models.dart';
import '../view.dart';

class TextItemView implements PageItemView {
  final TextItem item;

  final root = DivElement();

  TextItemView(this.item) {
    _build();
  }

  void _build() {
    root.classes
        .addAll(['page-item', 'page-item-text', 'page-item-${item.id}']);
    root.text = item.text;

    root.style.width = '${item.width}px';
    root.style.height = '${item.height}px';

    root.style.left = '${item.left}px';
    root.style.top = '${item.top}px';

    root.style.backgroundColor = item.color;

    root.style.fontSize = '${item.font.size}px';
    root.style.color = item.font.color;
    root.style.textAlign = item.font.align.toString();
    root.style.fontWeight = item.font.bold ? 'bold' : 'normal';
    root.style.textDecoration = item.font.underline ? 'underline' : 'none';
    root.style.fontStyle = item.font.italic ? 'italic' : 'normal';
  }

  @override
  void play() {}

  @override
  void stop() {}
}
