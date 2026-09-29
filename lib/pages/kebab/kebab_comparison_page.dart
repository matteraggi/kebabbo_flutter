import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/kebab/kebab_single_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class KebabComparisonPage extends StatefulWidget {
  final int? initialKebabId;

  const KebabComparisonPage({super.key, this.initialKebabId});

  @override
  State<KebabComparisonPage> createState() => _KebabComparisonPageState();
}

class _KebabComparisonPageState extends State<KebabComparisonPage> {
  final SupabaseClient _supabase = Supabase.instance.client;

  bool _isLoadingAllKebabs = true;
  List<Map<String, dynamic>> _allKebabs = [];

  Map<String, dynamic>? _kebabA;
  Map<String, dynamic>? _kebabB;
  bool _isLoadingA = false;
  bool _isLoadingB = false;

  Map<String, double>? _statsA;
  Map<String, double>? _statsB;

  @override
  void initState() {
    super.initState();
    _fetchAllKebabs();
    if (widget.initialKebabId != null) {
      _loadKebabDetails(widget.initialKebabId!, isSlotA: true);
    }
  }

  Future<void> _fetchAllKebabs() async {
    try {
      final response = await _supabase
          .from('kebab')
          .select('id, name, tag')
          .order('name', ascending: true);

      final list = List<Map<String, dynamic>>.from(response as List);
      if (mounted) {
        setState(() {
          _allKebabs = list;
          _isLoadingAllKebabs = false;
        });
      }
    } catch (e) {
      debugPrint('Errore nel caricamento della lista kebab: $e');
      if (mounted) {
        setState(() => _isLoadingAllKebabs = false);
      }
    }
  }

  Future<void> _loadKebabDetails(int kebabId, {required bool isSlotA}) async {
    if (isSlotA) {
      setState(() => _isLoadingA = true);
    } else {
      setState(() => _isLoadingB = true);
    }

    try {
      final kebabRes = await _supabase
          .from('kebab')
          .select('*')
          .eq('id', kebabId)
          .single();

      final reviewsRes = await _supabase
          .from('reviews')
          .select('*')
          .eq('kebabber_id', kebabId.toString());
      final reviews = List<Map<String, dynamic>>.from(reviewsRes as List);

      final stats = _computeKebabStats(kebabRes, reviews);

      if (mounted) {
        setState(() {
          if (isSlotA) {
            _kebabA = kebabRes;
            _statsA = stats;
            _isLoadingA = false;
          } else {
            _kebabB = kebabRes;
            _statsB = stats;
            _isLoadingB = false;
          }
        });
      }
    } catch (e) {
      debugPrint('Errore nel caricamento dei dettagli del kebab $kebabId: $e');
      if (mounted) {
        setState(() {
          if (isSlotA) {
            _isLoadingA = false;
          } else {
            _isLoadingB = false;
          }
        });
      }
    }
  }

