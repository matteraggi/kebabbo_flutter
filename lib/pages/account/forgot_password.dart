import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String redirectUrl;
  const ForgotPasswordPage({super.key, required this.redirectUrl});

  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  SupabaseClient supabase = Supabase.instance.client;

  Future<void> _sendResetPasswordEmail() async {
    if (_emailController.text.isEmpty) {
      context.showSnackBar(S.of(context).please_fill_in_all_fields, isError: true);
      return;
    }
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    setState(() => _isLoading = true);

    try {
      await supabase.auth.resetPasswordForEmail(
        _emailController.text.trim(),
        redirectTo: kIsWeb ? Uri.base.origin : 'io.supabase.flutter://reset-callback/',
      );
      if (mounted) {
        context.showSnackBar(S.of(context).check_your_email_for_a_reset_link);
        Navigator.of(context).pop(); // Go back after success
      }
    } on AuthException catch (error) {
      context.showSnackBar(error.message, isError: true);
      print('Error: ${error.message}');
    } catch (error) {
      context.showSnackBar(S.of(context).unexpected_error_occurred, isError: true);
      print('Error: $error');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).forgot_password),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            Text(
              S.of(context).forgot_password,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
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
                      color: Colors.grey.withAlpha(77),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
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
              ),
            ),
            const SizedBox(height: 24),

            // Send Reset Email Button
            ElevatedButton(
              onPressed: _isLoading ? null : _sendResetPasswordEmail,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(S.of(context).send_reset_email),
            ),
          ],
        ),
      ),
    );
  }
}
