import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MedalInfo {
  final int id;
  final String assetPath;
  final String category; // 'reviews' or 'posts'
  final int requiredCount;

  const MedalInfo({
    required this.id,
    required this.assetPath,
    required this.category,
    required this.requiredCount,
  });

  String title(S s) => [
        s.medal_0_title,
        s.medal_1_title,
        s.medal_2_title,
        s.medal_3_title,
        s.medal_4_title,
        s.medal_5_title,
        s.medal_6_title,
        s.medal_7_title,
        s.medal_8_title,
      ][id];

  String subtitle(S s) => [
        s.one_review,
        s.five_reviews,
        s.ten_reviews,
        s.twenty_reviews,
        s.thirty_reviews,
        s.one_post,
        s.five_posts,
        s.ten_posts,
        s.fifty_posts,
      ][id];

  String description(S s) => [
        s.medal_0_desc,
        s.medal_1_desc,
        s.medal_2_desc,
        s.medal_3_desc,
        s.medal_4_desc,
        s.medal_5_desc,
        s.medal_6_desc,
        s.medal_7_desc,
        s.medal_8_desc,
      ][id];

  String unit(S s) => category == 'reviews' ? s.unit_reviews : s.unit_posts;
}

const List<MedalInfo> allMedalsList = [
  // Categoria Recensioni
  MedalInfo(id: 0, assetPath: 'assets/images/1_review_medal.png', category: 'reviews', requiredCount: 1),
  MedalInfo(id: 1, assetPath: 'assets/images/5_review_medal.png', category: 'reviews', requiredCount: 5),
  MedalInfo(id: 2, assetPath: 'assets/images/10_review_medal.png', category: 'reviews', requiredCount: 10),
  MedalInfo(id: 3, assetPath: 'assets/images/20_review_medal.png', category: 'reviews', requiredCount: 20),
  MedalInfo(id: 4, assetPath: 'assets/images/30_review_medal.png', category: 'reviews', requiredCount: 30),

  // Categoria Community / Post
  MedalInfo(id: 5, assetPath: 'assets/images/1_post_medal.png', category: 'posts', requiredCount: 1),
  MedalInfo(id: 6, assetPath: 'assets/images/5_post_medal.png', category: 'posts', requiredCount: 5),
  MedalInfo(id: 7, assetPath: 'assets/images/10_post_medal.png', category: 'posts', requiredCount: 10),
  MedalInfo(id: 8, assetPath: 'assets/images/50_post_medal.png', category: 'posts', requiredCount: 50),
];

class MedalPage extends StatefulWidget {
  final String userId;

  const MedalPage({super.key, required this.userId});

  @override
  State<MedalPage> createState() => _MedalPageState();
}

