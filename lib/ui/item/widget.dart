import 'dart:html';

import 'package:common/models.dart';
import '../view.dart';

class WidgetItemView implements PageItemView {
  final WidgetItem item;

  final root = DivElement();

  WidgetItemView(this.item) {
    _build();
  }

  void _build() {
    root.classes
        .addAll(['page-item', 'page-item-widget', 'page-item-${item.id}']);

    root.style.width = '${item.width}px';
    root.style.height = '${item.height}px';

    root.style.left = '${item.left}px';
    root.style.top = '${item.top}px';

    final iframe = IFrameElement()..setAttribute('scrolling', 'no');
    if(item.isUrl) {
      iframe.src = item.url;
    } else {
      iframe.srcdoc = item.asSrcDoc;
    }

    root.children.add(iframe);
  }

  @override
  void play() {}

  @override
  void stop() {}
}
