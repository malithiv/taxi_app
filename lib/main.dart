import 'package:flutter/material.dart';
import 'package:taxi_app/CustomerHistoryScreen.dart';
import 'package:taxi_app/CustomerHomeScreen.dart';
import 'package:taxi_app/CustomerProfileScreen.dart';
import 'package:taxi_app/HistoryScreen.dart';
import 'package:taxi_app/HomeScreen.dart';
import 'package:taxi_app/MyHiresScreen.dart';
import 'package:taxi_app/ProfileScreen.dart';
import 'package:taxi_app/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi App',
      debugShowCheckedModeBanner: false,
      home: const SplashScreenWrapper(),

      routes: {
        '/home': (context) => const HomeScreen(),
        '/history': (context) => const HistoryScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/chome': (context) => const CustomerHomeScreen(),
        '/chistory': (context) => const CustomerHistoryScreen(),
        '/cprofile': (context) => const CustomerProfileScreen(),
        '/myhires': (context) => const MyHiresScreen(),

      },
    );
  }
}