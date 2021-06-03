import 'package:EstudoRESTfulAPI/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

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

  factory API.sandbox() => API(apiKey: ApiKeys.ncovSandboxKey);

  static final String host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
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
