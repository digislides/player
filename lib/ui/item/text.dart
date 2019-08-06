import 'dart:convert';
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
    final span = DivElement();
    final lines = LineSplitter.split(item.linkedText).toList();
    for (int i = 0; i < lines.length; i++) {
      span.children.add(SpanElement()..text = lines[i]);
      if (i < lines.length - 1) span.children.add(BRElement());
    }

    final holder = DivElement()..classes.add('holder');
    holder.style.alignItems = item.font.valign.css;
    holder.children.add(span);

    root.classes
        .addAll(['page-item', 'page-item-text', 'page-item-${item.id}']);

    root.children.add(holder);

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
