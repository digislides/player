import 'package:common/models.dart';
import 'package:player/ui/item/scroller.dart';
import 'package:player/ui/item/widget.dart';
import '../view.dart';

import 'clock.dart';
import 'image.dart';
import 'text.dart';
import 'video.dart';
import 'weather.dart';

export 'clock.dart';
export 'image.dart';
export 'text.dart';
export 'video.dart';
export 'weather.dart';

View makeItemView(PageItem item, {bool isPreview = true}) {
  if (item.type == PageItemType.text) {
    return TextItemView(item);
  } else if (item.type == PageItemType.image) {
    return ImageItemView(item, isPreview: isPreview);
  } else if (item.type == PageItemType.video) {
    return VideoItemView(item);
  } else if (item.type == PageItemType.clock) {
    return ClockItemView(item);
  } else if (item.type == PageItemType.weather) {
    return WeatherItemView(item);
  } else if(item.type == PageItemType.widget) {
    return WidgetItemView(item);
  } else if(item.type == PageItemType.scroller) {
    return ScrollerItemView(item);
  }
  throw Exception("Invalid item!");
}
