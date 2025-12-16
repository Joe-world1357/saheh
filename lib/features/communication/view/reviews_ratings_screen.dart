import 'package:flutter/material.dart';

class ReviewsRatingsScreen extends StatefulWidget {
<<<<<<< HEAD
  final String? itemName;
  final String? itemType; // 'product', 'doctor', 'caregiver'

  const ReviewsRatingsScreen({
    super.key,
    this.itemName,
    this.itemType,
=======
  final String? providerName;
  final String? providerType; // 'product', 'doctor', 'caregiver'

  const ReviewsRatingsScreen({
    super.key,
    this.providerName,
    this.providerType,
>>>>>>> 11527b2 (Initial commit)
  });

  @override
  State<ReviewsRatingsScreen> createState() => _ReviewsRatingsScreenState();
}

class _ReviewsRatingsScreenState extends State<ReviewsRatingsScreen> {
  int _selectedFilter = 0; // 0: All, 1: 5 stars, 2: 4 stars, etc.

  final List<Map<String, dynamic>> _reviews = [
    {
      'userName': 'John Smith',
      'rating': 5,
      'date': '2024-11-15',
      'comment': 'Excellent product! Very effective and fast delivery. Highly recommended.',
      'verified': true,
    },
    {
      'userName': 'Sarah Johnson',
      'rating': 4,
      'date': '2024-11-10',
      'comment': 'Good quality product. Works as expected. Delivery was on time.',
      'verified': true,
    },
    {
      'userName': 'Mike Davis',
      'rating': 5,
      'date': '2024-11-05',
      'comment': 'Amazing! This product exceeded my expectations. Will definitely order again.',
      'verified': false,
    },
    {
      'userName': 'Emily Wilson',
      'rating': 3,
      'date': '2024-10-28',
      'comment': 'It\'s okay, but I expected better results. Average quality.',
      'verified': true,
    },
  ];

  double get _averageRating {
    if (_reviews.isEmpty) return 0;
    final sum = _reviews.fold<double>(
      0,
      (sum, review) => sum + (review['rating'] as int).toDouble(),
    );
    return sum / _reviews.length;
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
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      "Reviews & Ratings",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // RATING SUMMARY CARD
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF20C6B7), Color(0xFF17A89A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _averageRating.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return Icon(
                                index < _averageRating.round()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: const Color(0xFFFFC107),
                                size: 24,
                              );
                            }),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '${_reviews.length} Reviews',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // FILTER CHIPS
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip('All', 0),
                          const SizedBox(width: 8),
                          _buildFilterChip('5 Stars', 5),
                          const SizedBox(width: 8),
                          _buildFilterChip('4 Stars', 4),
                          const SizedBox(width: 8),
                          _buildFilterChip('3 Stars', 3),
                          const SizedBox(width: 8),
                          _buildFilterChip('2 Stars', 2),
                          const SizedBox(width: 8),
                          _buildFilterChip('1 Star', 1),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // WRITE REVIEW BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showWriteReviewDialog(context);
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Write a Review'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // REVIEWS LIST
                    const Text(
                      "All Reviews",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    ..._reviews.map((review) => Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: primary.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      color: Color(0xFF20C6B7),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              review['userName'] as String,
                                              style: const TextStyle(
                                                color: Color(0xFF1A2A2C),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            if (review['verified'] as bool) ...[
                                              const SizedBox(width: 8),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF4CAF50)
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Text(
                                                  'Verified',
                                                  style: TextStyle(
                                                    color: Color(0xFF4CAF50),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            ...List.generate(5, (index) {
                                              return Icon(
                                                index < (review['rating'] as int)
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: const Color(0xFFFFC107),
                                                size: 14,
                                              );
                                            }),
                                            const SizedBox(width: 8),
                                            Text(
                                              review['date'] as String,
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                review['comment'] as String,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        )),

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

  Widget _buildFilterChip(String label, int rating) {
    final isSelected = _selectedFilter == rating;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = rating;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF20C6B7) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF20C6B7)
                : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  void _showWriteReviewDialog(BuildContext context) {
    int selectedRating = 5;
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Write a Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Rate your experience'),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRating = index + 1;
                      });
                    },
                    child: Icon(
                      index < selectedRating
                          ? Icons.star
                          : Icons.star_border,
                      color: const Color(0xFFFFC107),
                      size: 32,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  hintText: 'Write your review...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Review submitted successfully'),
                    backgroundColor: Color(0xFF4CAF50),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF20C6B7),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

