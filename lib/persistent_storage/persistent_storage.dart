import 'dart:html';
import 'dart:indexed_db' as idb;

import 'package:common/models.dart';
import 'package:common/serializer/serializer.dart';

class ContentStorage {
  /// The database
  idb.Database _db;

  ContentStorage._(this._db);

  static Future<ContentStorage> connect() async {
    idb.Database db = await window.indexedDB.open(dbName, version: version,
        onUpgradeNeeded: (idb.VersionChangeEvent event) {
      idb.OpenDBRequest req = event.target;
      idb.Transaction t = req.transaction;
      idb.Database db = t.db;
      if (!db.objectStoreNames.contains(storeName)) {
        db.createObjectStore(storeName, keyPath: 'id');
      }
    });
    return ContentStorage._(db);
  }

  /// Save [content] by [channelId]
  Future<void> saveContent(String channelId, PublishedProgram content) async {
    Map map = PublishedProgramSerializer().toMap(content);

    idb.ObjectStore store =
        _db.transaction(storeName, 'readwrite').objectStore(storeName);

    return store.put({
      'content': map,
      'id': channelId,
    });
  }

  /// Get content by [channelId]
  Future<PublishedProgram> getContentById(String channelId) async {
    idb.ObjectStore store =
        _db.transaction(storeName, 'readwrite').objectStore(storeName);

    Map map = await store.getObject(channelId);
    if (map == null || map is! Map) return null;

    return PublishedProgramSerializer().fromMap(map['content']);
  }

  /// Delete content by [channelId]
  Future<void> deleteContent(String channelId) async {
    idb.ObjectStore store =
        _db.transaction(storeName, 'readwrite').objectStore(storeName);
    return store.delete(channelId);
  }

  /// Name of the database
  static const String dbName = "player";

  /// Name of the object store
  static const storeName = "content";

  /// Version of the database
  static const int version = 1;
}