  Map<String, double> _computeKebabStats(
    Map<String, dynamic> kebab,
    List<Map<String, dynamic>> reviews,
  ) {
    final bool isCommunity = kebab['added_by'] != null && kebab['is_staff'] != true;

    if (reviews.isNotEmpty && isCommunity) {
      double totQ = 0, totDim = 0, totP = 0, totM = 0, totF = 0;
      double totMeat = 0, totVeg = 0, totYog = 0, totSpicy = 0, totOnion = 0;

      for (var r in reviews) {
        totQ += (r['quality'] as num?)?.toDouble() ?? 0.0;
        totDim += (r['quantity'] as num?)?.toDouble() ?? 0.0;
        totP += (r['price'] as num?)?.toDouble() ?? 0.0;
        totM += (r['menu'] as num?)?.toDouble() ?? 0.0;
        totF += (r['fun'] as num?)?.toDouble() ?? 0.0;

        totMeat += (r['meat'] as num?)?.toDouble() ?? 0.0;
        totVeg += (r['vegetables'] as num?)?.toDouble() ?? 0.0;
        totYog += (r['yogurt'] as num?)?.toDouble() ?? 0.0;
        totSpicy += (r['spicy'] as num?)?.toDouble() ?? 0.0;
        totOnion += (r['onion'] as num?)?.toDouble() ?? 0.0;
      }

      final c = reviews.length.toDouble();
      final q = totQ / c;
      final dim = totDim / c;
      final p = totP / c;
      final m = totM / c;
      final f = totF / c;

      return {
        'quality': q,
        'dimension': dim,
        'price': p,
        'menu': m,
        'fun': f,
        'overall': (q + dim + p + m) / 4.0,
        'meat': totMeat / c,
        'vegetables': totVeg / c,
        'yogurt': totYog / c,
        'spicy': totSpicy / c,
        'onion': totOnion / c,
        'reviewsCount': c,
      };
    }

    final q = (kebab['quality'] as num?)?.toDouble() ?? 0.0;
    final dim = (kebab['dimension'] as num?)?.toDouble() ?? 0.0;
    final p = (kebab['price'] as num?)?.toDouble() ?? 0.0;
    final m = (kebab['menu'] as num?)?.toDouble() ?? 0.0;
    final f = (kebab['fun'] as num?)?.toDouble() ?? 0.0;
    final overall = (kebab['rating'] as num?)?.toDouble() ?? ((q + dim + p + m) / 4.0);

    return {
      'quality': q,
      'dimension': dim,
      'price': p,
      'menu': m,
      'fun': f,
      'overall': overall,
      'meat': (kebab['meat'] as num?)?.toDouble() ?? 5.0,
      'vegetables': (kebab['vegetables'] as num?)?.toDouble() ?? 5.0,
      'yogurt': (kebab['yogurt'] as num?)?.toDouble() ?? 5.0,
      'spicy': (kebab['spicy'] as num?)?.toDouble() ?? 5.0,
      'onion': (kebab['onion'] as num?)?.toDouble() ?? 5.0,
      'reviewsCount': reviews.length.toDouble(),
    };
  }

