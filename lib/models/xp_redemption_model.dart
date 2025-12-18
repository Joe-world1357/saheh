class XPRedemptionModel {
  final int? id;
  final String userEmail;
  final String redemptionType; // 'discount', 'product', 'service'
  final String itemName;
  final String? itemDescription;
  final int xpCost;
  final String? discountCode;
  final String? productId;
  final DateTime redeemedAt;

  XPRedemptionModel({
    this.id,
    required this.userEmail,
    required this.redemptionType,
    required this.itemName,
    this.itemDescription,
    required this.xpCost,
    this.discountCode,
    this.productId,
    DateTime? redeemedAt,
  }) : redeemedAt = redeemedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_email': userEmail,
      'redemption_type': redemptionType,
      'item_name': itemName,
      'item_description': itemDescription,
      'xp_cost': xpCost,
      'discount_code': discountCode,
      'product_id': productId,
      'redeemed_at': redeemedAt.toIso8601String(),
    };
  }

  factory XPRedemptionModel.fromMap(Map<String, dynamic> map) {
    return XPRedemptionModel(
      id: map['id'] as int?,
      userEmail: map['user_email'] as String,
      redemptionType: map['redemption_type'] as String,
      itemName: map['item_name'] as String,
      itemDescription: map['item_description'] as String?,
      xpCost: map['xp_cost'] as int? ?? 0,
      discountCode: map['discount_code'] as String?,
      productId: map['product_id'] as String?,
      redeemedAt: map['redeemed_at'] != null
          ? DateTime.parse(map['redeemed_at'] as String)
          : DateTime.now(),
    );
  }
}

