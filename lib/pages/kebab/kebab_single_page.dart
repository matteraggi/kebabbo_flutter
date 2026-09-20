import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/misc/single_chart.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/reviews/write_review_page.dart';
import 'package:kebabbo_flutter/utils/image_compressor.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class KebabSinglePage extends StatefulWidget {
  final int kebabId;

  const KebabSinglePage({super.key, required this.kebabId});

  @override
  KebabSinglePageState createState() => KebabSinglePageState();
}

class KebabSinglePageState extends State<KebabSinglePage>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic>? kebabData;
  List<Map<String, dynamic>> reviews = [];
  List<Map<String, dynamic>> taggedPosts = [];
  Map<String, Map<String, dynamic>> userProfiles = {};

  bool isLoading = true;
  bool isFavorite = false;
  late TabController _tabController;

  // View toggle for ratings: 0 = Ufficiale Kebabbo, 1 = Media Community
  int _ratingsViewIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    timeago.setLocaleMessages('it', timeago.ItMessages());
    _fetchAllData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchAllData() async {
    try {
      final currentUserId = supabase.auth.currentUser?.id;

      // 1. Fetch Kebab Details
      final kebabResponse = await supabase
          .from('kebab')
          .select('*')
          .eq('id', widget.kebabId)
          .single();

      // 2. Fetch Reviews for this Kebab
      final reviewsResponse = await supabase
          .from('reviews')
          .select('*')
          .eq('kebabber_id', widget.kebabId.toString())
          .order('created_at', ascending: false);
      final List<Map<String, dynamic>> fetchedReviews =
          List<Map<String, dynamic>>.from(reviewsResponse as List);

      // 3. Fetch Tagged Posts (Community Photos & Posts)
      final postsResponse = await supabase
          .from('posts')
          .select('*')
          .eq('kebab_tag_id', widget.kebabId)
          .filter('comment', 'is', null)
          .order('created_at', ascending: false);
      final List<Map<String, dynamic>> fetchedPosts =
          List<Map<String, dynamic>>.from(postsResponse as List);

      // 4. Check Favorite Status
      bool userIsFavorite = false;
      if (currentUserId != null) {
        final profileRes = await supabase
            .from('profiles')
            .select('favorites')
            .eq('id', currentUserId)
            .maybeSingle();
        if (profileRes != null && profileRes['favorites'] != null) {
          final favList = List<String>.from(profileRes['favorites'] ?? []);
          userIsFavorite = favList.contains(widget.kebabId.toString());
        }
      }

      // 5. Collect User Profiles for Reviewers & Posters
      final Set<String> userIdsToFetch = {};
      for (var r in fetchedReviews) {
        final uid = r['user_id']?.toString();
        if (uid != null && uid.isNotEmpty) userIdsToFetch.add(uid);
      }
      for (var p in fetchedPosts) {
        final uid = p['user_id']?.toString();
        if (uid != null && uid.isNotEmpty) userIdsToFetch.add(uid);
      }

      final Map<String, Map<String, dynamic>> loadedProfiles = {};
      if (userIdsToFetch.isNotEmpty) {
        final profilesRes = await supabase
            .from('profiles')
            .select('id, username, avatar_url')
            .inFilter('id', userIdsToFetch.toList());
        for (var pr in profilesRes) {
          loadedProfiles[pr['id'].toString()] = Map<String, dynamic>.from(pr);
        }
      }

      if (mounted) {
        setState(() {
          kebabData = kebabResponse;
          reviews = fetchedReviews;
          taggedPosts = fetchedPosts;
          userProfiles = loadedProfiles;
          isFavorite = userIsFavorite;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Errore nel caricamento della pagina singolo kebab: $e');
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _toggleFavorite() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Effettua il login per salvare i preferiti')),
      );
      return;
    }

    final newFavoriteState = !isFavorite;
    setState(() {
      isFavorite = newFavoriteState;
    });

    try {
      final profileRes = await supabase
          .from('profiles')
          .select('favorites')
          .eq('id', user.id)
          .single();

      final List<String> currentFavs =
          List<String>.from(profileRes['favorites'] ?? []);
      final String kebabIdStr = widget.kebabId.toString();

      if (newFavoriteState) {
        if (!currentFavs.contains(kebabIdStr)) currentFavs.add(kebabIdStr);
      } else {
        currentFavs.remove(kebabIdStr);
      }

      await supabase
          .from('profiles')
          .update({'favorites': currentFavs}).eq('id', user.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              newFavoriteState
                  ? 'Aggiunto ai preferiti ❤️'
                  : 'Rimosso dai preferiti',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('Errore nel toggle preferiti: $e');
      if (mounted) {
        setState(() => isFavorite = !newFavoriteState);
      }
    }
  }

  Future<void> _openMap() async {
    final mapUrl = kebabData?['map'] ?? kebabData?['mapLink'] ?? '';
    if (mapUrl.toString().trim().isNotEmpty) {
      final uri = Uri.parse(mapUrl.toString());
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return;
      }
    }

    final double? lat = kebabData?['lat'] != null
        ? (kebabData!['lat'] as num).toDouble()
        : null;
    final double? lng = kebabData?['lng'] != null
        ? (kebabData!['lng'] as num).toDouble()
        : null;
    if (lat != null && lng != null) {
      final geoUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
      if (await canLaunchUrl(geoUri)) {
        await launchUrl(geoUri, mode: LaunchMode.externalApplication);
        return;
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mappa non disponibile per questo kebabbaro')),
      );
    }
  }

  void _openWriteReview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WriteReviewPage(
          preselectedKebabId: widget.kebabId,
          preselectedKebabName: kebabData?['name'] ?? '',
        ),
      ),
    ).then((_) => _fetchAllData());
  }

  Future<void> _showAddPhotoSheet() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Effettua il login per pubblicare foto')),
      );
      return;
    }

    final TextEditingController captionController = TextEditingController();
    Uint8List? selectedImageBytes;
    bool isSubmitting = false;

    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            Future<void> pickPhoto() async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.image,
                allowCompression: true,
                withData: true,
              );
              if (result != null && result.files.isNotEmpty) {
                final rawBytes = result.files.single.bytes;
                if (rawBytes != null) {
                  final compressed = await ImageUtils.compressImage(
                    rawBytes,
                    400 * 1024,
                    1200,
                    1200,
                  );
                  setSheetState(() {
                    selectedImageBytes = compressed ?? rawBytes;
                  });
                }
              }
            }

            Future<void> submitPost() async {
              if (selectedImageBytes == null) {
                ScaffoldMessenger.of(sheetContext).showSnackBar(
                  const SnackBar(content: Text('Seleziona una foto prima di pubblicare')),
                );
                return;
              }

              setSheetState(() => isSubmitting = true);
              try {
                final filePath =
                    '${user.id}-${DateTime.now().millisecondsSinceEpoch}.png';
                await supabase.storage.from('posts').uploadBinary(
                      filePath,
                      selectedImageBytes!,
                      fileOptions: const FileOptions(upsert: true),
                    );
                final imageUrl =
                    supabase.storage.from('posts').getPublicUrl(filePath);

                final postPayload = {
                  'text': captionController.text.trim(),
                  'user_id': user.id,
                  'created_at': DateTime.now().toIso8601String(),
                  'like': [],
                  'comments_number': 0,
                  'image_url': imageUrl,
                  'kebab_tag_id': widget.kebabId,
                  'kebab_tag_name': kebabData?['name'] ?? '',
                };

                await supabase.from('posts').insert(postPayload);

                if (!sheetContext.mounted) return;
                Navigator.pop(sheetContext);

                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Foto aggiunta con successo! 📸')),
                );
                _fetchAllData();
              } catch (e) {
                setSheetState(() => isSubmitting = false);
                debugPrint('Errore nel caricamento foto: $e');
                if (sheetContext.mounted) {
                  ScaffoldMessenger.of(sheetContext).showSnackBar(
                    SnackBar(content: Text('Errore durante il caricamento: $e')),
                  );
                }
              }
            }

            final bottomInset = MediaQuery.of(context).viewInsets.bottom;

            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: bottomInset + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Aggiungi Foto a ${kebabData?['name'] ?? 'Kebab'}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(sheetContext),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Image picker area
                  GestureDetector(
                    onTap: pickPhoto,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: selectedImageBytes != null
                              ? red
                              : Colors.grey[300]!,
                          width: selectedImageBytes != null ? 2 : 1,
                        ),
                      ),
                      child: selectedImageBytes != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.memory(
                                    selectedImageBytes!,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black54,
                                      radius: 16,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: const Icon(Icons.edit,
                                            size: 16, color: Colors.white),
                                        onPressed: pickPhoto,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo_outlined,
                                    size: 40, color: Colors.grey[600]),
                                const SizedBox(height: 8),
                                Text(
                                  'Tocca per selezionare una foto',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Caption input
                  TextField(
                    controller: captionController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Scrivi un commento o descrivi il tuo kebab...',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isSubmitting ? null : submitPost,
                      child: isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Pubblica Foto',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _openFullScreenPhoto(Map<String, dynamic> post) {
    final String imageUrl = post['image_url'] ?? '';
    final String caption = post['text'] ?? '';
    final String userId = post['user_id']?.toString() ?? '';
    final profile = userProfiles[userId];
    final String authorName = profile?['username'] ?? 'Utente Kebabbo';
    final String? avatarUrl = profile?['avatar_url'];
    final String createdAt = post['created_at'] ?? '';
    final String timeAgo = createdAt.isNotEmpty
        ? timeago.format(DateTime.parse(createdAt), locale: 'it')
        : '';

    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white24,
                        backgroundImage:
                            avatarUrl != null && avatarUrl.isNotEmpty
                                ? NetworkImage(avatarUrl)
                                : null,
                        child: avatarUrl == null || avatarUrl.isEmpty
                            ? Text(
                                authorName.isNotEmpty
                                    ? authorName[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authorName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          if (timeAgo.isNotEmpty)
                            Text(
                              timeAgo,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Interactive Image
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: InteractiveViewer(
                    maxScale: 4.0,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          height: 300,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(color: red),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        height: 200,
                        color: Colors.black38,
                        child: const Center(
                          child: Icon(Icons.broken_image,
                              color: Colors.white54, size: 48),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Caption
              if (caption.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    caption,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  // Calculate Community Averages from reviews
  ({
    double quality,
    double quantity,
    double price,
    double menu,
    double fun,
    double meat,
    double vegetables,
    double yogurt,
    double spicy,
    double onion,
    double overallRating,
    int count,
  }) _calculateCommunityAverages() {
    if (reviews.isEmpty) {
      return (
        quality: 0.0,
        quantity: 0.0,
        price: 0.0,
        menu: 0.0,
        fun: 0.0,
        meat: 0.0,
        vegetables: 0.0,
        yogurt: 0.0,
        spicy: 0.0,
        onion: 0.0,
        overallRating: 0.0,
        count: 0,
      );
    }

    double totQ = 0, totDim = 0, totP = 0, totM = 0, totF = 0;
    double totMeat = 0, totVeg = 0, totYog = 0, totSpicy = 0, totOnion = 0;

    for (var r in reviews) {
      totQ += (r['quality'] ?? 0).toDouble();
      totDim += (r['quantity'] ?? 0).toDouble();
      totP += (r['price'] ?? 0).toDouble();
      totM += (r['menu'] ?? 0).toDouble();
      totF += (r['fun'] ?? 0).toDouble();

      totMeat += (r['meat'] ?? 0).toDouble();
      totVeg += (r['vegetables'] ?? 0).toDouble();
      totYog += (r['yogurt'] ?? 0).toDouble();
      totSpicy += (r['spicy'] ?? 0).toDouble();
      totOnion += (r['onion'] ?? 0).toDouble();
    }

    final c = reviews.length.toDouble();
    final avgQ = totQ / c;
    final avgDim = totDim / c;
    final avgP = totP / c;
    final avgM = totM / c;
    final avgF = totF / c;

    final overall = (avgQ + avgDim + avgP + avgM + avgF) / 5.0;

    return (
      quality: avgQ,
      quantity: avgDim,
      price: avgP,
      menu: avgM,
      fun: avgF,
      meat: totMeat / c,
      vegetables: totVeg / c,
      yogurt: totYog / c,
      spicy: totSpicy / c,
      onion: totOnion / c,
      overallRating: overall,
      count: reviews.length,
    );
  }

  String? _findCoverPhotoUrl() {
    // 1. First photo from tagged posts
    for (var p in taggedPosts) {
      final img = p['image_url'];
      if (img != null && img.toString().isNotEmpty) {
        return img.toString();
      }
    }
    return null;
  }

  String? _getCardAssetPath() {
    final name = kebabData?['name'] ?? '';
    if (name.isEmpty) return null;
    final kebabberId = name.toString().toLowerCase().replaceAll(' ', '-');
    return 'assets/kebab-card/$kebabberId.png';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: red,
          foregroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Center(
          child: CircularProgressIndicator(color: red),
        ),
      );
    }

    if (kebabData == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: red,
          foregroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Center(
          child: Text('Kebabbaro non trovato o rimosso.'),
        ),
      );
    }

    final String name = kebabData!['name'] ?? 'Kebab Sconosciuto';
    final bool isOpen = isKebabOpen(kebabData?['orari_apertura']);
    final bool isGlutenFree = kebabData!['gluten_free'] ?? false;
    final double officialRating =
        (kebabData!['rating'] ?? 0.0).toDouble();

    final communityAverages = _calculateCommunityAverages();
    final String? coverPhotoUrl = _findCoverPhotoUrl();
    final String? cardAssetPath = _getCardAssetPath();
    final List<Map<String, dynamic>> photosList = taggedPosts
        .where((p) => p['image_url'] != null && p['image_url'].toString().isNotEmpty)
        .toList();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 250.0,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              backgroundColor: red,
              foregroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.bookmark : Icons.bookmark_border,
                    color: isFavorite ? const Color(0xFFFFBA1C) : Colors.white,
                  ),
                  tooltip: isFavorite ? 'Rimuovi dai preferiti' : 'Salva nei preferiti',
                  onPressed: _toggleFavorite,
                ),
                IconButton(
                  icon: const Icon(Icons.map_outlined),
                  tooltip: 'Apri Mappa',
                  onPressed: _openMap,
                ),
              ],
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final settings = context
                      .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
                  final double t = settings != null &&
                          settings.maxExtent > settings.minExtent
                      ? ((settings.maxExtent - settings.currentExtent) /
                              (settings.maxExtent - settings.minExtent))
                          .clamp(0.0, 1.0)
                      : 0.0;
                  // Transizione fluida:
                  // - quando espanso (t = 0.0): left 16, right 16 (occupa tutta la larghezza dell'immagine)
                  // - quando collassato nella topbar rossa (t = 1.0): left 72 (spazio perfetto oltre il back button), right 100 (prima dei pulsanti azioni)
                  final double leftPadding =
                      Tween<double>(begin: 16.0, end: 72.0).transform(t);
                  final double rightPadding =
                      Tween<double>(begin: 16.0, end: 100.0).transform(t);

                  return FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(
                      left: leftPadding,
                      bottom: 16,
                      right: rightPadding,
                    ),
                    centerTitle: false,
                    title: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        shadows: [
                          Shadow(
                            color: Colors.black87,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Background image (Community photo, or Card asset, or signature Gradient)
                        if (coverPhotoUrl != null)
                          Image.network(
                            coverPhotoUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _buildFallbackHeader(),
                          )
                        else if (cardAssetPath != null)
                          Image.asset(
                            cardAssetPath,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _buildFallbackHeader(),
                          )
                        else
                          _buildFallbackHeader(),

                        // Dark gradient for text readability
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.45),
                                Colors.black.withValues(alpha: 0.15),
                                Colors.black.withValues(alpha: 0.85),
                              ],
                              stops: const [0.0, 0.4, 1.0],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Persistent Header with Quick Info & Action Buttons
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status row (Aperto/Chiuso, Glutine Free, Rating)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        // Open status chip
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isOpen
                                ? const Color(0xFFE6F4EA)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isOpen
                                  ? const Color(0xFF34A853)
                                  : Colors.grey[400]!,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: isOpen
                                    ? const Color(0xFF34A853)
                                    : Colors.grey[600],
                              ),
                              const SizedBox(width: 6),
                              Text(
                                isOpen ? 'Aperto' : 'Chiuso',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isOpen
                                      ? const Color(0xFF137333)
                                      : Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Gluten Free badge
                        if (isGlutenFree)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF7E0),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFF9AB00),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.grain,
                                    size: 14, color: Color(0xFFB06000)),
                                SizedBox(width: 4),
                                Text(
                                  'Senza Glutine',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFB06000),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Kebabbo Rating badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFECEB),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star,
                                  size: 14, color: Color(0xFFFFBA1C)),
                              const SizedBox(width: 4),
                              Text(
                                '${officialRating.toStringAsFixed(1)} Kebabbo',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: red,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Community Rating badge
                        if (communityAverages.count > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.people_alt,
                                    size: 14, color: Colors.blue[700]),
                                const SizedBox(width: 4),
                                Text(
                                  '${communityAverages.overallRating.toStringAsFixed(1)} (${communityAverages.count})',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Action buttons row (Indicazioni, Recensisci, Aggiungi Foto)
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            icon: Icons.directions_outlined,
                            label: 'Mappa',
                            color: const Color(0xFF1A73E8),
                            onTap: _openMap,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildActionButton(
                            icon: Icons.rate_review_outlined,
                            label: 'Recensisci',
                            color: red,
                            onTap: _openWriteReview,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildActionButton(
                            icon: Icons.add_a_photo_outlined,
                            label: 'Foto',
                            color: const Color(0xFFE37400),
                            onTap: _showAddPhotoSheet,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Pinned Tab Bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: red,
                  unselectedLabelColor: Colors.grey[600],
                  indicatorColor: red,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  tabs: [
                    const Tab(text: 'Panoramica'),
                    Tab(text: 'Foto (${photosList.length})'),
                    Tab(text: 'Recensioni (${reviews.length})'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOverviewTab(communityAverages),
            _buildPhotosTab(photosList),
            _buildReviewsTab(communityAverages),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [red, Color(0xFF8B0000)],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.restaurant,
          size: 80,
          color: Colors.white.withValues(alpha: 0.25),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 1: PANORAMICA (Overview)
  // ---------------------------------------------------------------------------
  Widget _buildOverviewTab(communityAverages) {
    final String description =
        kebabData?['description'] ?? 'Nessuna descrizione disponibile.';
    final orariMap = kebabData?['orari_apertura'];

    // Official stats
    final double offQ = (kebabData?['quality'] ?? 0.0).toDouble();
    final double offDim = (kebabData?['dimension'] ?? 0.0).toDouble();
    final double offP = (kebabData?['price'] ?? 0.0).toDouble();
    final double offM = (kebabData?['menu'] ?? 0.0).toDouble();
    final double offF = (kebabData?['fun'] ?? 0.0).toDouble();

    // Ingredients
    final double offVeg = (kebabData?['vegetables'] ?? 0.0).toDouble();
    final double offYog = (kebabData?['yogurt'] ?? 0.0).toDouble();
    final double offSpicy = (kebabData?['spicy'] ?? 0.0).toDouble();
    final double offOnion = (kebabData?['onion'] ?? 0.0).toDouble();

    final bool isCommunity = _ratingsViewIndex == 1;
    final double q = isCommunity ? communityAverages.quality : offQ;
    final double dim = isCommunity ? communityAverages.quantity : offDim;
    final double p = isCommunity ? communityAverages.price : offP;
    final double m = isCommunity ? communityAverages.menu : offM;
    final double f = isCommunity ? communityAverages.fun : offF;

    final double veg = isCommunity ? communityAverages.vegetables : offVeg;
    final double yog = isCommunity ? communityAverages.yogurt : offYog;
    final double spicy = isCommunity ? communityAverages.spicy : offSpicy;
    final double onion = isCommunity ? communityAverages.onion : offOnion;
    final bool hasIngredients = veg > 0 || yog > 0 || spicy > 0 || onion > 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Description Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.format_quote, color: red, size: 20),
                    SizedBox(width: 6),
                    Text(
                      'La recensione di Kebabbo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.45,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 2. Ratings Comparison Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Valutazione',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Toggle: Kebabbo vs Community
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        children: [
                          _buildToggleItem(
                            label: 'Kebabbo',
                            isSelected: _ratingsViewIndex == 0,
                            onTap: () => setState(() => _ratingsViewIndex = 0),
                          ),
                          _buildToggleItem(
                            label: 'Community (${communityAverages.count})',
                            isSelected: _ratingsViewIndex == 1,
                            onTap: () => setState(() => _ratingsViewIndex = 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 5 Pillars Rating Bars
                _buildStatBar(
                  label: S.of(context).quality,
                  value: q,
                  color: const Color(0xFF4CAF50),
                ),
                _buildStatBar(
                  label: S.of(context).price,
                  value: p,
                  color: const Color(0xFF2196F3),
                ),
                _buildStatBar(
                  label: S.of(context).quantity,
                  value: dim,
                  color: const Color(0xFFFF9800),
                ),
                _buildStatBar(
                  label: S.of(context).menu,
                  value: m,
                  color: const Color(0xFF9C27B0),
                ),
                _buildStatBar(
                  label: S.of(context).fun,
                  value: f,
                  color: const Color(0xFFE91E63),
                ),

                if (hasIngredients) ...[
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),

                  // Ingredients Balance
                  const Text(
                    'Bilanciamento Ingredienti',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Center(
                    child: SingleChart(
                      vegetables: veg,
                      yogurt: yog,
                      spicy: spicy,
                      onion: onion,
                      isFront: true,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 3. Opening Hours Card
          _buildOpeningHoursCard(orariMap),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildToggleItem({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? red : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBar({
    required String label,
    required double value,
    required Color color,
  }) {
    // Value is typically 0 to 5, normalized to 0.0 - 1.0
    final double normalized = (value / 5.0).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: normalized,
                minHeight: 10,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 32,
            child: Text(
              value.toStringAsFixed(1),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpeningHoursCard(dynamic orariMap) {
    if (orariMap == null || orariMap is! Map) {
      return const SizedBox.shrink();
    }

    final daysOrder = [
      'lunedì',
      'martedì',
      'mercoledì',
      'giovedì',
      'venerdì',
      'sabato',
      'domenica'
    ];

    final currentWeekdayIndex = DateTime.now().weekday; // 1 = lunedì, 7 = domenica
    final String currentDayName = daysOrder[currentWeekdayIndex - 1];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.schedule, color: red, size: 20),
              SizedBox(width: 8),
              Text(
                'Orari di Apertura',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final day in daysOrder) ...[
            if (orariMap.containsKey(day)) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (day == currentDayName) ...[
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF34A853),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          '${day[0].toUpperCase()}${day.substring(1)}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: day == currentDayName
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: day == currentDayName
                                ? Colors.black
                                : Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      orariMap[day].toString(),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: day == currentDayName
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: day == currentDayName
                            ? red
                            : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              if (day != daysOrder.last)
                Divider(height: 8, color: Colors.grey[200]),
            ],
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 2: FOTO DELLA COMMUNITY (Photos)
  // ---------------------------------------------------------------------------
  Widget _buildPhotosTab(List<Map<String, dynamic>> photosList) {
    if (photosList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.photo_camera_outlined, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              const Text(
                'Nessuna foto ancora',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sii il primo a condividere una foto della tua piadina o del tuo piatto in questo locale!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _showAddPhotoSheet,
                icon: const Icon(Icons.add_a_photo, size: 18),
                label: const Text('Carica la prima foto'),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: photosList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.95,
        ),
        itemBuilder: (context, index) {
          final post = photosList[index];
          final String imgUrl = post['image_url'] ?? '';
          final String userId = post['user_id']?.toString() ?? '';
          final profile = userProfiles[userId];
          final String author = profile?['username'] ?? 'Utente';

          return GestureDetector(
            onTap: () => _openFullScreenPhoto(post),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      imgUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: red,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),

                    // Gradient overlay with author
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.75),
                            ],
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.person,
                                size: 12, color: Colors.white70),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                author,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 3: RECENSIONI COMMUNITY (Reviews)
  // ---------------------------------------------------------------------------
  Widget _buildReviewsTab(communityAverages) {
    if (reviews.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.rate_review_outlined, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              const Text(
                'Nessuna recensione ancora',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Condividi la tua esperienza in questo kebabbaro con tutta la community!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _openWriteReview,
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('Scrivi la prima recensione'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: reviews.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        // Header summary banner
        if (index == 0) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      communityAverages.overallRating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: red,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (i) {
                        final starVal = i + 1;
                        final double score = communityAverages.overallRating;
                        if (score >= starVal) {
                          return const Icon(Icons.star,
                              size: 18, color: Color(0xFFFFBA1C));
                        } else if (score >= starVal - 0.5) {
                          return const Icon(Icons.star_half,
                              size: 18, color: Color(0xFFFFBA1C));
                        } else {
                          return const Icon(Icons.star_border,
                              size: 18, color: Color(0xFFFFBA1C));
                        }
                      }),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Basato su ${reviews.length} recensioni',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _openWriteReview,
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Recensisci'),
                ),
              ],
            ),
          );
        }

        // Single review item
        final review = reviews[index - 1];
        final String userId = review['user_id']?.toString() ?? '';
        final profile = userProfiles[userId];
        final String author = profile?['username'] ?? 'Utente Anonimo';
        final String? avatarUrl = profile?['avatar_url'];
        final String description = review['description']?.toString() ?? '';
        final String createdAt = review['created_at']?.toString() ?? '';

        final String timeAgo = createdAt.isNotEmpty
            ? timeago.format(DateTime.parse(createdAt), locale: 'it')
            : '';

        // Calculate single review score
        final double q = (review['quality'] ?? 0.0).toDouble();
        final double dim = (review['quantity'] ?? 0.0).toDouble();
        final double p = (review['price'] ?? 0.0).toDouble();
        final double m = (review['menu'] ?? 0.0).toDouble();
        final double f = (review['fun'] ?? 0.0).toDouble();
        final double avgScore = (q + dim + p + m + f) / 5.0;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Author header
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: red.withValues(alpha: 0.1),
                    backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                        ? NetworkImage(avatarUrl)
                        : null,
                    child: avatarUrl == null || avatarUrl.isEmpty
                        ? Text(
                            author.isNotEmpty ? author[0].toUpperCase() : '?',
                            style: const TextStyle(
                              color: red,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          author,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        if (timeAgo.isNotEmpty)
                          Text(
                            timeAgo,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Score pill
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFFFD54F)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star,
                            size: 14, color: Color(0xFFFFBA1C)),
                        const SizedBox(width: 3),
                        Text(
                          avgScore.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Comment text
              if (description.trim().isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.grey[800],
                  ),
                ),
              ],

              // Pillar pills
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  _buildMiniStatChip('Qualità', q),
                  _buildMiniStatChip('Prezzo', p),
                  _buildMiniStatChip('Quantità', dim),
                  if (m > 0) _buildMiniStatChip('Menu', m),
                  if (f > 0) _buildMiniStatChip('Fun', f),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMiniStatChip(String label, double val) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$label: ${val.toStringAsFixed(1)}',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}

// Helper delegate for persistent TabBar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
