import 'package:flutter/material.dart';
import 'package:stock_exchange_app/home/views/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA37CC3),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              // Text('Hello,', style: Theme.of(context).textTheme.displayLarge),
              Text(
                'Create Your Account.',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 40),
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Enter your Email..',
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: 'Enter your password..',
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(HomeScreen.route());
                },
                child: const Text('Sign Up'),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
