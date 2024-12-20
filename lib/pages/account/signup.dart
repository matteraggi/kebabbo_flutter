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
      context.showSnackBar(S.of(context).please_fill_in_all_fields,
          isError: true);
      return;
    }
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        emailRedirectTo: kIsWeb
        ? Uri.base.origin  // For web
        : 'io.supabase.flutter://login-callback/', //TODO da cambiare con il proprio dominio
      );
      print(res.user);
      print(res.session);
      // Check if res.user is null
      if (res.user != null) {
        if (mounted) {
          context.showSnackBar(
              S.of(context).check_your_email_for_a_verification_link);
              Navigator.of(context).pop();
          
        }
      } else {
        // Handle the case where res.user is null
        context.showSnackBar(S.of(context).unexpected_error_occurred,
            isError: true);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).sign_up),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //sign up text
              Text(
                S.of(context).sign_up,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
          SizedBox(height: 24),
              AnimatedOpacity(

              opacity: 1.0,

              duration: const Duration(seconds: 1),

              child: Image.asset(

                'assets/images/big_logo_name_blackred.png', // Use your logo here

                height: 300,

              ),

            ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
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
                        height: 24), // Spacing between the form and the button

                    // Login Button
                    ElevatedButton(
                      onPressed:
                          _isLoading  ? null : _signUp,
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
            ],
          ),
        ),
      ),
    );
  }
}
