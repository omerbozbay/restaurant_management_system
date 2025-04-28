import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_management_system/screens/login_screen.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart'; // Ensure this is imported

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => ProductProvider()), // Ensure this is registered
      ],
      child: MaterialApp(
        title: 'Kardeşler Kebap Salonu POS Sistemi',
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
        home: const LoginScreen(),
      ),
    );
  }
}