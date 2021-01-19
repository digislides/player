import 'dart:async';
import 'package:service_worker/worker.dart';
import 'package:http/http.dart' as http;

void install() {
  Timer.periodic(Duration(seconds: 2), (_) {
    print("here");
  });

  onInstall.listen((InstallEvent event) async {
    Cache cache = await caches.open('play');
    await cache.add('/player/channel/play/index.html');
    await cache.add('/player/channel/play/main.dart.js');
    print("Service worker installed!");
  });

  onFetch.listen((FetchEvent event) {
    print(event.request.url);
    event.respondWith(_getCachedOrFetch(event.request));
  });
}

Future<Response> _getCachedOrFetch(Request request) async {
  final Response r = await caches.match(request);
  if (r != null) {
    print("Found: ${r.url}");
    return r;
  }
  print("Not found: ${r.url}");
  final uri = Uri.tryParse(r.url);
  if (uri != null && uri.path == '/external/media') {
    print("External media: ${uri.queryParameters['url']}");
    return Response.redirect(uri.queryParameters['url'], 301);
  }
  return fetch(request);
}
