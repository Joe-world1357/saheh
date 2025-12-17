import 'dart:convert';
import 'package:http/http.dart' as http;

/// Medicine/Drug model from OpenFDA API
class Medicine {
  final String id;
  final String name;
  final String genericName;
  final String? brandName;
  final String? manufacturer;
  final String? dosageForm;
  final String? route;
  final String? description;
  final String? activeIngredient;
  final String? warnings;
  final String? imageUrl;
  final double price;
  final bool requiresPrescription;
  final String category;

  Medicine({
    required this.id,
    required this.name,
    this.genericName = '',
    this.brandName,
    this.manufacturer,
    this.dosageForm,
    this.route,
    this.description,
    this.activeIngredient,
    this.warnings,
    this.imageUrl,
    required this.price,
    this.requiresPrescription = false,
    this.category = 'General',
  });

  factory Medicine.fromOpenFDA(Map<String, dynamic> json, int index) {
    final openfda = json['openfda'] ?? {};
    final brandNames = openfda['brand_name'] as List? ?? [];
    final genericNames = openfda['generic_name'] as List? ?? [];
    final manufacturers = openfda['manufacturer_name'] as List? ?? [];
    final routes = openfda['route'] as List? ?? [];
    final dosageForms = json['dosage_form'] as List? ?? [];
    
    // Generate a realistic price based on the medicine type
    final basePrice = 5.0 + (index * 2.5) + (brandNames.isNotEmpty ? 10.0 : 0);
    
    return Medicine(
      id: 'med_$index',
      name: brandNames.isNotEmpty ? brandNames.first : (genericNames.isNotEmpty ? genericNames.first : 'Unknown Medicine'),
      genericName: genericNames.isNotEmpty ? genericNames.first : '',
      brandName: brandNames.isNotEmpty ? brandNames.first : null,
      manufacturer: manufacturers.isNotEmpty ? manufacturers.first : null,
      dosageForm: dosageForms.isNotEmpty ? dosageForms.first : null,
      route: routes.isNotEmpty ? routes.first : null,
      description: json['description'] as String? ?? json['indications_and_usage']?.toString(),
      activeIngredient: json['active_ingredient']?.toString(),
      warnings: json['warnings']?.toString(),
      imageUrl: _getMedicineImageUrl(brandNames.isNotEmpty ? brandNames.first : ''),
      price: double.parse(basePrice.toStringAsFixed(2)),
      requiresPrescription: json['product_type'] == 'HUMAN PRESCRIPTION DRUG',
      category: _categorizeByRoute(routes.isNotEmpty ? routes.first : ''),
    );
  }

  static String _getMedicineImageUrl(String name) {
    // Use placeholder images for medicines
    final encoded = Uri.encodeComponent(name.toLowerCase());
    return 'https://via.placeholder.com/200x200.png?text=$encoded';
  }

  static String _categorizeByRoute(String route) {
    switch (route.toUpperCase()) {
      case 'ORAL':
        return 'Oral Medications';
      case 'TOPICAL':
        return 'Skin Care';
      case 'OPHTHALMIC':
        return 'Eye Care';
      case 'NASAL':
        return 'Nasal Care';
      case 'INTRAVENOUS':
      case 'INTRAMUSCULAR':
        return 'Injectables';
      default:
        return 'General';
    }
  }
}

/// Pharmacy service to fetch medicines from OpenFDA API
class PharmacyService {
  static const String _baseUrl = 'https://api.fda.gov/drug';
  
  /// Search medicines by name
  static Future<List<Medicine>> searchMedicines(String query) async {
    if (query.isEmpty) return [];
    
    try {
      final url = '$_baseUrl/label.json?search=openfda.brand_name:"$query"+openfda.generic_name:"$query"&limit=20';
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List? ?? [];
        return results.asMap().entries.map((e) => Medicine.fromOpenFDA(e.value, e.key)).toList();
      }
    } catch (e) {
      // Return fallback data on error
      return _getFallbackMedicines(query);
    }
    
