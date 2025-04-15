import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_usernameController.text == 'admin' &&
        _passwordController.text == '1234') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kullanıcı adı veya şifre hatalı')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sol panel (Logo + Marka Adı)
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFF2D4599),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo üstte
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Image.asset(
                      'assets/logo.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Marka adı altta
                  const Text(
                    'Kardeşler Kebap',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sağ panel (Giriş formu)
          Expanded(
            flex: 5,
            child: Center(
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Giriş Yap',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Kullanıcı adı
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Kullanıcı Adı',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Şifre
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Şifre',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Giriş Butonu
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D4599),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Giriş Yap',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
