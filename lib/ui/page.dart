import 'dart:html';
import 'item/item.dart';

import 'package:common/models.dart';

class PageView {
  final Page page;

  PageView(this.page);

  DivElement build(Page page) {
    final root = DivElement()..classes.addAll(['page', 'page-${page.id}']);

    root.style.width = '${page.width}px';
    root.style.height = '${page.height}px';

    root.style.left = '0px';
    root.style.top = '0px';

    root.style.color = page.color;
    root.style.backgroundImage = page.imageUrl;
    root.style.backgroundRepeat = page.fit.repeatCss;
    root.style.backgroundSize = page.fit.sizeCss;

    for (final item in page.items) {
      // TODO
    }

    return root;
  }
}
