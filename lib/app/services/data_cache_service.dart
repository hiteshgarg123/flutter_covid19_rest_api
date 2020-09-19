import 'package:flutter/foundation.dart';
import 'package:flutter_covid19_rest_api/app/repositories/endpoints_data.dart';
import 'package:flutter_covid19_rest_api/app/services/api.dart';
import 'package:flutter_covid19_rest_api/app/services/endpoint_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheService {
  DataCacheService({@required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  static String endPointValueKey(EndPoint endPoint) => '$endPoint/value';
  static String endPointDateKey(EndPoint endPoint) => '$endPoint/date';

  EndPointsData getData() {
    Map<EndPoint, EndPointData> values = {};
    EndPoint.values.forEach((endPoint) {
      final value = sharedPreferences.getInt(endPointValueKey(endPoint));
      final dateString = sharedPreferences.getString(endPointDateKey(endPoint));

      if (value != null && dateString != null) {
        final date = DateTime.tryParse(dateString);
        values[endPoint] = EndPointData(value: value, date: date);
      }
    });
    return EndPointsData(values: values);
  }

  Future<void> setData(EndPointsData endPointsData) async {
    endPointsData.values.forEach((endPoint, endPointData) async {
      await sharedPreferences.setInt(
        endPointValueKey(endPoint),
        endPointData.value,
      );
      await sharedPreferences.setString(
        endPointDateKey(endPoint),
        endPointData.date.toIso8601String(),
      );
    });
  }
}
