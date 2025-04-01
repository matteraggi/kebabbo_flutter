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
  String? _kebabName;

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
      final lastPackTime =
          DateTime.parse(lastPackTimestamp).toUtc(); // Ensure UTC
      final now = DateTime.now().toUtc(); // Ensure UTC
      final difference = now.difference(lastPackTime);
      print('Difference in seconds: ${difference.inSeconds}');
      if (difference.inSeconds < 12 * 60 * 60) {
        // Show a toast if less than 12 hours have passed
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).pack_too_soon)));
        }
      } else {
        final List<dynamic> tcgArray = profileResponse['tcg'] ?? [];

        // Step 2: Fetch a random ID from the `kebab` table that is not in the `tcg` array
        final kebabResponse = await supabase
            .from('kebab')
            .select('id, name')
            .not('id', 'in', tcgArray)
            .limit(1)
            .maybeSingle();

        if (kebabResponse == null) {
          print('No available kebab IDs to add.');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).found_all_cards)));
          return;
        }

        final foundKebabId = kebabResponse['id'];

        // Step 3: Update the `profiles` table to add the new ID to the `tcg` array
        await supabase.from('profiles').update({
          'tcg': [...tcgArray, foundKebabId], // Append the new ID to the array
          'last_pack': DateTime.now()
              .toUtc()
              .toIso8601String(), // Update the last pack timestamp
        }).eq('id', userId);

        print('Added kebab ID $foundKebabId to user $userId');
        String name= kebabResponse['name'].toLowerCase().replaceAll(' ', '-');
        await precacheImage(AssetImage('assets/kebab-card/$name.png'), context);
        setState(() {
          _kebabName = name;
        });
        print('Kebab ID: $_kebabName');
      return;
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(S.of(context).pack_too_soon)));
    }
    Navigator.pop(context); // Close the pack page
  }

 @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Pack Opening")),
      body: Center(
        child: GestureDetector(
          onTap:addKebabIdToProfile,
          child: SizedBox(
            width: 300,
            height: 600,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Hidden Card (Only shown when _kebabId is set)
                if (_kebabName != null)
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      'assets/kebab-card/$_kebabName.png', // Dynamic path based on _kebabId
                      width: 250,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),

                // Top Half of the Pack
                AnimatedPositioned(
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeInExpo,
                  top: _kebabName!=null ? -350 : -36, // Moves up when _kebabId is set
                  child: Image.asset(
                    'assets/images/pack_top.png',
                    width: 267,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),

                // Bottom Half of the Pack
                AnimatedPositioned(
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeInExpo ,
                  right: 2,
                  bottom: _kebabName!=null ? -550 : 37, // Moves down when _kebabId is set
                  child: Image.asset(
                    'assets/images/pack_bottom.png',
                    width: 300,
                    height: 500,
                    fit: BoxFit.cover,
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