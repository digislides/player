import 'dart:async';
import 'package:service_worker/worker.dart';
import 'package:service_worker/window.dart';

Future<void> cacheUrls(String db, Map<String, bool> urls) async {
  for (String url in urls.keys) {
    urls[url] = false;
  }

  Cache cache = await caches.open(db);
  final keys = await cache.keys();

  for (Request r in keys) {
    if (!urls.containsKey(r.url)) {
      await cache.delete(r);
    } else {
      urls[r.url] = true;
    }
  }

  for (String url in urls.keys) {
    if (urls[url]) continue;

    try {
      await cache.add(url);
      urls[url] = true;
    } catch (e) {
      print(e);
    }
  }
}
