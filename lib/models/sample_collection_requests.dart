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

  factory SampleCollectionRequest.fromMap(
      Map<String, dynamic> data, String id) {
    return SampleCollectionRequest(
      id: id,
      userId: data['user_id'],
      serviceId: data['service_id'],
      requestDate:
          DateTime.parse(data['request_date']),
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'service_id': serviceId,
      'request_date': requestDate.toIso8601String(),
      'status': status,
    };
  }
}
