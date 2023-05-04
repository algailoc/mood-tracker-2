import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hive/hive.dart';
import 'package:mood_tracker_2/core/constants.dart';
import 'package:mood_tracker_2/core/router.dart';
import 'package:mood_tracker_2/get_it.dart';
import 'package:mood_tracker_2/presentation/bloc/days_list_bloc/days_list_bloc.dart';
import 'package:mood_tracker_2/presentation/screens/days_list_screen/days_list_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await initGetIt();

  final path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);

  await Hive.openBox(daysBoxName);
  await Hive.openBox(activitiesBoxName);
  await Hive.openBox(foodsBoxName);
  await Hive.openBox(goodStuffBoxName);
  await Hive.openBox(badStuffBoxName);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ru'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<DaysListBloc>()..add(FetchDaysListEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Mood Tracker 2',
        theme: ThemeData(
            buttonTheme: ButtonThemeData(
              highlightColor: Colors.pink.shade100,
            ),
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: Colors.pink.shade200,
              onPrimary: Colors.grey.shade200,
              secondary: Colors.amber.shade200,
              onSecondary: Colors.blueGrey.shade200,
              error: const Color.fromARGB(255, 141, 22, 14),
              onError: Colors.grey.shade200,
              background: Colors.white,
              onBackground: Colors.grey.shade700,
              surface: Colors.white,
              onSurface: Colors.grey.shade700,
            )),
        onGenerateRoute: onGenerateRoute,
        home: const DaysListScreen(),
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}
