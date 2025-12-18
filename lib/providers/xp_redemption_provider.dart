import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/xp_redemption_model.dart';
import '../database/database_helper.dart';
import 'auth_provider.dart';
import 'user_provider.dart';

class XPRedemptionNotifier extends Notifier<List<XPRedemptionModel>> {
  final _db = DatabaseHelper.instance;

  String? get _userEmail => ref.read(authProvider).user?.email;

  @override
  List<XPRedemptionModel> build() {
    final authState = ref.watch(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return [];
    }
    _loadRedemptions();
    return [];
  }

  Future<void> _loadRedemptions() async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) {
      state = [];
      return;
    }

    try {
      final redemptions = await _db.getXPRedemptions(userEmail);
      state = redemptions;
    } catch (e) {
      state = [];
    }
  }

  /// Redeem XP for a discount/product/service
  Future<bool> redeemXP({
    required String redemptionType,
    required String itemName,
    String? itemDescription,
    required int xpCost,
    String? discountCode,
    String? productId,
  }) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) return false;

    try {
      final user = ref.read(userProvider);
      if (user == null) return false;

      // Validation: Check XP cost is positive
      if (xpCost <= 0) {
        debugPrint('Invalid XP cost: $xpCost');
        return false;
      }

      // Validation: Check if user has enough XP
      if (user.xp < xpCost) {
        debugPrint('Insufficient XP: ${user.xp} < $xpCost');
        return false; // Insufficient XP
      }

      // Validation: Check item name is not empty
      if (itemName.trim().isEmpty) {
        debugPrint('Invalid item name');
        return false;
      }

      // Create redemption record
      final redemption = XPRedemptionModel(
        userEmail: userEmail,
        redemptionType: redemptionType,
        itemName: itemName.trim(),
        itemDescription: itemDescription?.trim(),
        xpCost: xpCost,
        discountCode: discountCode?.trim(),
        productId: productId?.trim(),
      );

      // Save redemption
      await _db.insertXPRedemption(redemption);

      // Deduct XP (using negative amount - validation happens in addXP)
      await ref.read(userProvider.notifier).addXP(-xpCost);

      // Reload redemptions
      await _loadRedemptions();

      return true;
    } catch (e) {
      debugPrint('Error redeeming XP: $e');
      return false;
    }
  }

  Future<void> refresh() async {
    await _loadRedemptions();
  }

  Future<int> getTotalRedeemed() async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) return 0;
    return await _db.getTotalXPRedeemed(userEmail);
  }
}

final xpRedemptionProvider = NotifierProvider<XPRedemptionNotifier, List<XPRedemptionModel>>(() {
  return XPRedemptionNotifier();
});