    return _getFallbackMedicines(query);
  }

  /// Get popular/featured medicines
  static Future<List<Medicine>> getPopularMedicines() async {
    try {
      // Get common OTC medicines
      final url = '$_baseUrl/label.json?search=openfda.product_type:"OTC"&limit=15';
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List? ?? [];
        return results.asMap().entries.map((e) => Medicine.fromOpenFDA(e.value, e.key)).toList();
      }
    } catch (e) {
      // Return fallback data
    }
    
    return _getDefaultMedicines();
  }

  /// Get medicines by category
  static Future<List<Medicine>> getMedicinesByCategory(String category) async {
    try {
      String searchTerm;
      switch (category.toLowerCase()) {
        case 'pain relief':
          searchTerm = 'pain+analgesic';
          break;
        case 'cold & flu':
          searchTerm = 'cold+flu+cough';
          break;
        case 'vitamins':
          searchTerm = 'vitamin+supplement';
          break;
        case 'skin care':
          searchTerm = 'topical+skin';
          break;
        case 'digestive':
          searchTerm = 'antacid+digestive';
          break;
        default:
          searchTerm = category;
      }
      
      final url = '$_baseUrl/label.json?search=$searchTerm&limit=10';
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List? ?? [];
        return results.asMap().entries.map((e) => Medicine.fromOpenFDA(e.value, e.key)).toList();
      }
    } catch (e) {
      // Return fallback
    }
    
    return _getDefaultMedicines();
  }

  /// Fallback medicines when API fails
  static List<Medicine> _getFallbackMedicines(String query) {
    final allMeds = _getDefaultMedicines();
    if (query.isEmpty) return allMeds;
    return allMeds.where((m) => 
      m.name.toLowerCase().contains(query.toLowerCase()) ||
      m.genericName.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  /// Default medicine list (offline fallback)
  static List<Medicine> _getDefaultMedicines() {
    return [
      Medicine(
        id: 'med_1',
        name: 'Paracetamol 500mg',
        genericName: 'Acetaminophen',
        brandName: 'Panadol',
        manufacturer: 'GSK',
        dosageForm: 'Tablet',
        route: 'Oral',
        description: 'Pain reliever and fever reducer. Used for headaches, muscle aches, arthritis, backache, toothaches, colds, and fevers.',
        price: 5.99,
        category: 'Pain Relief',
        imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=200',
      ),
      Medicine(
        id: 'med_2',
        name: 'Ibuprofen 400mg',
        genericName: 'Ibuprofen',
        brandName: 'Advil',
        manufacturer: 'Pfizer',
        dosageForm: 'Tablet',
        route: 'Oral',
        description: 'Nonsteroidal anti-inflammatory drug (NSAID) used to reduce fever and treat pain or inflammation.',
        price: 8.49,
        category: 'Pain Relief',
        imageUrl: 'https://images.unsplash.com/photo-1550572017-edd951aa8f72?w=200',
      ),
      Medicine(
        id: 'med_3',
        name: 'Vitamin C 1000mg',
        genericName: 'Ascorbic Acid',
        brandName: 'Nature Made',
        manufacturer: 'Pharmavite',
        dosageForm: 'Tablet',
        route: 'Oral',
        description: 'Essential vitamin for immune system support, skin health, and antioxidant protection.',
        price: 12.99,
        category: 'Vitamins',
        imageUrl: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=200',
      ),
      Medicine(
        id: 'med_4',
        name: 'Omeprazole 20mg',
        genericName: 'Omeprazole',
        brandName: 'Prilosec',
        manufacturer: 'AstraZeneca',
        dosageForm: 'Capsule',
        route: 'Oral',
        description: 'Proton pump inhibitor used to treat gastroesophageal reflux disease (GERD) and stomach ulcers.',
        price: 15.99,
        requiresPrescription: true,
        category: 'Digestive',
        imageUrl: 'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=200',
      ),
      Medicine(
        id: 'med_5',
        name: 'Cetirizine 10mg',
        genericName: 'Cetirizine',
        brandName: 'Zyrtec',
        manufacturer: 'Johnson & Johnson',
        dosageForm: 'Tablet',
        route: 'Oral',
        description: 'Antihistamine used to relieve allergy symptoms such as watery eyes, runny nose, itching, and sneezing.',
        price: 9.99,
        category: 'Allergy',
        imageUrl: 'https://images.unsplash.com/photo-1471864190281-a93a3070b6de?w=200',
      ),
      Medicine(
        id: 'med_6',
        name: 'Amoxicillin 500mg',
        genericName: 'Amoxicillin',
        brandName: 'Amoxil',
        manufacturer: 'GSK',
        dosageForm: 'Capsule',
        route: 'Oral',
        description: 'Antibiotic used to treat bacterial infections including respiratory, ear, and urinary tract infections.',
        price: 18.99,
        requiresPrescription: true,
        category: 'Antibiotics',
        imageUrl: 'https://images.unsplash.com/photo-1585435557343-3b092031a831?w=200',
      ),
      Medicine(
        id: 'med_7',
        name: 'Loratadine 10mg',
        genericName: 'Loratadine',
        brandName: 'Claritin',
        manufacturer: 'Bayer',
        dosageForm: 'Tablet',
        route: 'Oral',
        description: 'Non-drowsy antihistamine for allergy relief. Treats sneezing, runny nose, and itchy eyes.',
        price: 11.49,
        category: 'Allergy',
        imageUrl: 'https://images.unsplash.com/photo-1576602976047-174e57a47881?w=200',
      ),
      Medicine(
        id: 'med_8',
        name: 'Multivitamin Daily',
        genericName: 'Multivitamin',
        brandName: 'Centrum',
        manufacturer: 'Pfizer',
        dosageForm: 'Tablet',
        route: 'Oral',
        description: 'Complete daily multivitamin with essential vitamins and minerals for overall health support.',
        price: 14.99,
        category: 'Vitamins',
        imageUrl: 'https://images.unsplash.com/photo-1559181567-c3190ca9959b?w=200',
      ),
      Medicine(
        id: 'med_9',
        name: 'Aspirin 100mg',
        genericName: 'Acetylsalicylic Acid',
        brandName: 'Bayer Aspirin',
        manufacturer: 'Bayer',
        dosageForm: 'Tablet',
        route: 'Oral',
        description: 'Pain reliever, fever reducer, and anti-inflammatory. Also used for heart attack prevention.',
        price: 6.99,
        category: 'Pain Relief',
        imageUrl: 'https://images.unsplash.com/photo-1550572017-4fcdbb59cc32?w=200',
      ),
      Medicine(
        id: 'med_10',
        name: 'Diphenhydramine 25mg',
        genericName: 'Diphenhydramine',
        brandName: 'Benadryl',
        manufacturer: 'Johnson & Johnson',
        dosageForm: 'Capsule',
        route: 'Oral',
        description: 'Antihistamine for allergy relief and sleep aid. Treats sneezing, itching, and insomnia.',
        price: 7.99,
        category: 'Allergy',
        imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=200',
      ),
      Medicine(
        id: 'med_11',
        name: 'Hydrocortisone Cream 1%',
        genericName: 'Hydrocortisone',
        brandName: 'Cortizone-10',
        manufacturer: 'Chattem',
        dosageForm: 'Cream',
        route: 'Topical',
        description: 'Anti-itch cream for skin irritation, rashes, eczema, and insect bites.',
        price: 8.99,
        category: 'Skin Care',
        imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=200',
      ),
      Medicine(
        id: 'med_12',
        name: 'Calcium + Vitamin D',
        genericName: 'Calcium Carbonate',
        brandName: 'Caltrate',
        manufacturer: 'Pfizer',
        dosageForm: 'Tablet',
        route: 'Oral',
        description: 'Calcium supplement with Vitamin D for bone health and osteoporosis prevention.',
        price: 13.49,
        category: 'Vitamins',
        imageUrl: 'https://images.unsplash.com/photo-1556909114-44e3e70034e2?w=200',
      ),
    ];
  }
}

