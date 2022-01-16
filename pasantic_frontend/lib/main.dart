import 'package:flutter/material.dart';
import 'package:pasantic_frontend/providers/internships_provider.dart';
import 'package:pasantic_frontend/screens/internship_detail_screen.dart';
import 'package:pasantic_frontend/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> InternshipsProvider(),lazy: false,)
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
      initialRoute: 'home',
      routes: {
        'home': (_)=>const HomeScreen(),
        'profile': (_)=>const ProfileScreen(),
        'details': (_)=>const InternshipDetailScreen(),
        'login': (_)=>const LoginScreen(),
        'register': (_)=>const RegisterScreen(),
      },

      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.white
        )
      ),
      );
  }
}
