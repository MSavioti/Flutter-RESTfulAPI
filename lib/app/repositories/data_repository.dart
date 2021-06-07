import 'package:EstudoRESTfulAPI/app/repositories/endpoints_data.dart';
import 'package:EstudoRESTfulAPI/app/services/api.dart';
import 'package:EstudoRESTfulAPI/app/services/api_service.dart';
import 'package:EstudoRESTfulAPI/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService});

  ApiService apiService;
  String _accessToken;

  Future<T> _getToken<T>({Future<T> Function() onDataGet}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }

      return await onDataGet();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onDataGet();
      }

      rethrow;
    }
  }

  Future<EndPointData> getEndPointData(EndPoint endPoint) async {
    return await _getToken<EndPointData>(
      onDataGet: () => apiService.getEndPointData(
          accessToken: _accessToken, endPoint: endPoint),
    );
  }

  Future<EndPointsData> getAllEndPoints() async {
    return await _getToken<EndPointsData>(
      onDataGet: () => _getAllEndPoints(),
    );
  }

  Future<EndPointsData> _getAllEndPoints() async {
    final values = await Future.wait([
      apiService.getEndPointData(
          accessToken: _accessToken, endPoint: EndPoint.cases),
      apiService.getEndPointData(
          accessToken: _accessToken, endPoint: EndPoint.casesSuspected),
      apiService.getEndPointData(
          accessToken: _accessToken, endPoint: EndPoint.casesConfirmed),
      apiService.getEndPointData(
          accessToken: _accessToken, endPoint: EndPoint.deaths),
      apiService.getEndPointData(
          accessToken: _accessToken, endPoint: EndPoint.recovered),
    ]);
    return EndPointsData(values: {
      EndPoint.cases: values[0],
      EndPoint.casesSuspected: values[1],
      EndPoint.casesConfirmed: values[2],
      EndPoint.deaths: values[3],
      EndPoint.recovered: values[4],
    });
  }
}
