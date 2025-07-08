import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart'; // Assuming S.of(context) comes from here
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/main.dart';
class PackPage extends StatefulWidget {
  const PackPage({super.key});

  @override
  PackPageState createState() => PackPageState();
}

class PackPageState extends State<PackPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  String? _kebabName; // Name of the kebab to display, triggers animation
  bool _isOpeningLogicRunning = false; // True while fetching data and before animation starts
  bool _isAnimationInProgress = false; // True while the pack opening animation is playing

  @override
  void initState() {
    super.initState();
    // If you want the pack to attempt opening automatically on page load, call _initiatePackOpening() here.
    // Otherwise, it will wait for the first tap as per the current logic.
  }

  // Renamed from addKebabIdToProfile for clarity and to reflect its role
  Future<void> _initiatePackOpening() async {
    // Prevent re-entry if logic is already running or a kebab is already shown/animating
    if (_isOpeningLogicRunning || _kebabName != null) {
      return;
    }

    setState(() {
      _isOpeningLogicRunning = true;
    });

    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found. Please log in again.")),
        );
        Navigator.pop(context);
      }
      // Ensure state is reset even if mounted is false somehow before return
      if (mounted) {
        setState(() => _isOpeningLogicRunning = false);
      } else {
        _isOpeningLogicRunning = false;
      }
      return;
    }

    try {
      final profileResponse = await supabase
          .from('profiles')
          .select('tcg, last_pack')
          .eq('id', userId)
          .single(); // .single() will throw an error if no user or more than one is found.

      final lastPackTimestamp = profileResponse['last_pack'] as String?;
      // Ensure tcgArray is correctly typed, e.g., List<int> or List<String> if IDs are such
      final List<dynamic> tcgArray = List<dynamic>.from(profileResponse['tcg'] ?? []);

      // Check if user can open a pack based on timestamp
      if (lastPackTimestamp != null) {
        final lastPackTime = DateTime.parse(lastPackTimestamp).toUtc();
        final now = DateTime.now().toUtc();
        final difference = now.difference(lastPackTime);

        // print('Difference in seconds: ${difference.inSeconds}'); // For debugging
        // Check if less than 12 hours (12 * 60 * 60 seconds)
        if (difference.inSeconds < 43200) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).pack_too_soon)),
            );
            Navigator.pop(context); // Close the pack page if too soon
          }
          if (mounted) {
            setState(() => _isOpeningLogicRunning = false);
          } else {
            _isOpeningLogicRunning = false;
          }
          return;
        }
      }
      // If lastPackTimestamp is null, or the time difference is sufficient, proceed.

      // Fetch a random kebab ID not already in the user's tcg array
      // Supabase client should handle empty tcgArray for 'not in' (meaning fetch all)
      // Use .cast<Object>() for type safety with the Supabase client if IDs are not dynamic.
      final kebabResponse = await supabase
          .from('kebab')
          .select('id, name')
          .not('id', 'in', tcgArray.cast<Object>()) // Cast to List<Object> if necessary
          .limit(1) // You might want .order('random()') if your DB supports it and you need true randomness
          .maybeSingle(); // Use maybeSingle to get null if no matching kebab is found

      if (kebabResponse == null) {
        // No new kebabs available for the user
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).found_all_cards)),
          );
          Navigator.pop(context); // Close page as there's nothing new to show
        }
        if (mounted) {
          setState(() => _isOpeningLogicRunning = false);
        } else {
          _isOpeningLogicRunning = false;
        }
        return;
      }

      final foundKebabId = kebabResponse['id'];
      final String kebabDisplayName = kebabResponse['name']; // Original name for processing

      // Update the user's profile with the new kebab ID and timestamp
      final updatedTcgArray = [...tcgArray, foundKebabId];
      await supabase.from('profiles').update({
        'tcg': updatedTcgArray,
        'last_pack': DateTime.now().toUtc().toIso8601String(),
      }).eq('id', userId);

      print('Added kebab ID $foundKebabId to user $userId');
      String imageName = kebabDisplayName.toLowerCase().replaceAll(' ', '-');

      // Precache the image before starting the animation
      if (mounted) {
        await precacheImage(AssetImage('assets/kebab-card/$imageName.png'), context);
        setState(() {
          _kebabName = imageName;         // Set kebabName to trigger UI update and animation
          _isOpeningLogicRunning = false; // Logic part is now complete
          _isAnimationInProgress = true;  // Animation will start due to _kebabName change
        });
      } else {
         // Widget was disposed before we could update UI, ensure flag is reset
        _isOpeningLogicRunning = false;
      }

    } catch (e, stacktrace) {
      print('Error opening pack: $e');
      print('Stacktrace: $stacktrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: ${e.toString()}')), // Provide a user-friendly error
        );
        // It's often good to pop on error to prevent user being stuck
        Navigator.pop(context);
      }
      if (mounted) {
        setState(() => _isOpeningLogicRunning = false);
      } else {
        _isOpeningLogicRunning = false;
      }
    }
  }

  void _handleTap() {
    if (_kebabName == null) {
      // Pack has not been revealed yet.
      if (!_isOpeningLogicRunning) {
        // If opening logic is not currently running, initiate it.
        _initiatePackOpening();
      }
      // If _isOpeningLogicRunning is true, do nothing (wait for current attempt to finish).
    } else {
      // Pack has been revealed (or is in the process of revealing via animation).
      if (!_isAnimationInProgress) {
        // If animation is NOT in progress (i.e., it has finished), close the page.
        Navigator.pop(context);
      }
      // If _isAnimationInProgress is true, do nothing (animation is playing, wait for it to finish).
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pack Opening")),
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white,red],
              stops: [0, 1],
            ),
          ),
          child:  Center(
        child: GestureDetector(
          onTap: _handleTap, // Use the new tap handler
          child: SizedBox(
            width: 300,
            height: 600,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Hidden Card (becomes visible and positioned when _kebabName is set)
                if (_kebabName != null)
                  Positioned(
                    top: 0, // Ensure this aligns correctly behind the pack halves before animation
                    child: Image.asset(
                      'assets/kebab-card/$_kebabName.png',
                      width: 250,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),

                // Top Half of the Pack
                AnimatedPositioned(
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeInExpo,
                  top: _kebabName != null ? -350 : -36, // Moves up when _kebabName is set
                  onEnd: () {
                    // This callback fires when the top half's animation finishes.
                    // We consider the overall animation finished at this point.
                    if (_kebabName != null && _isAnimationInProgress) {
                      setState(() {
                        _isAnimationInProgress = false;
                      });
                    }
                  },
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
                  curve: Curves.easeInExpo,
                  right: 2,
                  bottom: _kebabName != null ? -550 : 37, // Moves down when _kebabName is set
                  // No onEnd needed here if the top one handles the state reset,
                  // assuming they have the same duration and curve.
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
      )
    );
  }
}