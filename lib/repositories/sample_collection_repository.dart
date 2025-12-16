import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sample_collection_services.dart';
import '../models/sample_collection_requests.dart';

class SampleCollectionRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _services =>
      _db.collection('sample_collection_services');

  CollectionReference<Map<String, dynamic>> get _requests =>
      _db.collection('sample_collection_requests');

  /// Get all available sample collection services
  Future<List<SampleCollectionService>> getServices() async {
    final snapshot = await _services.get();

    return snapshot.docs
        .map(
          (d) => SampleCollectionService.fromMap(d.data(), d.id),
        )
        .toList();
  }

  /// Create or update a sample collection request
  Future<void> saveRequest(
    SampleCollectionRequest request,
  ) async {
    await _requests.doc(request.id).set(
          request.toMap(),
          SetOptions(merge: true),
        );
  }

  /// Get requests for a user
  Future<List<SampleCollectionRequest>> getUserRequests(
    String userId,
  ) async {
    final snapshot = await _requests
        .where('user_id', isEqualTo: userId)
        .orderBy('request_date', descending: true)
        .get();

    return snapshot.docs
        .map(
          (d) => SampleCollectionRequest.fromMap(d.data(), d.id),
        )
        .toList();
  }

  /// Get a single request by ID
  Future<SampleCollectionRequest?> getRequestById(
    String requestId,
  ) async {
    final doc = await _requests.doc(requestId).get();

    if (!doc.exists || doc.data() == null) {
      return null;
    }

    return SampleCollectionRequest.fromMap(
      doc.data(),
      doc.id,
    );
  }
}
