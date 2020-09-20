import 'package:flutter/foundation.dart';
import 'package:flutter_covid19_rest_api/app/repositories/endpoints_data.dart';
import 'package:flutter_covid19_rest_api/app/services/api.dart';
import 'package:flutter_covid19_rest_api/app/services/api_service.dart';
import 'package:flutter_covid19_rest_api/app/services/data_cache_service.dart';
import 'package:flutter_covid19_rest_api/app/services/endpoint_data.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService, @required this.dataCacheService});
  final APIService apiService;
  final DataCacheService dataCacheService;

  String _accessToken;

  Future<EndPointData> getEndPointData(EndPoint endPoint) async =>
      await _getDataRefreshingToken<EndPointData>(
        onGetData: () => apiService.getEndPointData(
            accessToken: _accessToken, endPoint: endPoint),
      );

  EndPointsData getAllEndPointsCachedData() => dataCacheService.getData();

  Future<EndPointsData> getAllEndPointData() async {
    final endPointsData = await _getDataRefreshingToken<EndPointsData>(
      onGetData: _getAllEndpointsData,
    );
    await dataCacheService.setData(endPointsData);
    return endPointsData;
  }

  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndPointsData> _getAllEndpointsData() async {
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
    return EndPointsData(
      values: {
        EndPoint.cases: values[0],
        EndPoint.casesSuspected: values[1],
        EndPoint.casesConfirmed: values[2],
        EndPoint.deaths: values[3],
        EndPoint.recovered: values[4],
      },
    );
  }
}
