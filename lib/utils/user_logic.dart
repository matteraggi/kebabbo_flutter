import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

Future<Map<String, dynamic>?> getProfile(BuildContext context) async {
  try {
    final userId = Supabase.instance.client.auth.currentSession!.user.id;
    final data = await Supabase.instance.client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();

    return {
      'username': data['username'] ?? '',
      'avatarUrl': data['avatar_url'] ?? '',
      'favoritesCount': (data['favorites'] as List?)?.length ?? 0,
      'ingredients': data['ingredients'] ?? [],
      'seguitiCount': data['followed_users'] ?? [],
      'favoriteKebab': data['favorite_kebab'] ?? 0,
    };
  } catch (error) {
    print(error);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unexpected error occurred')),
    );
    return null;
  }
}

Future<void> updateProfile(BuildContext context, String? username,
    String? avatarUrl, List<int>? ingredients) async {
  final user = Supabase.instance.client.auth.currentUser;

  // Fetch the current profile data first
  final currentProfile = await Supabase.instance.client
      .from('profiles')
      .select()
      .eq('id', user!.id)
      .single();

  // Build the updates map
  final updates = {
    'id': user.id,
    'username': username ?? currentProfile['username'], // Use current if null
    'avatar_url':
        avatarUrl ?? currentProfile['avatar_url'], // Use current if null
    'ingredients':
        ingredients ?? currentProfile['ingredients'], // Use current if null
    'updated_at': DateTime.now().toIso8601String(),
  };
  try {
    await Supabase.instance.client.from('profiles').upsert(updates);
    if (username != null || avatarUrl != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).successfully_updated_profile)),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).unexpected_error_occurred)),
    );
  }
}

String? validateUsername(String username, BuildContext context) {
  // Check for whitespace
  if (username.contains(' ')) {
    return S.of(context).username_cannot_contain_spaces_use_undescores_instead;
  }

  // Check for length (min 3, max 12)
  if (username.length < 3) {
    return S.of(context).username_must_be_at_least_3_characters_long;
  }
  if (username.length > 12) {
    return S.of(context).username_cannot_be_more_than_12_characters;
  }

  // Check for invalid characters (only letters, numbers, underscores allowed)
  if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
    return S
        .of(context)
        .username_can_only_contain_letters_numbers_and_underscores;
  }

  // Return null if there's no error (valid username)
  return null;
}
