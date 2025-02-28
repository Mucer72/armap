import 'package:ar_map_project/common/providers/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ar_map_project/firebase_options.dart';
import 'package:ar_map_project/app_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


import 'package:ar_map_project/common/themes/normal_theme.dart';
import 'package:ar_map_project/common/utils/sizes.dart';
import 'package:ar_map_project/common/services/firestore_service.dart';
import 'package:ar_map_project/features/home/presentation/pages/home_screen.dart';
import 'package:ar_map_project/common/providers/location_heading_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.locationWhenInUse.request();
  await Permission.camera.request();
  await Permission.calendarFullAccess.request();
  await Permission.sensors.request();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MapboxOptions.setAccessToken(dotenv.env['MAPBOX_TOKEN']!);
  
  runApp(
    MultiProvider( 
      providers: [
        Provider<FirebaseFirestore>(
          create: (_)=>FirebaseFirestore.instance,
        ),
        Provider<FirestoreService>(
          create: (context)=>FirestoreService(context.read<FirebaseFirestore>()),
        ),
        Provider<ThemeProvider>(
          create: (_)=>ThemeProvider(),
        ),
        Provider<LocationHeadingProvider>(
          create: (_)=>LocationHeadingProvider())
      ],
      child: const MyApp(), 
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenDimensions.initialize(context);
    return MaterialApp(
      title: 'AR map',
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: NormalTheme.lightTheme,
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}
