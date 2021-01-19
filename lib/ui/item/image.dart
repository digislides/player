import 'dart:html';

import 'package:common/models.dart';
import '../view.dart';

class ImageItemView implements PageItemView {
  final ImageItem item;

  final bool isPreview;

  final root = DivElement();

  ImageItemView(this.item, {this.isPreview = true}) {
    _build();
  }

  void _build() {
    root.classes
        .addAll(['page-item', 'page-item-text', 'page-item-${item.id}']);

    root.style.width = '${item.width}px';
    root.style.height = '${item.height}px';

    root.style.left = '${item.left}px';
    root.style.top = '${item.top}px';

    root.style.backgroundColor = item.color;
    root.style.backgroundImage =
        isPreview ? item.imageUrl : processForeignUrl(item.imageUrl);
    root.style.backgroundRepeat = item.fit.repeatCss;
    root.style.backgroundSize = item.fit.sizeCss;
  }

  @override
  void play() {}

  @override
  void stop() {}
}
