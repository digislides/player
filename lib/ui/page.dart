import 'dart:html';
import 'item/item.dart';

import 'package:common/models.dart';
import 'view.dart';

class PageView implements View {
  final Page page;

  PageView(this.page);

  final _children = <View>[];

  DivElement build() {
    final root = DivElement()..classes.addAll(['page', 'page-${page.id}']);

    root.style.width = '${page.width}px';
    root.style.height = '${page.height}px';

    root.style.left = '0px';
    root.style.top = '0px';

    root.style.backgroundColor = page.color;
    root.style.backgroundImage = page.imageUrl;
    root.style.backgroundRepeat = page.fit.repeatCss;
    root.style.backgroundSize = page.fit.sizeCss;

    for (final item in page.items) {
      final child = makeItemView(item);
      _children.add(child);
      root.children.add(child.build());
    }

    return root;
  }
}
