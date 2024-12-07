import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class MedalPage extends StatefulWidget {
  final String userId;

  const MedalPage({super.key, required this.userId});

  @override
  State<MedalPage> createState() => _MedalPageState();
}

class _MedalPageState extends State<MedalPage> {
  List<int> _medals = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadMedal();
  }

  Future<void> _loadMedal() async {
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }

    try {
      final userId = widget.userId;
      final userData = await supabase
          .from('profiles')
          .select('medals')
          .eq('id', userId)
          .single();

      setState(() {
        if (userData["medals"] == null) {
          _medals = [];
          return;
        }
        _medals = List<int>.from(userData["medals"]);
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).failed_to_load_medals)),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              _medals.contains(0)
                                  ? "assets/images/1_review_medal.png"
                                  : "assets/images/empty_medal.png",
                              height: 70,
                              width: 70,
                            ),
                            Text(
                              S.of(context).prima_review,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              _medals.contains(1)
                                  ? "assets/images/5_review_medal.png"
                                  : "assets/images/empty_medal.png",
                              height: 70,
                              width: 70,
                            ),
                            const Text(
                              '5 review',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              _medals.contains(2)
                                  ? "assets/images/10_review_medal.png"
                                  : "assets/images/empty_medal.png",
                              height: 70,
                              width: 70,
                            ),
                            const Text(
                              '10 review',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              _medals.contains(3)
                                  ? "assets/images/20_review_medal.png"
                                  : "assets/images/empty_medal.png",
                              height: 70,
                              width: 70,
                            ),
                            const Text(
                              '20 review',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              _medals.contains(4)
                                  ? "assets/images/30_review_medal.png"
                                  : "assets/images/empty_medal.png",
                              height: 70,
                              width: 70,
                            ),
                            const Text(
                              '30 review',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              _medals.contains(5)
                                  ? "assets/images/1_post_medal.png"
                                  : "assets/images/empty_medal.png",
                              height: 70,
                              width: 70,
                            ),
                            Text(
                              S.of(context).primo_post,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              _medals.contains(6)
                                  ? "assets/images/5_post_medal.png"
                                  : "assets/images/empty_medal.png",
                              height: 70,
                              width: 70,
                            ),
                            const Text(
                              '5 post',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              _medals.contains(7)
                                  ? "assets/images/10_post_medal.png"
                                  : "assets/images/empty_medal.png",
                              height: 70,
                              width: 70,
                            ),
                            const Text(
                              '10 post',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              _medals.contains(8)
                                  ? "assets/images/50_post_medal.png"
                                  : "assets/images/empty_medal.png",
                              height: 70,
                              width: 70,
                            ),
                            const Text(
                              '50 post',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
