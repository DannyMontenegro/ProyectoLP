import 'package:flutter/material.dart';
import 'package:pasantic_frontend/screens/screens.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

// class AppState extends StatelessWidget {
//   const AppState({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [],
//       child: const MyApp(),);
//   }
// }

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
        'profile': (_)=>const ProfileScreen()
      },

      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.white
        )
      ),
      );
  }
}
