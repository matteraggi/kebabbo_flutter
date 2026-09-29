import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kebabbo_flutter/components/list_items/feed_list_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/feed&socials/followers_page.dart';
import 'package:kebabbo_flutter/pages/feed&socials/seguiti_page.dart';
import 'package:kebabbo_flutter/pages/kebab/kebab_single_page.dart';
import 'package:kebabbo_flutter/pages/misc/medal_page.dart';
import 'package:kebabbo_flutter/utils/tcg_stamina.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:timeago/timeago.dart' as timeago;

class SingleUserPage extends StatefulWidget {
  final String userId;

  const SingleUserPage({super.key, required this.userId});

  @override
  State<SingleUserPage> createState() => _SingleUserPageState();
}

class _SingleUserPageState extends State<SingleUserPage> {
  String _username = "";
  String? _avatarUrl;
  int _postCount = 0;
  bool _loading = true;
  bool _isUpdatingFollow = false;
  List<dynamic> _followed = [];
  List<Map<String, dynamic>> _userPosts = [];
  List<Map<String, dynamic>> _userReviews = [];
  bool _isFollowing = false;
  int _seguitiCount = 0;
  int _followerCount = 0;
  Map<String, dynamic>? _favoriteKebab;
  List<int> _medals = [];
  int _tcgCardsCount = 0;
  int _selectedTab = 0; // 0 = Post, 1 = Recensioni

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() => _loading = true);

    try {
      final currentUserId = supabase.auth.currentUser?.id;

      final futures = <Future<dynamic>>[
        supabase.from('profiles').select().eq('id', widget.userId).single(),
        if (currentUserId != null)
          supabase
              .from('profiles')
              .select('followed_users')
              .eq('id', currentUserId)
              .maybeSingle()
        else
          Future.value(null),
        supabase
            .from('profiles')
            .select('id')
            .contains('followed_users', [widget.userId]),
        supabase
            .from('posts')
            .select('*')
            .eq('user_id', widget.userId)
            .filter('comment', 'is', null)
            .order('created_at', ascending: false),
        supabase
            .from('reviews')
            .select('*')
            .eq('user_id', widget.userId)
            .order('created_at', ascending: false),
      ];

      final results = await Future.wait(futures);
      final profileData = results[0] as Map<String, dynamic>;
      final currentUserProfile = results[1] as Map<String, dynamic>?;
      final followersList = results[2] as List;
      final postsList = results[3] as List;
      final reviewsList = results[4] as List;

      // Kebab preferito
      Map<String, dynamic>? favoriteKebab;
      final rawFavKebab = profileData['favorite_kebab'];
      if (rawFavKebab != null &&
          rawFavKebab != 0 &&
          rawFavKebab != '0' &&
          rawFavKebab.toString().trim().isNotEmpty) {
        final favResponse = await supabase
            .from('kebab')
            .select('id, name, description, rating, tag')
            .eq('id', rawFavKebab)
            .maybeSingle();
        favoriteKebab = favResponse;
      }

      // Risolvi i dati dei kebab per le recensioni
      final List<Map<String, dynamic>> rawReviews =
          List<Map<String, dynamic>>.from(reviewsList);
      final kebabIds = rawReviews
          .map((r) => r['kebabber_id']?.toString())
          .where((id) => id != null && id.isNotEmpty && id != '0')
          .toSet()
          .toList();

      if (kebabIds.isNotEmpty) {
        final kebabResponse = await supabase
            .from('kebab')
            .select('id, name, rating, tag')
            .inFilter('id', kebabIds);

        final Map<String, dynamic> kebabMap = {
          for (var k in kebabResponse) k['id'].toString(): k
        };

        for (var rev in rawReviews) {
          final kid = rev['kebabber_id']?.toString();
          if (kid != null && kebabMap.containsKey(kid)) {
            rev['kebab_name'] = kebabMap[kid]['name'];
            rev['kebab_rating'] = kebabMap[kid]['rating'];
            rev['kebab_tag'] = kebabMap[kid]['tag'];
          }
        }
      }

      final followedUsers =
          List<dynamic>.from(currentUserProfile?['followed_users'] ?? []);
      final medals = List<int>.from(profileData['medals'] ?? []);
      final tcgList = List<dynamic>.from(profileData['tcg'] ?? []);
      final tcgCount = TcgCardsHelper.countCollected(tcgList);

      if (mounted) {
        setState(() {
          _username = profileData['username'] ?? '';
          _avatarUrl = profileData['avatar_url'];
          _followed = followedUsers;
          _isFollowing = followedUsers.contains(widget.userId);
          _seguitiCount = (profileData['followed_users'] != null)
              ? (profileData['followed_users'] as List).length
              : 0;
          _followerCount = followersList.length;
          _postCount = postsList.length;
          _userPosts = List<Map<String, dynamic>>.from(postsList);
          _userReviews = rawReviews;
          _favoriteKebab = favoriteKebab;
          _medals = medals;
          _tcgCardsCount = tcgCount;
          _loading = false;
        });
      }
    } catch (error) {
      debugPrint("Error loading profile: $error");
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).failed_to_load_profile)),
        );
      }
    }
  }

  Future<void> _toggleFollow() async {
    final currentUser = supabase.auth.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Accedi per seguire questo utente")),
      );
      return;
    }

    setState(() => _isUpdatingFollow = true);

    final updatedFollowed = List<dynamic>.from(_followed);
    final bool newIsFollowing = !_isFollowing;

    if (_isFollowing) {
      updatedFollowed.remove(widget.userId);
    } else {
      if (!updatedFollowed.contains(widget.userId)) {
        updatedFollowed.add(widget.userId);
      }
    }

    try {
      await supabase.from('profiles').update({
        'followed_users': updatedFollowed,
      }).eq('id', currentUser.id);

      if (mounted) {
        setState(() {
          _followed = updatedFollowed;
          _isFollowing = newIsFollowing;
          if (newIsFollowing) {
            _followerCount++;
          } else {
            _followerCount = (_followerCount > 0) ? _followerCount - 1 : 0;
          }
          _isUpdatingFollow = false;
        });
        HapticFeedback.lightImpact();
      }
    } catch (error) {
      if (mounted) {
        setState(() => _isUpdatingFollow = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).failed_to_update_follow_status)),
        );
      }
    }
  }

  void _showAvatarDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: (_avatarUrl != null && _avatarUrl!.isNotEmpty)
                      ? Image.network(
                          _avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Image.asset(
                            'assets/new-logos/logo scritta ad arco sfondo giallo-1.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          'assets/new-logos/logo scritta ad arco sfondo giallo-1.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 16),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded,
                    color: Colors.white, size: 30),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openFavoriteKebab() {
    if (_favoriteKebab == null || _favoriteKebab!['id'] == null) return;
    final int kebabId = int.tryParse(_favoriteKebab!['id'].toString()) ?? 0;
    if (kebabId == 0) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => KebabSinglePage(kebabId: kebabId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelf = supabase.auth.currentUser != null &&
        supabase.auth.currentUser!.id == widget.userId;

    return Scaffold(
      backgroundColor: yellow,
      appBar: AppBar(
        backgroundColor: yellow,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black87,
                size: 18,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          _username.isNotEmpty ? "@$_username" : "",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Clipboard.setData(ClipboardData(
                    text: "https://kebabbo.top/user/${widget.userId}"));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Link del profilo copiato negli appunti!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.share_outlined,
                  color: Colors.black87,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: red),
            )
          : RefreshIndicator(
              onRefresh: _loadAllData,
              color: red,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // HERO PROFILE CARD
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                      child: Column(
                        children: [
                          // AVATAR CON DOPPIO ANELLO ACCENT
                          GestureDetector(
                            onTap: _showAvatarDialog,
                            child: Container(
                              width: 104,
                              height: 104,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [red, yellow],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: red.withValues(alpha: 0.25),
                                    blurRadius: 14,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(3.5),
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(2.5),
                                child: CircleAvatar(
                                  radius: 46,
                                  backgroundColor: const Color(0xFFEEEEEE),
                                  backgroundImage: (_avatarUrl != null &&
                                          _avatarUrl!.isNotEmpty)
                                      ? NetworkImage(_avatarUrl!)
                                      : const AssetImage(
                                              'assets/new-logos/logo scritta ad arco sfondo giallo-1.png')
                                          as ImageProvider,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // USERNAME
                          Text(
                            _username,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                              letterSpacing: -0.5,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // BADGES ROW (Medaglie & Carte TCG)
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              if (_medals.isNotEmpty)
                                InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MedalPage(userId: widget.userId),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF9E6),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: const Color(0xFFFFE082)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.emoji_events_rounded,
                                          size: 15,
                                          color: Color(0xFFD49B00),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${_medals.length} ${S.of(context).objectives}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF8A6500),
                                          ),
                                        ),
                                        const SizedBox(width: 3),
                                        const Icon(
                                          Icons.chevron_right_rounded,
                                          size: 14,
                                          color: Color(0xFFD49B00),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (_tcgCardsCount > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3F0FF),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: const Color(0xFFD8CCFF)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.style_rounded,
                                        size: 15,
                                        color: Color(0xFF6B46C1),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "$_tcgCardsCount Carte TCG",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF553C9A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // TASTO AZIONE (SEGUI / SEGUITO)
                          if (!isSelf)
                            SizedBox(
                              width: double.infinity,
                              height: 46,
                              child: _isFollowing
                                  ? OutlinedButton.icon(
                                      onPressed: _isUpdatingFollow
                                          ? null
                                          : _toggleFollow,
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFF4F4F6),
                                        side: const BorderSide(
                                            color: Color(0xFFE4E4E7)),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(26),
                                        ),
                                      ),
                                      icon: _isUpdatingFollow
                                          ? const SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.black54,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.check_rounded,
                                              size: 18,
                                              color: Colors.black87,
                                            ),
                                      label: Text(
                                        S.of(context).segui_gia,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    )
                                  : ElevatedButton.icon(
                                      onPressed: _isUpdatingFollow
                                          ? null
                                          : _toggleFollow,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: red,
                                        elevation: 2,
                                        shadowColor: red.withValues(alpha: 0.4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(26),
                                        ),
                                      ),
                                      icon: _isUpdatingFollow
                                          ? const SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.person_add_rounded,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                      label: Text(
                                        S.of(context).segui,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            )
                          else
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F3F5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.person_outline_rounded,
                                      size: 16, color: Colors.grey.shade700),
                                  const SizedBox(width: 6),
                                  Text(
                                    "Il tuo profilo",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // STATS CARD A 4 COLONNE
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x08000000),
                            blurRadius: 12,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border:
                            Border.all(color: Colors.black.withValues(alpha: 0.04)),
                      ),
                      child: Row(
                        children: [
                          _buildStatItem(
                            label: S.of(context).posts,
                            value: "$_postCount",
                            onTap: () {
                              setState(() => _selectedTab = 0);
                            },
                          ),
                          _buildStatDivider(),
                          _buildStatItem(
                            label: "Recensioni",
                            value: "${_userReviews.length}",
                            onTap: () {
                              setState(() => _selectedTab = 1);
                            },
                          ),
                          _buildStatDivider(),
                          _buildStatItem(
                            label: S.of(context).followers,
                            value: "$_followerCount",
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FollowersPage(userId: widget.userId),
                                ),
                              );
                            },
                          ),
                          _buildStatDivider(),
                          _buildStatItem(
                            label: S.of(context).seguiti,
                            value: "$_seguitiCount",
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SeguitiPage(userId: widget.userId),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // KEBAB PREFERITO SPOTLIGHT CARD
                    if (_favoriteKebab != null && _favoriteKebab!.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onTap: _openFavoriteKebab,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFFFFFBF0),
                                    Colors.white,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: const Color(0xFFFFE082), width: 1.2),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x0A000000),
                                    blurRadius: 10,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Icona tag/food
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: yellow.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      _favoriteKebab!["tag"] == "sandwich"
                                          ? "assets/images/sandwitch.png"
                                          : "assets/images/kebabcolored.png",
                                      height: 30,
                                      width: 30,
                                      errorBuilder: (_, __, ___) => const Icon(
                                        Icons.restaurant,
                                        color: red,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "👑 ",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            Text(
                                              "KEBAB DEL CUORE",
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.amber.shade900,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          _favoriteKebab!["name"] ??
                                              S.of(context).nome_non_disponibile,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (_favoriteKebab!["rating"] != null)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.star_rounded,
                                                  size: 15,
                                                  color: yellow,
                                                ),
                                                const SizedBox(width: 3),
                                                Text(
                                                  "${(_favoriteKebab!["rating"] as num).toStringAsFixed(1)} stelle",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.04),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.chevron_right_rounded,
                                      color: Colors.black54,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // TAB BAR (POST / RECENSIONI)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedTab = 0),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: _selectedTab == 0
                                      ? red
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(26),
                                  boxShadow: _selectedTab == 0
                                      ? [
                                          BoxShadow(
                                            color: red.withValues(alpha: 0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.photo_library_outlined,
                                      size: 17,
                                      color: _selectedTab == 0
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "${S.of(context).posts} (${_userPosts.length})",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: _selectedTab == 0
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedTab = 1),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: _selectedTab == 1
                                      ? red
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(26),
                                  boxShadow: _selectedTab == 1
                                      ? [
                                          BoxShadow(
                                            color: red.withValues(alpha: 0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star_outline_rounded,
                                      size: 18,
                                      color: _selectedTab == 1
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Recensioni (${_userReviews.length})",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: _selectedTab == 1
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // CONTENUTO TAB ATTIVA
                    if (_selectedTab == 0)
                      _buildPostsTab(isSelf)
                    else
                      _buildReviewsTab(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildPostsTab(bool isSelf) {
    if (_userPosts.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                color: Color(0xFFF6F6F8),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.photo_library_outlined,
                size: 38,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              "Nessun post ancora",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Questo utente non ha ancora pubblicato post nel feed.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      itemCount: _userPosts.length,
      itemBuilder: (context, index) {
        final post = _userPosts[index];
        final int postId = int.tryParse(post['id']?.toString() ?? '0') ?? 0;
        final int kebabTagId =
            int.tryParse(post['kebab_tag_id']?.toString() ?? '0') ?? 0;

        return FeedListItem(
          key: ValueKey("post_$postId"),
          text: post['text'] ?? S.of(context).testo_non_disponibile,
          createdAt: post['created_at'] ?? '',
          userId: post['user_id']?.toString() ?? '',
          imageUrl: post['image_url'] ?? '',
          postId: postId,
          likeList: post['like'] ?? [],
          commentNumber: post['comments_number'] ?? 0,
          kebabTagId: kebabTagId,
          kebabName: post['kebab_tag_name'] ?? '',
          canBeEliminated: isSelf,
        );
      },
    );
  }

  Widget _buildReviewsTab() {
    if (_userReviews.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                color: Color(0xFFF6F6F8),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.rate_review_outlined,
                size: 38,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              "Nessuna recensione ancora",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Questo utente non ha ancora recensito nessun kebab.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      itemCount: _userReviews.length,
      itemBuilder: (context, index) {
        final rev = _userReviews[index];
        final kebabName = rev['kebab_name'] ?? "Kebabbaro";
        final kebabAddress = rev['kebab_address'];
        final kebabTag = rev['kebab_tag'] ?? 'kebab';
        final int kebabId =
            int.tryParse(rev['kebabber_id']?.toString() ?? '0') ?? 0;

        // Calcolo media recensione (esclude il divertimento)
        final q = (rev['quality'] as num?)?.toDouble() ?? 0.0;
        final p = (rev['price'] as num?)?.toDouble() ?? 0.0;
        final dim = (rev['quantity'] as num?)?.toDouble() ?? 0.0;
        final m = (rev['menu'] as num?)?.toDouble() ?? 0.0;
        final double avgRating = (q + p + dim + m) / 4.0;

        String formattedDate = '';
        if (rev['created_at'] != null) {
          try {
            final dt = DateTime.parse(rev['created_at'].toString());
            formattedDate = timeago.format(dt, locale: 'it');
          } catch (_) {
            formattedDate = rev['created_at'].toString().split('T').first;
          }
        }

        final comment = rev['comment']?.toString();

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
            border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              onTap: () {
                if (kebabId > 0) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => KebabSinglePage(kebabId: kebabId),
                    ),
                  );
                }
              },
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Recensione: Icona + Nome + Voto
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: yellow.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            kebabTag == "sandwich"
                                ? "assets/images/sandwitch.png"
                                : "assets/images/kebabcolored.png",
                            height: 24,
                            width: 24,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.restaurant,
                              color: red,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                kebabName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (kebabAddress != null &&
                                  kebabAddress.toString().isNotEmpty)
                                Text(
                                  kebabAddress.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 4),
                          decoration: BoxDecoration(
                            color: yellow.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: Color(0xFFE5A100),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                avgRating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF8A6500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    if (comment != null && comment.trim().isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(
                        comment,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.35,
                        ),
                      ),
                    ],

                    const SizedBox(height: 10),

                    // Rating breakdown chips
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (q > 0) _buildMiniRatingChip("Qualità", q),
                        if (dim > 0) _buildMiniRatingChip("Porzione", dim),
                        if (p > 0) _buildMiniRatingChip("Prezzo", p),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Footer data e navigazione
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (formattedDate.isNotEmpty)
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        else
                          const SizedBox(),
                        Row(
                          children: [
                            Text(
                              "Vedi locale",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: red,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 11,
                              color: red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMiniRatingChip(String label, double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$label: ${rating.toStringAsFixed(1)}",
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 24,
      width: 1,
      color: const Color(0xFFEAEAED),
    );
  }
}
