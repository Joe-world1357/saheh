import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import 'drug_details.dart';
import 'cart_screen.dart';
import '../../../shared/widgets/card_widgets.dart';
import 'search_results_screen.dart';
import 'barcode_scanner_screen.dart';
import 'prescription_upload_screen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/xp_redemption_provider.dart';
import '../../../core/localization/localization_helper.dart';

class PharmacyScreen extends ConsumerStatefulWidget {
  const PharmacyScreen({super.key});

  @override
  ConsumerState<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends ConsumerState<PharmacyScreen> {
  String _selectedCategory = 'All';

  List<String> _getCategories(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.all,
      l10n.painRelief,
      l10n.coldAndFlu,
      l10n.vitamins,
      l10n.herbal,
      l10n.antiseptic,
      l10n.cough,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final l10n = AppLocalizations.of(context)!;
    final primary = AppColors.getPrimary(brightness);
    final infoColor = AppColors.getInfo(brightness);
    final successColor = AppColors.getSuccess(brightness);
    final cartItems = ref.watch(cartProvider);
    final cartCount = cartItems.length;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowDark.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Top Bar
                  Row(
                    children: [
                      Text(
                        l10n.pharmacy,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Stack(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: theme.colorScheme.onSurface,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const CartScreen()),
                              );
                            },
                          ),
                          if (cartCount > 0)
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Center(
                                  child: Text(
                                    cartCount > 9 ? '9+' : '$cartCount',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Search Bar
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SearchResultsScreen(searchQuery: ''),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l10n.searchMedicines,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.mic_outlined,
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // CONTENT
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Quick Actions
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildQuickActionCard(
                              context,
                              icon: Icons.qr_code_scanner,
                              title: l10n.barcodeScanner,
                              subtitle: l10n.scanAndOrder,
                              color: primary,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const BarcodeScannerScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildQuickActionCard(
                              context,
                              icon: Icons.upload_file,
                              title: "Prescription",
                              subtitle: "Upload & order",
                              color: infoColor,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const PrescriptionUploadScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // XP Redemption Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final user = ref.watch(userProvider);
                          final userXP = user?.xp ?? 0;
                          
                          return AppCard(
                            padding: const EdgeInsets.all(16),
                            backgroundColor: AppColors.getPrimary(brightness).withValues(alpha: 0.1),
                            border: Border.all(
                              color: AppColors.getPrimary(brightness).withValues(alpha: 0.3),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: AppColors.getPrimary(brightness),
                                      size: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              l10n.redeemXPPoints,
                                              style: theme.textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              l10n.yourXP(userXP),
                                              style: theme.textTheme.bodySmall?.copyWith(
                                                color: theme.colorScheme.onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton.icon(
                                      onPressed: () => _showXPRedemptionDialog(context, ref, userXP),
                                      icon: Icon(
                                        Icons.card_giftcard,
                                        color: AppColors.getPrimary(brightness),
                                      ),
                                      label: Text(
                                        l10n.viewRedemptions,
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          color: AppColors.getPrimary(brightness),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      side: BorderSide(
                                        color: AppColors.getPrimary(brightness),
                                        width: 1.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Categories
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _getCategories(context).length,
                        itemBuilder: (context, index) {
                          final categories = _getCategories(context);
                          final category = categories[index];
                          final isSelected = _selectedCategory == category;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? primary
                                    : theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                                border: Border.all(
                                  color: isSelected
                                      ? primary
                                      : theme.colorScheme.outline.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  category,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : theme.colorScheme.onSurface,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Popular Products
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.popularProducts,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              l10n.seeAll,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          final products = [
                            {
                              'name': 'Panadol',
                              'size': '20pcs',
                              'price': 15.99,
                              'imageUrl': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400',
                            },
                            {
                              'name': 'Bodrex Herbal',
                              'size': '100ml',
                              'price': 7.99,
                              'imageUrl': 'https://images.unsplash.com/photo-1559757148-5c3507e8e6d4?w=400',
                            },
                            {
                              'name': 'Konidin',
                              'size': '3pcs',
                              'price': 5.99,
                              'imageUrl': 'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=400',
                            },
                            {
                              'name': 'OBH Combi',
                              'size': '75ml',
                              'price': 9.99,
                              'imageUrl': 'https://images.unsplash.com/photo-1550572017-edd951b55104?w=400',
                            },
                            {
                              'name': 'Betadine',
                              'size': '50ml',
                              'price': 6.99,
                              'imageUrl': 'https://images.unsplash.com/photo-1607613009820-a29f7bb81c04?w=400',
                            },
                          ];

                          final product = products[index % products.length];

                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ProductCard(
                              name: product['name'] as String,
                              size: product['size'] as String,
                              price: product['price'] as double,
                              primary: primary,
                              imageUrl: product['imageUrl'] as String,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DrugDetails(
                                    imageUrl: product['imageUrl'] as String,
                                    name: product['name'] as String,
                                    size: product['size'] as String,
                                    price: product['price'] as double,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Products on Sale
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.local_offer,
                                color: successColor,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                l10n.specialOffers,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              l10n.seeAll,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          final saleProducts = [
                            {
                              'name': 'OBH Combi',
                              'size': '75ml',
                              'price': 9.99,
                              'originalPrice': 12.99,
                              'imageUrl': 'https://images.unsplash.com/photo-1550572017-edd951b55104?w=400',
                            },
                            {
                              'name': 'Betadine',
                              'size': '50ml',
                              'price': 6.99,
                              'originalPrice': 8.99,
                              'imageUrl': 'https://images.unsplash.com/photo-1607613009820-a29f7bb81c04?w=400',
                            },
                            {
                              'name': 'Bodrexin',
                              'size': '75ml',
                              'price': 7.99,
                              'originalPrice': 9.99,
                              'imageUrl': 'https://images.unsplash.com/photo-1559757148-5c3507e8e6d4?w=400',
                            },
                          ];

                          final product = saleProducts[index % saleProducts.length];

                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ProductCard(
                              name: product['name'] as String,
                              size: product['size'] as String,
                              price: product['price'] as double,
                              originalPrice: product['originalPrice'] as double?,
                              primary: primary,
                              imageUrl: product['imageUrl'] as String,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DrugDetails(
                                    imageUrl: product['imageUrl'] as String,
                                    name: product['name'] as String,
                                    size: product['size'] as String,
                                    price: product['price'] as double,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return AppCard(
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showXPRedemptionDialog(BuildContext context, WidgetRef ref, int userXP) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final l10n = AppLocalizations.of(context)!;
    final primary = AppColors.getPrimary(brightness);
    final successColor = AppColors.getSuccess(brightness);
    final errorColor = AppColors.getError(brightness);

    // Available redemptions
    final redemptions = [
      {
        'type': 'discount',
        'name': l10n.percentOffOrder(10),
        'description': l10n.getPercentDiscount(10),
        'xpCost': 100,
        'discountCode': 'XP10OFF',
      },
      {
        'type': 'discount',
        'name': l10n.percentOffOrder(20),
        'description': l10n.getPercentDiscount(20),
        'xpCost': 250,
        'discountCode': 'XP20OFF',
      },
      {
        'type': 'product',
        'name': l10n.freeProduct('Panadol'),
        'description': l10n.redeemFreeProduct('Panadol (20pcs)'),
        'xpCost': 150,
        'productId': 'panadol_20',
      },
      {
        'type': 'service',
        'name': l10n.freeDelivery,
        'description': l10n.freeDeliveryDesc,
        'xpCost': 75,
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        ),
        title: Row(
          children: [
            Icon(Icons.star, color: primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.redeemXPPoints,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: Row(
                  children: [
                    Icon(Icons.account_balance_wallet, color: primary),
                    const SizedBox(width: 8),
                    Text(
                      l10n.yourXP(userXP),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.availableRedemptions,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: redemptions.length,
                  itemBuilder: (context, index) {
                    final redemption = redemptions[index];
                    final xpCost = redemption['xpCost'] as int;
                    final canAfford = userXP >= xpCost;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AppCard(
                        padding: const EdgeInsets.all(12),
                        backgroundColor: canAfford
                            ? null
                            : theme.colorScheme.surfaceContainerHighest,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        redemption['name'] as String,
                                        style: theme.textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        redemption['description'] as String,
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: theme.colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: canAfford
                                        ? primary.withValues(alpha: 0.15)
                                        : errorColor.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: canAfford ? primary : errorColor,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '$xpCost XP',
                                        style: theme.textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: canAfford ? primary : errorColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: canAfford
                                    ? () async {
                                        final success = await ref
                                            .read(xpRedemptionProvider.notifier)
                                            .redeemXP(
                                          redemptionType: redemption['type'] as String,
                                          itemName: redemption['name'] as String,
                                          itemDescription: redemption['description'] as String,
                                          xpCost: xpCost,
                                          discountCode: redemption['discountCode'] as String?,
                                          productId: redemption['productId'] as String?,
                                        );

                                        if (context.mounted) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                success
                                                    ? 'Redemption successful!'
                                                    : 'Redemption failed. Please try again.',
                                              ),
                                              backgroundColor: success
                                                  ? successColor
                                                  : errorColor,
                                            ),
                                          );
                                        }
                                      }
                                    : null,
                                style: FilledButton.styleFrom(
                                  backgroundColor: canAfford ? primary : null,
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                                  ),
                                ),
                                child: Text(
                                  canAfford ? l10n.redeem : l10n.insufficientXP,
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: canAfford
                                        ? Colors.white
                                        : theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.close,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
