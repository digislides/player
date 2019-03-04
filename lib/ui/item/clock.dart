import 'dart:html';

import 'package:common/models.dart';
import '../view.dart';
import 'package:wclient/utils/components/clock.dart';

class ClockItemView implements PageItemView {
  final ClockItem item;

  final root = DivElement();

  final _clockComp = ClockComponent();

  ClockItemView(this.item) {
    _build();
  }

  void _build() {
    // TODO background

    root
      ..classes.addAll(['page-item', 'page-item-clock', 'page-item-${item.id}'])
      ..children.add(_clockComp.root);

    root.style.width = '${item.width}px';
    root.style.height = '${item.height}px';

    root.style.left = '${item.left}px';
    root.style.top = '${item.top}px';
  }

  @override
  void play() {

  }

  @override
  void stop() {

  }
}

/*
class AnalogClock1 extends Item {
  AnalogClock1View _root;

  AnalogClock1(Map a_map) {
    _fromMap(a_map);
  }

  void _fromMap(Map a_map) {
    super._init(a_map);
    Map l_bindingmap = a_map["Binding"];
    if (l_bindingmap is Map) {
      notifier = getNotifierByIndex(l_bindingmap["Type"], l_bindingmap["Param"]);

      String b_path = l_bindingmap["Path"];
      if(b_path is String && b_path.isNotEmpty) {
        path = getPathList(b_path);
      }

      endpoint = l_bindingmap["Endpoint"];
    }

    if (a_map["Color"] is String) {
      color = a_map["Color"];
    }

    if (a_map["FontColor"] is String) {
      fontcolor = a_map["FontColor"];
    }
  }

  void _updateField(_) {
    if(_root != null) {
      NowNotifier b_not = notifier.getById(path, endpoint);
      _root.hour = b_not.hour;
      _root.minute = b_not.minute;
      _root.second = b_not.second;
    }
  }

  HtmlElement prepare() {
    _dispose();

    _root = new Element.tag("analogclock1-view");
    _root.classes.add("pt-element");

    _root.style.left = "${left}px";
    _root.style.top = "${top}px";

    _root.style.width = "${width}px";
    _root.style.height = "${height}px";

    _root.backgroundColor = color;
    _root.fontColor = fontcolor;

    if(notifier != null) {
      _notificationSub = notifier.onUpdate.listen(_updateField);
      _updateField(null);
    }

    return _root;
  }

  void start() {

  }

  void stop() {
    _dispose();
  }

  void _dispose() {
    if (_root != null) {
      _root.remove();
      _root = null;
    }

    if(_notificationSub != null) {
      _notificationSub.cancel();
      _notificationSub = null;
    }
  }

  Notifier notifier;
  StreamSubscription _notificationSub;

  List<int> path = new List();
  int endpoint;

  String color = "";

  String fontcolor = "";
}
 */
