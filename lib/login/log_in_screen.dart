import 'package:flutter/material.dart';
import 'package:stock_exchange_app/sign_up/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const LoginScreen());
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
              Text('Hello,', style: Theme.of(context).textTheme.displayLarge),
              Text(
                'Welcome Trader.',
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
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: const Text('Log in')),
              const SizedBox(height: 40),
              Row(
                children: [
                  const Expanded(child: Divider(indent: 10, endIndent: 10)),
                  Text('Or', style: Theme.of(context).textTheme.bodyLarge),
                  const Expanded(child: Divider(indent: 10, endIndent: 10)),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have Account?",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(SignUpScreen.route());
                    },
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
