import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/promo_code_widget.dart';
import '../widgets/cart_summary_widget.dart';
import '../widgets/checkout_button_widget.dart';
import '../../../common/themes/colors.dart';
import '../../../common/widgets/empty_state_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Keranjang',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<CartController>(
        init: CartController(),
        builder: (ctrl) {
          if (ctrl.cartItems.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.shopping_cart_outlined,
              title: 'Keranjang Kosong',
              message: 'Belum ada item di keranjang Anda',
            );
          }

          return Column(
            children: [
              // Cart Items List
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Select All Header
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!, width: 1),
                          ),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: ctrl.toggleSelectAll,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: ctrl.isAllSelected ? AppColors.primary : Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: ctrl.isAllSelected ? AppColors.primary : Colors.grey[400]!,
                                    width: 2,
                                  ),
                                ),
                                child: ctrl.isAllSelected
                                    ? const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Pilih semua',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                // Show delete confirmation
                                _showDeleteAllDialog(context, ctrl);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                              ),
                              child: const Text(
                                'Hapus Semua',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Cart Items
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: ctrl.cartItems
                              .map((item) => CartItemWidget(
                                    item: item,
                                    onToggleSelect: () => ctrl.toggleSelectItem(item.id),
                                    onIncrease: () => ctrl.increaseQuantity(item.id),
                                    onDecrease: () => ctrl.decreaseQuantity(item.id),
                                    onRemove: () => _showDeleteDialog(context, ctrl, item.id),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Promo Code
              Obx(() => PromoCodeWidget(
                    onApply: ctrl.applyPromoCode,
                    isLoading: ctrl.isLoadingPromo.value,
                  )),

              // Summary
              Obx(() => CartSummaryWidget(
                    subTotal: ctrl.subTotal,
                    shippingCost: ctrl.shippingCost,
                    promoDiscount: ctrl.promoDiscount.value,
                    total: ctrl.total,
                  )),

              // Checkout Button
              Obx(() => CheckoutButtonWidget(
                    onPressed: ctrl.checkout,
                    isEnabled: ctrl.selectedItemsCount > 0,
                  )),
            ],
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, CartController ctrl, String itemId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Item'),
          content: const Text('Apakah Anda yakin ingin menghapus item ini dari keranjang?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                ctrl.removeItem(itemId);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAllDialog(BuildContext context, CartController ctrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Semua Item'),
          content: const Text('Apakah Anda yakin ingin menghapus semua item dari keranjang?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                ctrl.cartItems.clear();
                ctrl.update();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Hapus Semua',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
