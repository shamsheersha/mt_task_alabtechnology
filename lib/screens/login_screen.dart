import 'package:flutter/material.dart';
import 'package:mt_task_alabtechnology/screens/dashborad_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isOtpEnabled = false;
  bool _otpSent = false;
  final _formKey = GlobalKey<FormState>();

  void _sendOtp() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _otpSent = true;
        _isOtpEnabled = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP Sent: 1234')),
      );
    }
  }

  void _resendOtp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP Resent: 1234')),
    );
  }

  void _login() {
    if (_otpController.text == "1234") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Welcome Back", style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),

              /// Mobile Number
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Mobile Number",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.length < 10) {
                    return 'Enter valid mobile number';
                  }
                  return null;
                },
                onChanged: (_) {
                  setState(() {
                    _otpSent = false;
                    _isOtpEnabled = false;
                  });
                },
              ),
              const SizedBox(height: 10),

              /// Send OTP Button (only when OTP not sent)
              if (!_otpSent)
                ElevatedButton(
                  onPressed: _sendOtp,
                  child: const Text("Send OTP"),
                ),

              const SizedBox(height: 20),

              /// OTP Input
              TextFormField(
                controller: _otpController,
                enabled: _isOtpEnabled,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "OTP",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),

              const SizedBox(height: 10),

              /// Resend OTP (visible only after OTP sent)
              if (_otpSent)
                TextButton(
                  onPressed: _resendOtp,
                  child: const Text("Resend OTP"),
                ),

              const SizedBox(height: 20),

              /// Login Button
              ElevatedButton(
                onPressed: _isOtpEnabled ? _login : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
