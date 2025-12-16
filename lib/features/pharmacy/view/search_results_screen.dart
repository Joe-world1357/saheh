import 'package:flutter/material.dart';
import 'drug_details.dart';
import '../../../shared/widgets/card_widgets.dart';
import '../../../shared/widgets/network_image_widget.dart';

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
      'imageUrl': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400', // Example URL
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

    // Filter by search query
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

    // Filter by category
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
    const primary = Color(0xFF20C6B7);

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFA),
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF1A2A2C),
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: false,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search drugs, category...",
                          hintStyle: TextStyle(
                            color: Color(0xFFBDBDBD),
                            fontSize: 14,
                          ),
                          icon: Icon(
                            Icons.search,
                            color: Color(0xFF9E9E9E),
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
                ],
              ),
            ),

            // FILTER CHIPS
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        color: isSelected ? primary : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected ? primary : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF1A2A2C),
                            fontSize: 14,
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "${_filteredProducts.length} result${_filteredProducts.length != 1 ? 's' : ''} found",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
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
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No products found",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Try a different search term",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          child: Row(
                            children: [
                              // PRODUCT IMAGE
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.medication,
                                  size: 30,
                                  color: Colors.grey.shade400,
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
                                            style: const TextStyle(
                                              color: Color(0xFF1A2A2C),
                                              fontSize: 16,
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
                                              color: Colors.red.shade50,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Text(
                                              "Out of stock",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product['size'] as String,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product['category'] as String,
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${product['price'].toStringAsFixed(2)}",
                                          style: const TextStyle(
                                            color: Color(0xFF1A2A2C),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        if (product['inStock'] as bool)
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>                                                   DrugDetails(
                                                    imageUrl: product['imageUrl'] as String?,
                                                    name: product['name'] as String,
                                                    size: product['size'] as String,
                                                    price: product['price'] as double,
                                                  ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: primary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 8,
                                              ),
                                            ),
                                            child: const Text(
                                              "View",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
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


