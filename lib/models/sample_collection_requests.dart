class SampleCollectionRequest {
  final String id;          // Firestore document ID
  final String userId;      // FK → users
  final String serviceId;   // FK → sample_collection_services
  final DateTime requestDate;
  final String status;

  SampleCollectionRequest({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.requestDate,
    required this.status,
  });

  // 🔒 SAFE fromMap
  factory SampleCollectionRequest.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return SampleCollectionRequest(
      id: id,

      // required FKs
      userId: map['user_id'] as String? ?? '',
      serviceId: map['service_id'] as String? ?? '',

      // Firestore / offline safe date
      requestDate: map['request_date'] != null
          ? DateTime.tryParse(
                map['request_date'].toString(),
              ) ??
              DateTime.now()
          : DateTime.now(),

      // lifecycle-safe status
      status: map['status'] as String? ?? 'pending',
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'service_id': serviceId,
      'request_date': requestDate.toIso8601String(),
      'status': status,
    };
  }
}
