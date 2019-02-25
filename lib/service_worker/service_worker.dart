import 'dart:async';
import 'package:service_worker/worker.dart';

void main() {
  onFetch.listen((FetchEvent event) {
    event.respondWith(_getCachedOrFetch(event.request));
  });
}

Future<Response> _getCachedOrFetch(Request request) async {
  final Response r = await caches.match(request);
  if (r != null) return r;
  return fetch(request);
}
