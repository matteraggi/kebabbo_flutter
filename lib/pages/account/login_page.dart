import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/google_login_button.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/account/account_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;
  final redirectUrl = Uri(
    scheme: Uri.base.scheme,
    host: Uri.base.host,
    port: Uri.base.port,
  ).toString();

  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signInWithOtp(
        email: _emailController.text.trim(),
        emailRedirectTo:
            kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      );
      if (mounted) {
        context.showSnackBar(S.of(context).check_your_email_for_a_login_link);

        _emailController.clear();
      }
    } on AuthException catch (error) {
      if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (mounted) {
        context.showSnackBar(S.of(context).unexpected_error_occurred,
            isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  

  @override
  void initState() {
    super.initState();

    _authStateSubscription = supabase.auth.onAuthStateChange.listen(
      (data) {
        if (_redirecting || !mounted) return;

        final session = data.session;
        if (session != null) {
          _redirecting = true;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AccountPage()),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
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
      body: Padding(
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
                'assets/images/kebab.png', // Use your logo here
                height: 160,
              ),
            ),
            const SizedBox(height: 30),

            // Google Login Button with Custom Icon
            GoogleLoginButton(redirectUrl: redirectUrl),
            const SizedBox(height: 20),

            // Optional Terms and Privacy Text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                S
                    .of(context)
                    .by_signing_in_you_agree_to_our_terms_and_privacy_policy,
                textAlign: TextAlign.center,
                style: TextStyle(
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
              style: TextStyle(
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
    );
  }
}
