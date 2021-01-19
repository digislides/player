import 'dart:html';
import 'dart:async';

import 'package:player/ui/view.dart';
import 'package:service_worker/worker.dart';

import 'package:common/models.dart';

Future<void> cacheProgramUrls(String id, ProgramDesign program) async {
  final urls = <String, bool>{};

  program.collectUrls(urls);

  for (String url in urls.keys) {
    final newUrl = processForeignUrl(url);
    if (newUrl == url) continue;
    urls[newUrl] = null;
  }

  Cache cache = await caches.open(id);
  final keys = await cache.keys();

  for (Request r in keys) {
    if (!urls.containsKey(r.url)) {
      print("Deleting from cache: " + r.url);
      await cache.delete(r);
    } else {
      print("Already in cache: " + r.url);
      urls[r.url] = true;
    }
  }

  for (String url in urls.keys) {
    if (urls[url]) continue;

    try {
      print("Caching: " + url);
      await cache.add(url);
      urls[url] = true;
    } catch (e) {
      print("Caching failed: " + e?.toString());
    }
  }
}
