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

  const GoogleLoginButton({super.key, required this.redirectUrl});

  Future<void> _nativeGoogleSignIn() async {
    const webClientId =
        '1072333391081-nqs3njkquq8sprkq7dbd7d6q1j3i3h28.apps.googleusercontent.com';
    const iosClientId = 'my-ios.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: () async {
        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
          await _nativeGoogleSignIn();
        } else {
          await supabase.auth.signInWithOAuth(
            OAuthProvider.google,
            redirectTo: redirectUrl, // Use the provided redirect URL here
          );
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/google.png",
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 10),
          Text(
            S.of(context).log_in_con_google,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
