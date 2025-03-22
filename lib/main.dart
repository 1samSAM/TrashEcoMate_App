import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart'; // Import your app routes
import 'utils/theme.dart'; // Import your theme
import 'firebase_options.dart'; // Firebase initialization options
import 'providers/bin_provider.dart'; // Import BinProvider
import 'services/bin_service.dart'; // Import BinService
import 'services/notification_service.dart'; // Import NotificationService

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize Firebase Notifications
    await NotificationService.init();
  } catch (e) {
    debugPrint("Firebase Initialization Error: $e");
  }

  runApp(const TrashEcomateApp());
}

class TrashEcomateApp extends StatelessWidget {
  const TrashEcomateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BinProvider(BinService()), // Providing BinProvider
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TrashEcomate',
        theme: AppTheme.lightTheme, // App theme
        initialRoute: AppRoutes.splashScreen, // Initial route
        routes: AppRoutes.routes, // Defined app routes
      ),
    );
  }
}
