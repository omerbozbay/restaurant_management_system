import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CartProvider(),
      child: MaterialApp(
        title: 'Kardesler Kebap Salonu POS Sistemi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF2D4599),
          scaffoldBackgroundColor: Colors.grey[100],
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2D4599),
            elevation: 0,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF2D4599),
            secondary: const Color(0xFF2D4599),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
