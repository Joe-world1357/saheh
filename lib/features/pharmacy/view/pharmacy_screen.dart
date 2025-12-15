import 'package:flutter/material.dart';
import 'drug_details.dart';
import 'cart_screen.dart';
import '../../../shared/widgets/card_widgets.dart';
import 'search_results_screen.dart';
import 'barcode_scanner_screen.dart';
import 'prescription_upload_screen.dart';

class PharmacyScreen
    extends
        StatelessWidget {
  const PharmacyScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    const primary = Color(
      0xFF20C6B7,
    );

    return Scaffold(
      backgroundColor: const Color(
        0xFFF5FAFA,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),

              // TOP BAR --------------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    const Text(
                      "Pharmacy",
                      style: TextStyle(
                        color: Color(
                          0xFF1A2A2C,
                        ),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Color(
                          0xFF1A2A2C,
                        ),
                        size: 24,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: primary,
                        size: 26,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (
                                  _,
                                ) => const CartScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // SEARCH BAR --------------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Color(
                          0xFF9E9E9E,
                        ),
                        size: 22,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SearchResultsScreen(
                                  searchQuery: '',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              "Search drugs, category...",
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              // SCAN BARCODE CARD ------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Scan the Barcode",
                              style: TextStyle(
                                color: Color(
                                  0xFF1A2A2C,
                                ),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              "for faster search",
                              style: TextStyle(
                                color: Color(
                                  0xFF1A2A2C,
                                ),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const BarcodeScannerScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text(
                                "Scan Barcode",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(
                          16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFF5F5F5,
                          ),
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: Icon(
                          Icons.qr_code_scanner,
                          size: 60,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              // UPLOAD PRESCRIPTION CARD ------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Order quickly with",
                              style: TextStyle(
                                color: Color(
                                  0xFF1A2A2C,
                                ),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              "Prescription",
                              style: TextStyle(
                                color: Color(
                                  0xFF1A2A2C,
                                ),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const PrescriptionUploadScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text(
                                "Upload Prescription",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(
                          12,
                        ),
                        child: Image.asset(
                          'assets/prescription.png',
                          width: 70,
                          height: 70,
                          errorBuilder:
                              (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return Icon(
                                  Icons.medication,
                                  size: 70,
                                  color: Colors.grey.shade400,
                                );
                              },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 28,
              ),

              // POPULAR PRODUCT SECTION -------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Popular Product",
                      style: TextStyle(
                        color: Color(
                          0xFF1A2A2C,
                        ),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        color: Color(
                          0xFF20C6B7,
                        ),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  children: [
                    ProductCard(
                      name: "Panadol",
                      size: "20pcs",
                      price: 15.99,
                      primary: primary,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (
                                _,
                              ) => const DrugDetails(
                                img: "",
                                name: "Panadol",
                                size: "20pcs",
                                price: 15.99,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ProductCard(
                      name: "Bodrex Herbal",
                      size: "100ml",
                      price: 7.99,
                      primary: primary,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (
                                _,
                              ) => const DrugDetails(
                                img: "",
                                name: "Bodrex Herbal",
                                size: "100ml",
                                price: 7.99,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ProductCard(
                      name: "Konidin",
                      size: "3pcs",
                      price: 5.99,
                      primary: primary,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (
                                _,
                              ) => const DrugDetails(
                                img: "",
                                name: "Konidin",
                                size: "3pcs",
                                price: 5.99,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 28,
              ),

              // PRODUCT ON SALE SECTION -------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Product on Sale",
                      style: TextStyle(
                        color: Color(
                          0xFF1A2A2C,
                        ),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        color: Color(
                          0xFF20C6B7,
                        ),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  children: [
                    ProductCard(
                      name: "OBH Combi",
                      size: "75ml",
                      price: 9.99,
                      originalPrice: 10.99,
                      primary: primary,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (
                                _,
                              ) => const DrugDetails(
                                img: "",
                                name: "OBH Combi",
                                size: "75ml",
                                price: 9.99,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ProductCard(
                      name: "Betadine",
                      size: "50ml",
                      price: 6.99,
                      originalPrice: 8.99,
                      primary: primary,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (
                                _,
                              ) => const DrugDetails(
                                img: "",
                                name: "Betadine",
                                size: "50ml",
                                price: 6.99,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ProductCard(
                      name: "Bodrexin",
                      size: "75ml",
                      price: 7.99,
                      originalPrice: 9.99,
                      primary: primary,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (
                                _,
                              ) => const DrugDetails(
                                img: "",
                                name: "Bodrexin",
                                size: "75ml",
                                price: 7.99,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
