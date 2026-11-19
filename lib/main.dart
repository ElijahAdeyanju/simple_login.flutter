import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the "Debug" banner
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // State variables
  bool _isSignUp = false; // Toggles between Sign In and Create Account
  bool _agreeToTerms = false; // For the checkbox

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // 1. Check if they are creating an account and haven't agreed to terms
    if (_isSignUp && !_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the Terms and Conditions.')),
      );
      return;
    }

    // 2. Print the values (Replace this with your actual login logic)
    print('--- FORM SUBMITTED ---');
    if (_isSignUp) print('Username: ${_usernameController.text}');
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
    print('Agreed to terms: $_agreeToTerms');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSignUp ? 'Create Account' : 'Sign In'),
        centerTitle: true,
      ),
      // SingleChildScrollView prevents the "overflow" error when the keyboard pops up
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // App Logo or Title
            Icon(Icons.lock_person, size: 80, color: Theme.of(context).primaryColor),
            const SizedBox(height: 40),

            // --- USERNAME FIELD (Only shows when creating an account) ---
            if (_isSignUp) ...[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // --- EMAIL FIELD ---
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // --- PASSWORD FIELD ---
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),

            // --- FORGOT PASSWORD BUTTON (Only shows on Sign In) ---
            if (!_isSignUp)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Add your forgot password logic here
                    print('Forgot password clicked');
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),

            const SizedBox(height: 16),

            // --- TERMS AND CONDITIONS CHECKBOX (Only shows when creating an account) ---
            if (_isSignUp) ...[
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text('I agree to the Terms and Conditions'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // --- SUBMIT BUTTON ---
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                _isSignUp ? 'CREATE ACCOUNT' : 'SIGN IN',
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 24),

            // --- SWITCH BETWEEN SIGN IN / SIGN UP ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_isSignUp ? 'Already have an account?' : "Don't have an account?"),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isSignUp = !_isSignUp; // Toggles the form
                      _agreeToTerms = false; // Resets checkbox
                    });
                  },
                  child: Text(_isSignUp ? 'Sign In' : 'Create Account'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}