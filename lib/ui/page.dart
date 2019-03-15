import 'dart:html';
import 'item/item.dart';
import 'dart:async';

import 'package:common/models.dart';
import 'view.dart';

class PageView implements View {
  final Page page;

  final Transition defaultTransition;

  final root = DivElement();

  PageView(this.page, this.defaultTransition) {
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

  Transition get transition {
    if (page.transition != Transition.none) return page.transition;
    return defaultTransition;
  }

  void play() {
    root.classes.add('show');
    root.classes.addAll(['new', 'transition-${transition.css}']);
    for (PageItemView view in _children) {
      view.play();
    }
  }

  Future<void> stop({Transition exitTransition}) async {
    root.classes.removeAll(<String>['new', 'transition-${transition.css}']);
    root.classes.add('old');
    root.classes.add('transition-${exitTransition.css}');
    for (PageItemView view in _children) {
      view.stop();
    }
    await Future.delayed(Duration(seconds: 2));
    root.remove();
  }
}
