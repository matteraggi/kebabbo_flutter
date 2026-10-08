import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/google_login_button.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/account/login_page.dart';
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
  bool _obscurePassword = true;
  SupabaseClient supabase = Supabase.instance.client;

  Future<void> _signUp() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      context.showSnackBar(S.of(context).please_fill_in_all_fields,
          isError: true);
      return;
    }
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    setState(() => _isLoading = true);

    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        emailRedirectTo:
            kIsWeb ? Uri.base.origin : 'io.supabase.flutter://login-callback/',
      );
      if (res.user != null && mounted) {
        context.showSnackBar(
            S.of(context).check_your_email_for_a_verification_link);
        Navigator.of(context).pop(); // Go back after sign-up
      } else {
        if (!mounted) return;
        context.showSnackBar(S.of(context).unexpected_error_occurred,
            isError: true);
      }
    } on AuthException catch (error) {
      if (!mounted) return;
      context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (!mounted) return;
      context.showSnackBar(S.of(context).unexpected_error_occurred,
          isError: true);
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
                  Text(S.of(context).sign_up, style: headingStyle(size: 30)),
                  const SizedBox(height: 6),
                  Text(
                    S.of(context).signup_tagline,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withValues(alpha: 0.7),
                      height: 1.3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 1. Primary Highlight: Google Sign-Up Button
                  GoogleLoginButton(
                    redirectUrl: widget.redirectUrl,
                    label: S.of(context).sign_up_with_google,
                  ),
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

                  // 2. Form fields
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: S.of(context).email,
                            hintText: 'nome@email.com',
                            prefixIcon:
                                const Icon(Icons.email_outlined, size: 20),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: red, width: 1.8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).email_required;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _signUp(),
                          decoration: InputDecoration(
                            labelText: S.of(context).password,
                            prefixIcon:
                                const Icon(Icons.lock_outline, size: 20),
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
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: red, width: 1.8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return S.of(context).password_minimum_length;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Sign Up submit button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _signUp,
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
                              S.of(context).sign_up,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Already have an account link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).have_account_question,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          S.of(context).login,
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
                        color: Colors.black.withValues(alpha: 0.65),
                        fontSize: 12,
                        height: 1.3,
                      ),
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
