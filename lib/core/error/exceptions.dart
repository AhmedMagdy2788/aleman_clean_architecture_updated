class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  @override
  String toString() {
    return message;
  }
}

class CacheException implements Exception {}

class DBTableNotFoundException implements Exception {}

class JsonFileNotFoundException implements Exception {}

class NoDataSourceFoundException implements Exception {}

class DBServerEmptyException implements Exception {}

class NoTABLENAMEKeyExcption implements Exception {}

class DBNotCreatedExcption implements Exception {}

class SchemaNotCreatedExcption implements Exception {}
