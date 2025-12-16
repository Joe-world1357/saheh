import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/payment.dart';

class PaymentRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _payments =>
      _db.collection('payments');

  /// Create or update a payment
  Future<void> savePayment(Payment payment) async {
    await _payments.doc(payment.id).set(
          payment.toMap(),
          SetOptions(merge: true), // safe for retries
        );
  }

  /// Get all payments for a user
  Future<List<Payment>> getUserPayments(String userId) async {
    final snapshot = await _payments
        .where('user_id', isEqualTo: userId)
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs
        .map((d) => Payment.fromMap(d.data(), d.id))
        .toList();
  }

  /// Get a single payment by ID
  Future<Payment?> getPaymentById(String paymentId) async {
    final doc = await _payments.doc(paymentId).get();

    if (!doc.exists || doc.data() == null) {
      return null;
    }

    return Payment.fromMap(doc.data(), doc.id);
  }
}