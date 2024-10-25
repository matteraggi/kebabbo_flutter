import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  Future<void> _nativeGoogleSignIn() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '1072333391081-jq61dfl6nbvc7qnltcqjf65f7ma7om7n.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId = 'my-ios.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
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
        backgroundColor: Colors.white, // Sfondo bianco
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bordi rotondi
          side: BorderSide(color: Colors.grey.shade300), // Bordo leggero
        ),
        elevation: 2, // Leggera ombra per effetto "pulsante"
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10), // Padding interno
      ),
      onPressed: () async {
        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
          await _nativeGoogleSignIn();
        } else {
          await supabase.auth.signInWithOAuth(
            OAuthProvider.google,
            authScreenLaunchMode: kIsWeb
                ? LaunchMode.platformDefault
                : LaunchMode
                    .externalApplication,
            redirectTo: "https://kebabbo-flutter.vercel.app/"
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
          const Text(
            "Log In con Google",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
