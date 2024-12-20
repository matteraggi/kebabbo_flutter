import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.redirectUrl});
  final String redirectUrl;

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  SupabaseClient supabase = Supabase.instance.client;

  Future<void> _signUp() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      context.showSnackBar(S.of(context).please_fill_in_all_fields, isError: true);
      return;
    }
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    setState(() => _isLoading = true);

    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        emailRedirectTo: kIsWeb
            ? Uri.base.origin
            : 'io.supabase.flutter://login-callback/',
      );
      if (res.user != null && mounted) {
        context.showSnackBar(S.of(context).check_your_email_for_a_verification_link);
        Navigator.of(context).pop(); // Go back after sign-up
      } else {
        context.showSnackBar(S.of(context).unexpected_error_occurred, isError: true);
      }
    } on AuthException catch (error) {
      context.showSnackBar(error.message, isError: true);
    } catch (error) {
      context.showSnackBar(S.of(context).unexpected_error_occurred, isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).sign_up),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sign up title
            Text(
              S.of(context).sign_up,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          SizedBox(height: 24),
              AnimatedOpacity(

              opacity: 1.0,

              duration: const Duration(seconds: 1),

              child: Image.asset(

                'assets/logos/big_logo_name_blackred.png', // Use your logo here

                height: 300,

              ),

            ),
            const SizedBox(height: 24),

            // Logo/Image
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 1),
              child: Image.asset(
                'assets/images/kebab.png',
                height: 160,
              ),
            ),
            const SizedBox(height: 24),

            // Form fields inside a styled container
            Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: S.of(context).email,
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).email_required;
                          }
                          return null;
                        },
                      ),
                    ),
                    const Divider(), // Separator between email and password fields
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: S.of(context).password,
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return S.of(context).password_minimum_length;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Sign Up Button
            ElevatedButton(
              onPressed: _isLoading ? null : _signUp,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(S.of(context).sign_up),
            ),
          ],
        ),
      ),
    );
  }
}
