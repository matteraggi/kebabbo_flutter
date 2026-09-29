import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/google_login_button.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/account/forgot_password.dart';
import 'package:kebabbo_flutter/pages/account/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

const List<String> kAuthLogos = [
  'assets/new-logos/logo scritta ad arco sfondo giallo-1.png',
  'assets/new-logos/logo senza arti sfondo giallo scritta bomboletta-1.png',
  'assets/new-logos/logo sfondo giallo mario bros-1.png',
  'assets/new-logos/logo sfondo giallo senza arti scritta arco-1.png',
];

String? _sessionAuthLogo;

String get sessionAuthLogo =>
    _sessionAuthLogo ??= kAuthLogos[Random().nextInt(kAuthLogos.length)];

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.authCallback});

  @override
  LoginPageState createState() => LoginPageState();
  final Function(int)? authCallback;
}

class LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _obscurePassword = true;
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  final _passwordFocusNode = FocusNode();
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
        setState(() {
          widget.authCallback?.call(4);
        });
      }
    } on AuthException catch (error) {
      if (!mounted) return;
      context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (!mounted) return;
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
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellow,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    sessionAuthLogo,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),

                  // Heading
                  const Text(
                    'Kebabbo',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E1E24),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    S.of(context).login_tagline,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withValues(alpha: 0.7),
                      height: 1.3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 1. Standout Google Sign-In Button
                  GoogleLoginButton(redirectUrl: redirectUrl),
                  const SizedBox(height: 24),

                  // Or divider
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(color: Colors.black26, thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          S.of(context).or_continue_with_email,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black.withValues(alpha: 0.65),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Expanded(
                          child: Divider(color: Colors.black26, thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 2. Email & Password Form Fields
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => _passwordFocusNode.requestFocus(),
                    decoration: InputDecoration(
                      labelText: S.of(context).email,
                      hintText: 'nome@email.com',
                      prefixIcon: const Icon(Icons.email_outlined, size: 20),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: red, width: 1.8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  TextField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _signInWithEmailAndPassword(),
                    decoration: InputDecoration(
                      labelText: S.of(context).password,
                      prefixIcon: const Icon(Icons.lock_outline, size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: red, width: 1.8),
                      ),
                    ),
                  ),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 0),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ForgotPasswordPage(redirectUrl: redirectUrl),
                          ),
                        );
                      },
                      child: Text(
                        S.of(context).forgot_password,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Login submit button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          _isLoading ? null : _signInWithEmailAndPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: red,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              S.of(context).login,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sign up navigation link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).no_account_question,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  SignUpPage(redirectUrl: redirectUrl),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).sign_up,
                          style: const TextStyle(
                            color: red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Terms & privacy
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      S
                          .of(context)
                          .by_signing_in_you_agree_to_our_terms_and_privacy_policy,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.6),
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Aesthetic Quote
                  Text(
                    S
                        .of(context)
                        .prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Kebabbo App',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black.withValues(alpha: 0.35),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
