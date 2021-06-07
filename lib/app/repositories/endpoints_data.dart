import 'package:EstudoRESTfulAPI/app/services/api.dart';
import 'package:EstudoRESTfulAPI/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';

class EndPointsData {
  EndPointsData({@required this.values});
  final Map<EndPoint, EndPointData> values;
  EndPointData get cases => values[EndPoint.cases];
  EndPointData get casesSuspected => values[EndPoint.casesSuspected];
  EndPointData get casesConfirmed => values[EndPoint.casesConfirmed];
  EndPointData get deaths => values[EndPoint.deaths];
  EndPointData get recovered => values[EndPoint.recovered];

  @override
  String toString() {
    return 'cases: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
  }
}
