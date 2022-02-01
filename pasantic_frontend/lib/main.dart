import 'package:flutter/material.dart';
import 'package:pasantic_frontend/providers/applications_provider.dart';
import 'package:pasantic_frontend/providers/enterpriseInternship_provider.dart';
import 'package:pasantic_frontend/providers/internships_provider.dart';
import 'package:pasantic_frontend/screens/internship_detail_screen.dart';
//import 'package:pasantic_frontend/screens/profile_enterprise_screen.dart';
import 'package:pasantic_frontend/screens/screens.dart';
import 'package:provider/provider.dart';

import 'screens/profile_enterprise_screen.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => InternshipsProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => EnterpriseInternshipProvider(),
          lazy: true,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pasantic',
      initialRoute: 'login',
      routes: {
        'home': (_) => const HomeScreen(),
        'profile': (_) => const ProfileScreen(),
        'profile_enterprise': (_) => const ProfileEnterpriseScreen(),
        'details': (_) => const InternshipDetailScreen(),
        'details_enterprise': (_) => const InternshipDetailEnterpriseScreen(),
        'login': (_) => const LoginScreen(),
        'register': (_) => const RegisterScreen(),
        'applications': (_) => const ApplicationsScreen(),
        'internships': (_) => const IntershipsScreen(),
        'newInternship': (_) => const NewInternshipScreen(),
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.white)),
    );
  }
}
