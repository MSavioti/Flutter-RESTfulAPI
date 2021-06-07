import 'package:EstudoRESTfulAPI/app/repositories/data_repository.dart';
import 'package:EstudoRESTfulAPI/app/services/api.dart';
import 'package:EstudoRESTfulAPI/app/services/api_service.dart';
import 'package:EstudoRESTfulAPI/app/services/data_cache_service.dart';
import 'package:EstudoRESTfulAPI/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'pt_BR';
  await initializeDateFormatting();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: ApiService(API.sandbox()),
        dataCacheService:
            DataCacheService(sharedPreferences: sharedPreferences),
      ),
      child: MaterialApp(
        title: 'Coronavirus Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}
