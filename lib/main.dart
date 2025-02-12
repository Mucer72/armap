import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ar_map_project/firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ar_map_project/app_router.dart';
import 'package:ar_map_project/features/home/presentation/pages/home_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR map',
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
