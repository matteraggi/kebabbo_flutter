import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordForm extends StatefulWidget {
  final String token;

  const ResetPasswordForm({super.key, required this.token});

  @override
  ResetPasswordFormState createState() => ResetPasswordFormState();
}

class ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  bool _isLoading = false;

 Future<void> _updatePassword() async {
  final isValid = _formKey.currentState!.validate();
  if (!isValid) return;

  setState(() => _isLoading = true);
  try {
    // Now update the password
    await Supabase.instance.client.auth.updateUser(
      UserAttributes(password: _newPasswordController.text.trim()),
    );

    context.showSnackBar(S.of(context).password_reset_success);
  } catch (e) {
    context.showSnackBar('Failed to reset password: ${e.toString()}', isError: true);
    print(e.toString());
  } finally {
    setState(() => _isLoading = false);
  }
}
  @override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
      // Dismiss the keyboard when clicking outside the input
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: S.of(context).new_password),
              obscureText: true,
              validator: (value) {
                if (value == null || value.length < 6) {
                  return S.of(context).password_must_be_at_least_6_characters;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _updatePassword,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(S.of(context).reset_password),
            ),
          ],
        ),
      ),
    ),
  );
}
}