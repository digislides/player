import 'dart:html';
import 'item/item.dart';
import 'dart:async';

import 'package:common/models.dart';
import 'view.dart';

class PageView implements View {
  final Page page;

  final root = DivElement();

  PageView(this.page) {
    _build();
  }

  final _children = <PageItemView>[];

  void _build() {
    root.classes.addAll(['page', 'page-${page.id}']);

    root.style.left = '0px';
    root.style.top = '0px';
    root.style.width = '${page.width}px';
    root.style.height = '${page.height}px';

    root.style.backgroundColor = page.color;
    root.style.backgroundImage = page.imageUrl;
    root.style.backgroundRepeat = page.fit.repeatCss;
    root.style.backgroundSize = page.fit.sizeCss;

    for (final item in page.items) {
      final child = makeItemView(item);
      _children.add(child);
      root.children.add(child.root);
    }
  }

  void play() {
    root.classes.add('show');
    /*if(page.transition != 0)*/
    root.classes.addAll(['new', 'transition-${page.transition.css}']);
    for (PageItemView view in _children) {
      view.play();
    }
  }

  Future<void> stop({Transition transition}) async {
    root.classes
        .removeAll(<String>['new', 'transition-${page.transition.css}']);
    root.classes.add('old');
    /* if(transition != 0) */ root.classes.add('transition-${transition.css}');
    for (PageItemView view in _children) {
      view.stop();
    }
    await Future.delayed(Duration(seconds: 2));
    root.remove();
  }
}
