import 'package:ar_map_project/common/providers/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ar_map_project/firebase_options.dart';
import 'package:ar_map_project/app_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';


import 'package:ar_map_project/common/themes/normal_theme.dart';
import 'package:ar_map_project/common/utils/sizes.dart';
import 'package:ar_map_project/common/services/firestore_service.dart';
import 'package:ar_map_project/common/services/mapbox_service.dart';
import 'package:ar_map_project/common/models/area_model.dart';
import 'package:ar_map_project/features/home/presentation/pages/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MapboxOptions.setAccessToken(dotenv.env['MAPBOX_TOKEN']!);

  Area dlu = Area();
  dlu.BoundaryPoint=[
  Position(108.444374, 11.953916),
  Position(108.443709, 11.954410),
  Position(108.443377, 11.954536),
  Position(108.443065, 11.954620),
  Position(108.442819, 11.954651),
  Position(108.442701, 11.954809),
  Position(108.442668, 11.954830),
  Position(108.442690, 11.957370),
  Position(108.443505, 11.957663),
  Position(108.443430, 11.958104),
  Position(108.443754, 11.958345),
  Position(108.443781, 11.958319),
  Position(108.444178, 11.959043),
  Position(108.444358, 11.959140),
  Position(108.444566, 11.959228),
  Position(108.444575, 11.959219),
  Position(108.444818, 11.959272),
  Position(108.445396, 11.959175),
  Position(108.445405, 11.959166),
  Position(108.445874, 11.959202),
  Position(108.446262, 11.959246),
  Position(108.446388, 11.959140),
  Position(108.446460, 11.958319),
  Position(108.446478, 11.958328),
  Position(108.447065, 11.958081),
  Position(108.447552, 11.957931),
  Position(108.448646, 11.954383),
  Position(108.448481, 11.954338),
  Position(108.446199, 11.954506),
  Position(108.445125, 11.953350),
  Position(108.444439, 11.953871)
];
  await MapboxService.downloadTiles(dlu.BoundaryPoint); //download this after loging in


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
        )
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
