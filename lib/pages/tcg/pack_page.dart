import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PackPage extends StatefulWidget {
  const PackPage({super.key});

  @override
  PackPageState createState() => PackPageState();
}

class PackPageState extends State<PackPage> {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> addKebabIdToProfile() async {
    // Fetch the current user's ID
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    // Step 1: Fetch the current user's `tcg` array
    final profileResponse = await supabase
        .from('profiles')
        .select('tcg, last_pack')
        .eq('id', userId)
        .single();
    final lastPackTimestamp = profileResponse['last_pack'] as String?;

    // Step 2: Check if `last_pack` is more than 12 hours ago
    if (lastPackTimestamp != null) {
      final lastPackTime =DateTime.parse(lastPackTimestamp).toUtc(); // Ensure UTC
      final now = DateTime.now().toUtc(); // Ensure UTC
      final difference = -now.difference(lastPackTime);
      if (difference.inSeconds < 12 * 60 * 60) {
        // Show a toast if less than 12 hours have passed
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).pack_too_soon)));
        }
      }
    }
    final List<dynamic> tcgArray = profileResponse['tcg'] ?? [];

    // Step 2: Fetch a random ID from the `kebab` table that is not in the `tcg` array
    final kebabResponse = await supabase
        .from('kebab')
        .select('id')
        .not('id', 'in', tcgArray)
        .limit(1)
        .maybeSingle();

    if (kebabResponse == null) {
      print('No available kebab IDs to add.');
      return;
    }

    final kebabId = kebabResponse['id'];

    // Step 3: Update the `profiles` table to add the new ID to the `tcg` array
    await supabase.from('profiles').update({
      'tcg': [...tcgArray, kebabId], // Append the new ID to the array
      'last_pack':
          DateTime.now().toUtc().toIso8601String(), // Update the last pack timestamp
    }).eq('id', userId);

    print('Added kebab ID $kebabId to user $userId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).pack)),
      body: Center(
        child: GestureDetector(
          onTap: addKebabIdToProfile,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), // Angoli arrotondati
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2), // Colore ombra
                  spreadRadius: 1, // Diffusione ombra
                  blurRadius: 10, // Sfocatura ombra
                  offset: Offset(5, 5), // Posizione dell'ombra (x, y)
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(16), // Angoli immagine arrotondati
              child: Image.asset(
                'assets/images/kebabbo_pack.png', // Percorso dell'immagine
                width: 300,
                height: 600,
                fit: BoxFit.cover, // Adatta l'immagine al contenitore
              ),
            ),
          ),
        ),
      ),
    );
  }
}