  void _showKebabPicker({required bool isSlotA}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (context, setModalState) {
            final filtered = _allKebabs.where((k) {
              final name = (k['name'] ?? '').toString().toLowerCase();
              final tag = (k['tag'] ?? '').toString().toLowerCase();
              final query = searchQuery.trim().toLowerCase();
              return name.contains(query) || tag.contains(query);
            }).toList();

            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: S.of(context).search_kebab_to_compare,
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onChanged: (val) {
                        setModalState(() {
                          searchQuery = val;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: _isLoadingAllKebabs
                        ? const Center(child: CircularProgressIndicator())
                        : filtered.isEmpty
                            ? Center(
                                child: Text(
                                  S.of(context).kebab_place_not_found,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              )
                            : ListView.separated(
                            itemCount: filtered.length,
                            separatorBuilder: (_, __) =>
                                const Divider(height: 1, indent: 16, endIndent: 16),
                            itemBuilder: (context, idx) {
                              final item = filtered[idx];
                              final id = item['id'];
                              final name = item['name'] ?? 'Kebab';
                              final tag = (item['tag'] ?? '').toString();
                              final isSelected = (isSlotA && _kebabA?['id'] == id) ||
                                  (!isSlotA && _kebabB?['id'] == id);

                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: yellow,
                                  child: const Icon(Icons.kebab_dining, color: Colors.black87),
                                ),
                                title: Text(
                                  name,
                                  style: TextStyle(
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                  ),
                                ),
                                subtitle: tag.isNotEmpty
                                    ? Text(
                                        tag.toUpperCase(),
                                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                                      )
                                    : null,
                                trailing: isSelected
                                    ? const Icon(Icons.check_circle, color: red)
                                    : const Icon(Icons.chevron_right, color: Colors.grey),
                                onTap: () {
                                  Navigator.of(ctx).pop();
                                  _loadKebabDetails(id as int, isSlotA: isSlotA);
                                },
                              );
                            },
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

  String? _getCardAssetPath(String? name) {
    if (name == null || name.isEmpty) return null;
    final kebabberId = name.toLowerCase().replaceAll(' ', '-');
    return 'assets/kebab-card/$kebabberId.png';
  }

  Widget _buildKebabCardSlot({
    required bool isSlotA,
    required Map<String, dynamic>? kebab,
    required bool isLoading,
  }) {
    final title = isSlotA
        ? S.of(context).select_first_kebab
        : S.of(context).select_second_kebab;

    if (isLoading) {
      return Expanded(
        child: Container(
          height: 190,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: const Center(child: CircularProgressIndicator(color: red)),
        ),
      );
    }

    if (kebab == null) {
      return Expanded(
        child: InkWell(
          onTap: () => _showKebabPicker(isSlotA: isSlotA),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 190,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black12, width: 1.5),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: yellow.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 32, color: Colors.black87),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final String name = kebab['name'] ?? 'Kebab';
    final String tag = (kebab['tag'] ?? '').toString();
    final String? cardAsset = _getCardAssetPath(name);

    return Expanded(
      child: Container(
        height: 190,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image / Card Header
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (cardAsset != null)
                    Image.asset(
                      cardAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildFallbackImage(),
                    )
                  else
                    _buildFallbackImage(),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: InkWell(
                      onTap: () => _showKebabPicker(isSlotA: isSlotA),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black87.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.swap_horiz, size: 14, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              S.of(context).change,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
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
            // Info Body
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (tag.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        tag.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackImage() {
    return Container(
      color: const Color(0xFFF1F1F1),
      child: const Center(
        child: Icon(Icons.kebab_dining, size: 36, color: Colors.grey),
      ),
    );
  }

  Widget _buildComparisonBarRow({
    required String label,
    required double valA,
    required double valB,
    required double maxVal,
  }) {
    final double safeA = valA.clamp(0.0, maxVal);
    final double safeB = valB.clamp(0.0, maxVal);
    final bool aWins = safeA > safeB;
    final bool bWins = safeB > safeA;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                safeA.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: aWins ? FontWeight.bold : FontWeight.w600,
                  color: aWins ? const Color(0xFF2E7D32) : Colors.black87,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                safeB.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: bWins ? FontWeight.bold : FontWeight.w600,
                  color: bWins ? const Color(0xFF2E7D32) : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              // Bar A (flows from right to left or standard)
              Expanded(
                child: RotatedBox(
                  quarterTurns: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: maxVal > 0 ? safeA / maxVal : 0,
                      minHeight: 8,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF4CAF50),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Bar B (flows left to right)
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: maxVal > 0 ? safeB / maxVal : 0,
                    minHeight: 8,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF1976D2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfoRow() {
    final bool isGlutenFreeA = _kebabA?['gluten_free'] == true;
    final bool isGlutenFreeB = _kebabB?['gluten_free'] == true;
    final bool isStaffA = _kebabA?['is_staff'] == true || _kebabA?['added_by'] == null;
    final bool isStaffB = _kebabB?['is_staff'] == true || _kebabB?['added_by'] == null;

    final double ratingA = _statsA?['overall'] ?? 0.0;
    final double ratingB = _statsB?['overall'] ?? 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: [
          // Overall Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFFFBA1C), size: 22),
                  const SizedBox(width: 4),
                  Text(
                    ratingA.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ratingA >= ratingB ? const Color(0xFF2E7D32) : Colors.black87,
                    ),
                  ),
                ],
              ),
              const Text(
                'Rating',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  Text(
                    ratingB.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ratingB >= ratingA ? const Color(0xFF2E7D32) : Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, color: Color(0xFFFFBA1C), size: 22),
                ],
              ),
            ],
          ),
          const Divider(height: 20),
          // Gluten Free
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBadge(
                label: isGlutenFreeA ? S.of(context).gluten_free : 'No',
                color: isGlutenFreeA ? const Color(0xFFB37400) : Colors.grey,
              ),
              Text(S.of(context).gluten_free, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              _buildBadge(
                label: isGlutenFreeB ? S.of(context).gluten_free : 'No',
                color: isGlutenFreeB ? const Color(0xFFB37400) : Colors.grey,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Staff Verified
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBadge(
                label: isStaffA ? 'Staff Kebabbo' : 'Community',
                color: isStaffA ? const Color(0xFF1D9BF0) : Colors.purple,
              ),
              const Text('Origine', style: TextStyle(fontSize: 12, color: Colors.grey)),
              _buildBadge(
                label: isStaffB ? 'Staff Kebabbo' : 'Community',
                color: isStaffB ? const Color(0xFF1D9BF0) : Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool bothSelected = _kebabA != null && _kebabB != null;

    return Scaffold(
      backgroundColor: yellow,
      appBar: AppBar(
        title: Text(
          S.of(context).compare_kebabs,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Selector Cards Slot A vs Slot B
              Row(
                children: [
                  _buildKebabCardSlot(
                    isSlotA: true,
                    kebab: _kebabA,
                    isLoading: _isLoadingA,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'VS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: red,
                      ),
                    ),
                  ),
                  _buildKebabCardSlot(
                    isSlotA: false,
                    kebab: _kebabB,
                    isLoading: _isLoadingB,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              if (!bothSelected)
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.compare_arrows, size: 48, color: red),
                      const SizedBox(height: 12),
                      Text(
                        S.of(context).select_two_kebabs_to_compare,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        icon: const Icon(Icons.search),
                        label: Text(
                          _kebabA == null
                              ? S.of(context).select_first_kebab
                              : S.of(context).select_second_kebab,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => _showKebabPicker(isSlotA: _kebabA == null),
                      ),
                    ],
                  ),
                )
              else ...[
                // 2. Panoramica & Status Info
                _buildQuickInfoRow(),
                const SizedBox(height: 16),

                // 3. I 5 Pilastri
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        S.of(context).pillars_comparison,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      _buildComparisonBarRow(
                        label: S.of(context).quality,
                        valA: _statsA?['quality'] ?? 0.0,
                        valB: _statsB?['quality'] ?? 0.0,
                        maxVal: 5.0,
                      ),
                      _buildComparisonBarRow(
                        label: S.of(context).dimension,
                        valA: _statsA?['dimension'] ?? 0.0,
                        valB: _statsB?['dimension'] ?? 0.0,
                        maxVal: 5.0,
                      ),
                      _buildComparisonBarRow(
                        label: S.of(context).price,
                        valA: _statsA?['price'] ?? 0.0,
                        valB: _statsB?['price'] ?? 0.0,
                        maxVal: 5.0,
                      ),
                      _buildComparisonBarRow(
                        label: S.of(context).menu,
                        valA: _statsA?['menu'] ?? 0.0,
                        valB: _statsB?['menu'] ?? 0.0,
                        maxVal: 5.0,
                      ),
                      _buildComparisonBarRow(
                        label: S.of(context).fun,
                        valA: _statsA?['fun'] ?? 0.0,
                        valB: _statsB?['fun'] ?? 0.0,
                        maxVal: 5.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 4. Ingredienti (1-10)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        S.of(context).ingredients_comparison,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      _buildComparisonBarRow(
                        label: S.of(context).meat,
                        valA: _statsA?['meat'] ?? 5.0,
                        valB: _statsB?['meat'] ?? 5.0,
                        maxVal: 10.0,
                      ),
                      _buildComparisonBarRow(
                        label: S.of(context).vegetables,
                        valA: _statsA?['vegetables'] ?? 5.0,
                        valB: _statsB?['vegetables'] ?? 5.0,
                        maxVal: 10.0,
                      ),
                      _buildComparisonBarRow(
                        label: S.of(context).yogurt,
                        valA: _statsA?['yogurt'] ?? 5.0,
                        valB: _statsB?['yogurt'] ?? 5.0,
                        maxVal: 10.0,
                      ),
                      _buildComparisonBarRow(
                        label: S.of(context).spicy,
                        valA: _statsA?['spicy'] ?? 5.0,
                        valB: _statsB?['spicy'] ?? 5.0,
                        maxVal: 10.0,
                      ),
                      _buildComparisonBarRow(
                        label: S.of(context).onion,
                        valA: _statsA?['onion'] ?? 5.0,
                        valB: _statsB?['onion'] ?? 5.0,
                        maxVal: 10.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 5. Pulsanti per navigare alla scheda singolo kebab
                Row(
                  children: [
                    Expanded(
                      child: Tooltip(
                        message: '${S.of(context).details} ${_kebabA!['name'] ?? ''}',
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: red,
                            elevation: 2,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(color: red, width: 1.5),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => KebabSinglePage(kebabId: _kebabA!['id']),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.info_outline, size: 18),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  _kebabA!['name'] ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Tooltip(
                        message: '${S.of(context).details} ${_kebabB!['name'] ?? ''}',
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: red,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => KebabSinglePage(kebabId: _kebabB!['id']),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.info_outline, size: 18),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  _kebabB!['name'] ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
