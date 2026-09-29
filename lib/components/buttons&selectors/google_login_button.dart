import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class GoogleLoginButton extends StatelessWidget {
  final String redirectUrl;
  final String? label;

  const GoogleLoginButton({
    super.key,
    required this.redirectUrl,
    this.label,
  });

  Future<void> _nativeGoogleSignIn() async {
    const webClientId =
        '1072333391081-nqs3njkquq8sprkq7dbd7d6q1j3i3h28.apps.googleusercontent.com';
    const iosClientId = 'my-ios.apps.googleusercontent.com';

    // TODO: iosClientId è un segnaposto: serve il vero client ID iOS da Google Cloud.
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: Platform.isIOS ? iosClientId : null,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      // User cancelled the picker.
      return;
    }
    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      throw 'Missing token(s) for authentication.';
    }

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonText = label ?? S.of(context).log_in_con_google;

    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            try {
              if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
                await _nativeGoogleSignIn();
              } else {
                await supabase.auth.signInWithOAuth(
                  OAuthProvider.google,
                  redirectTo: redirectUrl,
                );
              }
            } catch (e) {
              debugPrint('Google sign-in error: $e');
              if (context.mounted) {
                context.showSnackBar(e.toString(), isError: true);
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/google.png",
                  height: 22,
                  width: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  buttonText,
                  style: const TextStyle(
                    color: Color(0xFF1F1F1F),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
