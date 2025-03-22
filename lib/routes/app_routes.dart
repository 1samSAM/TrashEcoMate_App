import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/home_screen.dart';
import '../screens/waste_bin_status_screen.dart';
import '../screens/map_screen.dart';
import '../screens/robot_tracking_screen.dart';
import '../screens/report_issue_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/analytics_screen.dart';
import '../screens/about_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/privacy_screen.dart'; // Import the privacy screen

class AppRoutes {
  static const String splashScreen = '/';
  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
  static const String homeScreen = '/home';
  static const String wasteBinStatusScreen = '/waste-bin-status';
  static const String mapScreen = '/map-screen';
  static const String robotTrackingScreen = '/robot-tracking';
  static const String reportIssueScreen = '/report-issue';
  static const String notificationsScreen = '/notifications';
  static const String settingsScreen = '/settings';
  static const String analyticsScreen = '/analytics';
  static const String aboutScreen = '/about';
  static const String forgotPasswordScreen = '/forgot-password';
  static const String profileScreen = '/profile';
  static const String privacyScreen = '/privacy'; // Add a constant for the privacy screen

  static final Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    loginScreen: (context) => const LoginScreen(),
    signupScreen: (context) => const SignupScreen(),
    homeScreen: (context) => const HomeScreen(),
    wasteBinStatusScreen: (context) => const WasteBinStatusScreen(),
    mapScreen: (context) => const MapScreen(),
    robotTrackingScreen: (context) => const RobotTrackingScreen(),
    reportIssueScreen: (context) => const ReportIssueScreen(),
    notificationsScreen: (context) => const NotificationsScreen(),
    settingsScreen: (context) => const SettingsScreen(),
    analyticsScreen: (context) => const AnalyticsScreen(),
    aboutScreen: (context) => const AboutScreen(),
    forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
    profileScreen: (context) => const ProfileScreen(),
    privacyScreen: (context) => const PrivacyScreen(), // Add the privacy screen to routes
  };
}