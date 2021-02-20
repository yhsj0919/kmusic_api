typedef Handler = Future<dynamic> Function(Map query, String auth);

final handles = <String, Handler>{};