class _MedalPageState extends State<MedalPage> {
  List<int> _medals = [];
  int _reviewsCount = 0;
  int _postsCount = 0;
  bool _loading = true;
  String _selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    _loadMedalData();
  }

  Future<void> _loadMedalData() async {
    setState(() => _loading = true);

    try {
      final userId = widget.userId;

      // 1. Profilo con medaglie già registrate
      final userData = await supabase
          .from('profiles')
          .select('medals')
          .eq('id', userId)
          .single();

      final List<int> currentMedals = userData['medals'] != null
          ? List<int>.from(userData['medals'])
          : [];

      // 2. Conteggio effettivo recensioni
      final reviewsCountRes = await supabase
          .from('reviews')
          .select('id')
          .eq('user_id', userId)
          .count(CountOption.exact);
      final int userReviews = reviewsCountRes.count;

      // 3. Conteggio effettivo post
      final postsCountRes = await supabase
          .from('posts')
          .select('id')
          .eq('user_id', userId)
          .filter('comment', 'is', null)
          .count(CountOption.exact);
      final int userPosts = postsCountRes.count;

      // 4. Sincronizzazione retroattiva delle medaglie meritate
      final List<int> updatedMedals = List.from(currentMedals);
      bool newUnlock = false;

      // Medaglie Recensioni (0..4)
      if (userReviews >= 1 && !updatedMedals.contains(0)) {
        updatedMedals.add(0);
        newUnlock = true;
      }
      if (userReviews >= 5 && !updatedMedals.contains(1)) {
        updatedMedals.add(1);
        newUnlock = true;
      }
      if (userReviews >= 10 && !updatedMedals.contains(2)) {
        updatedMedals.add(2);
        newUnlock = true;
      }
      if (userReviews >= 20 && !updatedMedals.contains(3)) {
        updatedMedals.add(3);
        newUnlock = true;
      }
      if (userReviews >= 30 && !updatedMedals.contains(4)) {
        updatedMedals.add(4);
        newUnlock = true;
      }

      // Medaglie Post (5..8)
      if (userPosts >= 1 && !updatedMedals.contains(5)) {
        updatedMedals.add(5);
        newUnlock = true;
      }
      if (userPosts >= 5 && !updatedMedals.contains(6)) {
        updatedMedals.add(6);
        newUnlock = true;
      }
      if (userPosts >= 10 && !updatedMedals.contains(7)) {
        updatedMedals.add(7);
        newUnlock = true;
      }
      if (userPosts >= 50 && !updatedMedals.contains(8)) {
        updatedMedals.add(8);
        newUnlock = true;
      }

      // Aggiorna sul DB se ci sono sblocchi automatici per l'utente loggato
      if (newUnlock && userId == supabase.auth.currentUser?.id) {
        await supabase
            .from('profiles')
            .update({'medals': updatedMedals})
            .eq('id', userId);
      }

      if (mounted) {
        setState(() {
          _medals = updatedMedals;
          _reviewsCount = userReviews;
          _postsCount = userPosts;
          _loading = false;
        });
      }
    } catch (error) {
      debugPrint('Errore nel caricamento del medagliere: $error');
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).failed_to_load_medals)),
        );
      }
    }
  }

  ({String rankName, String icon, String description}) _calculateRank(int count) {
    final s = S.of(context);
    if (count >= 9) {
      return (
        rankName: s.rank_5_name,
        icon: '🏆',
        description: s.rank_5_desc,
      );
    } else if (count >= 7) {
      return (
        rankName: s.rank_4_name,
        icon: '👑',
        description: s.rank_4_desc,
      );
    } else if (count >= 5) {
      return (
        rankName: s.rank_3_name,
        icon: '🌶️',
        description: s.rank_3_desc,
      );
    } else if (count >= 3) {
      return (
        rankName: s.rank_2_name,
        icon: '🎖️',
        description: s.rank_2_desc,
      );
    } else if (count >= 1) {
      return (
        rankName: s.rank_1_name,
        icon: '🌯',
        description: s.rank_1_desc,
      );
    } else {
      return (
        rankName: s.rank_0_name,
        icon: '🥙',
        description: s.rank_0_desc,
      );
    }
  }

  int _getUserProgressForMedal(MedalInfo medal) {
    if (medal.category == 'reviews') {
      return _reviewsCount;
    } else {
      return _postsCount;
    }
  }

  void _showMedalDetail(MedalInfo medal) {
    final bool isUnlocked = _medals.contains(medal.id);
    final int userProgress = _getUserProgressForMedal(medal);
    final double progressFraction =
        (userProgress / medal.requiredCount).clamp(0.0, 1.0);
    final int missing = (medal.requiredCount - userProgress).clamp(0, 9999);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Maniglia di trascinamento
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Illustrazione Medaglia con Bagliore
              Stack(
                alignment: Alignment.center,
                children: [
                  if (isUnlocked)
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: yellow.withValues(alpha: 0.45),
                            blurRadius: 30,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  Image.asset(
                    isUnlocked ? medal.assetPath : 'assets/images/empty_medal.png',
                    height: 90,
                    width: 90,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Badge Stato
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? const Color(0xFFE6F4EA)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isUnlocked
                        ? const Color(0xFF34A853)
                        : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isUnlocked ? Icons.check_circle : Icons.lock_outline,
                      size: 15,
                      color: isUnlocked
                          ? const Color(0xFF137333)
                          : Colors.grey[700],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isUnlocked ? S.of(context).goal_reached : S.of(context).in_progress,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isUnlocked
                            ? const Color(0xFF137333)
                            : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Titolo & Sottotitolo
              Text(
                medal.title(S.of(context)),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                medal.subtitle(S.of(context)),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: red,
                ),
              ),
              const SizedBox(height: 14),

              // Descrizione
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Text(
                  medal.description(S.of(context)),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sezione Progresso
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isUnlocked ? const Color(0xFFFFFBF0) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isUnlocked
                        ? const Color(0xFFFFE082)
                        : Colors.grey[200]!,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).progress_label,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          isUnlocked
                              ? '${medal.requiredCount} / ${medal.requiredCount} ${medal.unit(S.of(context))} (100%)'
                              : '$userProgress / ${medal.requiredCount} ${medal.unit(S.of(context))} (${(progressFraction * 100).toInt()}%)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isUnlocked ? const Color(0xFFC47D00) : red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: isUnlocked ? 1.0 : progressFraction,
                        minHeight: 8,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isUnlocked ? const Color(0xFFFFB300) : red,
                        ),
                      ),
                    ),
                    if (!isUnlocked) ...[
                      const SizedBox(height: 8),
                      Text(
                        S.of(context).medal_missing(missing.toString(), medal.unit(S.of(context))),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Bottone Chiudi
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () => Navigator.pop(sheetContext),
                  child: Text(
                    S.of(context).close,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final unlockedCount = _medals.length;
    final totalMedals = allMedalsList.length;
    final rank = _calculateRank(unlockedCount);

    final filteredMedals = allMedalsList.where((m) {
      if (_selectedCategory == 'reviews') return m.category == 'reviews';
      if (_selectedCategory == 'posts') return m.category == 'posts';
      if (_selectedCategory == 'unlocked') return _medals.contains(m.id);
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: red,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).medals_page_title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: red))
          : RefreshIndicator(
              color: red,
              onRefresh: _loadMedalData,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  // 1. Hero Card in Cima
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                      child: _buildHeroCard(
                        unlockedCount: unlockedCount,
                        totalMedals: totalMedals,
                        rank: rank,
                      ),
                    ),
                  ),

                  // 2. Chip di Filtro Categoria
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 48,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          _buildFilterChip(
                            key: 'all',
                            label: S.of(context).filter_all_count(totalMedals.toString()),
                            icon: Icons.grid_view_rounded,
                          ),
                          const SizedBox(width: 8),
                          _buildFilterChip(
                            key: 'reviews',
                            label: S.of(context).filter_reviews_count('5'),
                            icon: Icons.rate_review_outlined,
                          ),
                          const SizedBox(width: 8),
                          _buildFilterChip(
                            key: 'posts',
                            label: S.of(context).community_count('4'),
                            icon: Icons.photo_camera_outlined,
                          ),
                          const SizedBox(width: 8),
                          _buildFilterChip(
                            key: 'unlocked',
                            label: S.of(context).filter_unlocked_count(unlockedCount.toString()),
                            icon: Icons.emoji_events_outlined,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 12)),

                  // 3. Griglia Medaglie
                  if (filteredMedals.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(36.0),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.emoji_events_outlined,
                                  size: 48, color: Colors.grey[400]),
                              const SizedBox(height: 12),
                              Text(
                                S.of(context).no_medals_in_filter,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.82,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final medal = filteredMedals[index];
                            final isUnlocked = _medals.contains(medal.id);
                            final userProgress = _getUserProgressForMedal(medal);
                            return _buildMedalCard(
                              medal: medal,
                              isUnlocked: isUnlocked,
                              userProgress: userProgress,
                            );
                          },
                          childCount: filteredMedals.length,
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  // Hero Card con Anello di Progresso e Rango
  Widget _buildHeroCard({
    required int unlockedCount,
    required int totalMedals,
    required ({String description, String icon, String rankName}) rank,
  }) {
    final double completionFraction =
        (unlockedCount / totalMedals).clamp(0.0, 1.0);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            children: [
              // Anello Circolare con Trofeo
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: CircularProgressIndicator(
                      value: completionFraction,
                      strokeWidth: 6,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(yellow),
                    ),
                  ),
                  Text(
                    rank.icon,
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),
              const SizedBox(width: 16),

              // Rango e Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7E0),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFFFD54F)),
                      ),
                      child: Text(
                        rank.rankName.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFFB06000),
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      S.of(context).unlocked_of_total(unlockedCount.toString(), totalMedals.toString()),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      S.of(context).percent_completed((completionFraction * 100).toInt().toString()),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 10),

          // Statistiche veloci Utente
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatSummaryItem(
                icon: Icons.rate_review_outlined,
                label: S.of(context).reviews_label,
                value: '$_reviewsCount',
              ),
              Container(width: 1, height: 26, color: Colors.grey[300]),
              _buildStatSummaryItem(
                icon: Icons.photo_camera_outlined,
                label: S.of(context).feed_posts_label,
                value: '$_postsCount',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatSummaryItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: red),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip({
    required String key,
    required String label,
    required IconData icon,
  }) {
    final bool isSelected = _selectedCategory == key;

    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = key),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? red : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? red : Colors.grey[300]!,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: red.withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Card Singola Medaglia
  Widget _buildMedalCard({
    required MedalInfo medal,
    required bool isUnlocked,
    required int userProgress,
  }) {
    final double progressFraction =
        (userProgress / medal.requiredCount).clamp(0.0, 1.0);

    return GestureDetector(
      onTap: () => _showMedalDetail(medal),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isUnlocked ? const Color(0xFFFFD54F) : Colors.grey[200]!,
            width: isUnlocked ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isUnlocked
                  ? yellow.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Riga superiore con categoria e badge stato
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  medal.category == 'reviews'
                      ? Icons.rate_review_outlined
                      : Icons.photo_camera_outlined,
                  size: 14,
                  color: Colors.grey[500],
                ),
                if (isUnlocked)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F4EA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, size: 10, color: Color(0xFF137333)),
                        SizedBox(width: 2),
                        Text(
                          S.of(context).unlocked_badge,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF137333),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.lock, size: 11, color: Colors.grey[500]),
                  ),
              ],
            ),

            // Medaglia con alone o lucchetto
            Stack(
              alignment: Alignment.center,
              children: [
                if (isUnlocked)
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: yellow.withValues(alpha: 0.35),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                Image.asset(
                  isUnlocked ? medal.assetPath : 'assets/images/empty_medal.png',
                  height: 56,
                  width: 56,
                ),
              ],
            ),

            // Titolo & Sottotitolo
            Column(
              children: [
                Text(
                  medal.title(S.of(context)),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? Colors.black87 : Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  medal.subtitle(S.of(context)),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isUnlocked ? red : Colors.grey[500],
                  ),
                ),
              ],
            ),

            // Barra di Progresso o Badge di Successo
            if (isUnlocked)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9E6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  S.of(context).completed_badge,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC47D00),
                  ),
                ),
              )
            else
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$userProgress/${medal.requiredCount}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        '${(progressFraction * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progressFraction,
                      minHeight: 5,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progressFraction > 0 ? red : Colors.grey[300]!,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}