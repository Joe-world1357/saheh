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

  // 🔒 SAFE fromMap
  factory Payment.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return Payment(
      id: id,

      // required FK
      userId: map['user_id'] as String? ?? '',

      // money-safe number
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,

      // required text
      method: map['method'] as String? ?? '',
      status: map['status'] as String? ?? 'pending',

      // Firestore / offline safe date
      date: map['date'] != null
          ? DateTime.tryParse(
                map['date'].toString(),
              ) ??
              DateTime.now()
          : DateTime.now(),
    );
  }

  // 🧼 CLEAN toMap
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
