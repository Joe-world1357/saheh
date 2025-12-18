import 'package:flutter/material.dart';
import 'drug_details.dart';
import '../../../shared/widgets/card_widgets.dart';
import '../../../shared/widgets/network_image_widget.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';

class SearchResultsScreen extends StatefulWidget {
  final String searchQuery;

  const SearchResultsScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _currentQuery = '';
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _allProducts = [
    {
      'name': 'Panadol',
      'size': '20pcs',
      'price': 15.99,
      'category': 'Pain Relief',
      'inStock': true,
      'imageUrl': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400',
    },
    {
      'name': 'Bodrex Herbal',
      'size': '100ml',
      'price': 7.99,
      'category': 'Herbal',
      'inStock': true,
    },
    {
      'name': 'Konidin',
      'size': '3pcs',
      'price': 5.99,
      'category': 'Cold & Flu',
      'inStock': true,
    },
    {
      'name': 'OBH Combi',
      'size': '75ml',
      'price': 9.99,
      'category': 'Cough',
      'inStock': true,
    },
    {
      'name': 'Betadine',
      'size': '50ml',
      'price': 6.99,
      'category': 'Antiseptic',
      'inStock': true,
    },
    {
      'name': 'Bodrexin',
      'size': '75ml',
      'price': 7.99,
      'category': 'Cough',
      'inStock': false,
    },
    {
      'name': 'Paracetamol',
      'size': '10 tablets',
      'price': 3.99,
      'category': 'Pain Relief',
      'inStock': true,
    },
    {
      'name': 'Ibuprofen',
      'size': '20 tablets',
      'price': 8.99,
      'category': 'Pain Relief',
      'inStock': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    var filtered = _allProducts;

    if (_currentQuery.isNotEmpty) {
      filtered = filtered
          .where((product) =>
              product['name']
                  .toString()
                  .toLowerCase()
                  .contains(_currentQuery.toLowerCase()) ||
              product['category']
                  .toString()
                  .toLowerCase()
                  .contains(_currentQuery.toLowerCase()))
          .toList();
    }

    if (_selectedFilter != 'All') {
      filtered = filtered
          .where((product) => product['category'] == _selectedFilter)
          .toList();
    }

    return filtered;
  }

  List<String> get _categories {
    final categories = _allProducts
        .map((product) => product['category'] as String)
        .toSet()
        .toList();
    categories.insert(0, 'All');
    return categories;
  }

  @override
  void initState() {
    super.initState();
    _currentQuery = widget.searchQuery;
    _searchController.text = widget.searchQuery;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final primary = AppColors.getPrimary(brightness);
    final errorColor = AppColors.getError(brightness);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: false,
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search drugs, category...",
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              icon: Icon(
                Icons.search,
                color: theme.colorScheme.onSurfaceVariant,
                size: 22,
              ),
            ),
            onChanged: (value) {
              setState(() {
                _currentQuery = value;
              });
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // FILTER CHIPS
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedFilter == category;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = category;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? primary : theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(25),
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

            const SizedBox(height: 8),

            // RESULTS COUNT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    "${_filteredProducts.length} result${_filteredProducts.length != 1 ? 's' : ''} found",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // PRODUCTS LIST
            Expanded(
              child: _filteredProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No products found",
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Try a different search term",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: AppCard(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                // PRODUCT IMAGE
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.medication,
                                    size: 30,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // PRODUCT INFO
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              product['name'] as String,
                                              style: theme.textTheme.bodyLarge?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          if (!product['inStock'] as bool)
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: errorColor.withValues(alpha: 0.1),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                "Out of stock",
                                                style: theme.textTheme.labelSmall?.copyWith(
                                                  color: errorColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        product['size'] as String,
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: theme.colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        product['category'] as String,
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: theme.colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            "\$${product['price'].toStringAsFixed(2)}",
                                            style: theme.textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          if (product['inStock'] as bool)
                                            FilledButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => DrugDetails(
                                                      imageUrl: product['imageUrl'] as String?,
                                                      name: product['name'] as String,
                                                      size: product['size'] as String,
                                                      price: product['price'] as double,
                                                    ),
                                                  ),
                                                );
                                              },
                                              style: FilledButton.styleFrom(
                                                backgroundColor: primary,
                                                foregroundColor: Colors.white,
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 8,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                                                ),
                                              ),
                                              child: Text(
                                                "View",
                                                style: theme.textTheme.bodySmall?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
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
    );
  }
}
