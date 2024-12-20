import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/google_login_button.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/account/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final bool _redirecting = false;
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;
  final redirectUrl = Uri(
    scheme: Uri.base.scheme,
    host: Uri.base.host,
    port: Uri.base.port,
  ).toString();

  Future<void> _signInWithEmailAndPassword() async {
    
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      context.showSnackBar(S.of(context).please_fill_in_all_fields,
          isError: true);
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) {
        context.showSnackBar(S.of(context).logged_in);
        _emailController.clear();
        _passwordController.clear();
      }
    } on AuthException catch (error) {
      context.showSnackBar(error.message, isError: true);
    } catch (error) {
      context.showSnackBar(S.of(context).unexpected_error_occurred,
          isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Sign In',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo or Icon
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(seconds: 1),
                child: Image.asset(
                  'assets/logos/big_logo_name_blackred.png', // Use your logo here
                  height: 300,
                ),
              ),
              SizedBox(height: 20),
              // Google Login Button with Custom Icon
              GoogleLoginButton(redirectUrl: redirectUrl),
              const SizedBox(height: 8),

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // White background container with email and password fields
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // White background
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.3), // Subtle shadow
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: S.of(context).email,
                                border: InputBorder.none, // No default border
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const Divider(), // Divider between email and password
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: S.of(context).password,
                                border: InputBorder.none, // No default border
                              ),
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                        height: 16), // Spacing between the form and the button

                    // Login Button
                    ElevatedButton(
                      onPressed:
                          _isLoading? null : _signInWithEmailAndPassword,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 15), // Button padding
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Rounded button
                        ),
                      ),
                      child: Text(S.of(context).login),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            SignUpPage(redirectUrl: redirectUrl)),
                  );
                },
                child: Text(S.of(context).dont_have_an_account_sign_up),
              ),

              // Optional Terms and Privacy Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  S
                      .of(context)
                      .by_signing_in_you_agree_to_our_terms_and_privacy_policy,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Decorative Element (Divider or Animated Element)
              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 40,
                endIndent: 40,
              ),
              const SizedBox(height: 20),

              // Aesthetic Section: Inspirational Quote or Design
              Text(
                S
                    .of(context)
                    .prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Simple Footer Text (Optional)
              const Text(
                'Kebabbo App - All Rights Reserved',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
