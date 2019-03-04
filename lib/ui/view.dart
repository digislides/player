import 'dart:html';

abstract class View {
  DivElement get root;
}

abstract class PageItemView implements View {
  void play();

  void stop();
}
