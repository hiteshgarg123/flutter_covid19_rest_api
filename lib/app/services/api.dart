import 'package:flutter/foundation.dart';
import 'package:flutter_covid19_rest_api/app/services/api_keys.dart';

enum EndPoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

class API {
  API({@required this.apiKey});

  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.nCovSandboxKey);
  factory API.production() => API(apiKey: APIKeys.nCovProductionKey);

  static final String host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(
        host: host,
        scheme: 'https',
        path: 'token',
      );

  Uri endPointUri(EndPoint endPoint) => Uri(
        scheme: 'https',
        host: host,
        path: _paths[endPoint],
      );

  static Map<EndPoint, String> _paths = {
    EndPoint.cases: 'cases',
    EndPoint.casesSuspected: 'casesSuspected',
    EndPoint.casesConfirmed: 'casesConfirmed',
    EndPoint.deaths: 'deaths',
    EndPoint.recovered: 'recovered',
  };
}
