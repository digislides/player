import 'dart:html';

import 'package:common/models.dart';
import '../view.dart';

class ImageItemView implements View {
  final ImageItem item;

  ImageItemView(this.item);

  DivElement build() {
    final root = DivElement()
      ..classes.addAll(['page-item', 'page-item-text', 'page-item-${item.id}']);

    root.style.width = '${item.width}px';
    root.style.height = '${item.height}px';

    root.style.left = '${item.left}px';
    root.style.top = '${item.top}px';

    root.style.backgroundColor = item.color;
    root.style.backgroundImage = item.imageUrl;
    root.style.backgroundRepeat = item.fit.repeatCss;
    root.style.backgroundSize = item.fit.sizeCss;

    return root;
  }
}
