import 'package:flutter/foundation.dart';
import 'package:flutter_covid19_rest_api/app/services/api_keys.dart';

class API {
  API({@required this.apiKey});

  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.nCovSandboxKey);

  static final String host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(
        host: host,
        scheme: 'https',
        path: 'token',
      );
}
