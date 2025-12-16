class Payment {
  final String id;        // Firestore document ID
  final String userId;    // FK → users
  final double amount;
  final String method;
  final String status;
  final DateTime date;

  Payment({
    required this.id,
    required this.userId,
    required this.amount,
    required this.method,
    required this.status,
    required this.date,
  });

  factory Payment.fromMap(
      Map<String, dynamic> data, String id) {
    return Payment(
      id: id,
      userId: data['user_id'],
      amount: data['amount']?.toDouble(),
      method: data['method'],
      status: data['status'],
      date: DateTime.parse(data['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'amount': amount,
      'method': method,
      'status': status,
      'date': date.toIso8601String(),
    };
  }
}
