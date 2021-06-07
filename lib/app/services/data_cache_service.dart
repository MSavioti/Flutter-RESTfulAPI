import 'package:EstudoRESTfulAPI/app/repositories/endpoints_data.dart';
import 'package:EstudoRESTfulAPI/app/services/api.dart';
import 'package:EstudoRESTfulAPI/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheService {
  DataCacheService({@required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  static String endPointValueKey(EndPoint endPoint) => '$endPoint/value';
  static String endPointDateKey(EndPoint endPoint) => '$endPoint/date';

  Future<void> saveData(EndPointsData endPointsData) async {
    endPointsData.values.forEach((endPoint, endPointData) async {
      final value = endPointsData.values[endPoint].value;
      await sharedPreferences.setInt(endPointValueKey(endPoint), value);

      final date = endPointsData.values[endPoint].date;
      await sharedPreferences.setString(
          endPointDateKey(endPoint), date.toIso8601String());
    });
  }

  EndPointsData loadData() {
    Map<EndPoint, EndPointData> values = {};
    EndPoint.values.forEach(
      (endPoint) {
        final value = sharedPreferences.getInt(endPointValueKey(endPoint));
        final dateText = sharedPreferences.getString(endPointDateKey(endPoint));

        if (value != null && dateText != null) {
          final date = DateTime.tryParse(dateText);
          values[endPoint] = EndPointData(value: value, date: date);
        }
      },
    );

    return EndPointsData(values: values);
  }
}
