import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/router.dart';
import 'package:mood_tracker_2/get_it.dart';
import 'package:mood_tracker_2/presentation/bloc/days_list_bloc/days_list_bloc.dart';
import 'package:mood_tracker_2/presentation/screens/days_list_screen/days_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initGetIt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<DaysListBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mood Tracker 2',
        theme: ThemeData(
            colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.pink.shade200,
          onPrimary: Colors.grey,
          secondary: Colors.amber.shade200,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        )),
        onGenerateRoute: onGenerateRoute,
        home: const DaysListScreen(),
      ),
    );
  }
}
