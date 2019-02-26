import 'dart:async';
import 'package:service_worker/worker.dart';

void install() {
  Timer.periodic(Duration(seconds: 2), (_) {
    print("here");
  });

  onInstall.listen((InstallEvent event) {
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
    print("Not found: ${r.url}");
    return r;
  }
  print("Not found: ${r.url}");
  return fetch(request);
}
