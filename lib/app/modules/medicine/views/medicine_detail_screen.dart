import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/medicine_detail_controller.dart';
import '../widgets/medicine_info_widget.dart';
import '../widgets/quantity_selector_widget.dart';
import '../widgets/medicine_description_widget.dart';
import '../widgets/medicine_reviews_widget.dart';
import '../widgets/add_to_cart_button_widget.dart';
import '../../../common/themes/colors.dart';

class MedicineDetailScreen extends StatelessWidget {
  const MedicineDetailScreen({super.key});

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
          'Detail Obat',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        scrolledUnderElevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.textPrimary),
            onPressed: () {
              Get.toNamed('/cart');
            },
          ),
        ],
      ),
      body: GetBuilder<MedicineDetailController>(
        init: MedicineDetailController(),
        builder: (ctrl) {
          return Column(
            children: [
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Product Image
                      Container(
                        width: double.infinity,
                        height: 400,
                        color: Colors.white,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Image.asset(
                              'assets/images/betadine.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.medical_services,
                                  size: 120,
                                  color: AppColors.primary.withOpacity(0.3),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Product Info (Name, Price, Status)
                      MedicineInfoWidget(
                        name: ctrl.medicine.name,
                        unit: ctrl.medicine.unit,
                        price: ctrl.medicine.price.toDouble(),
                        isAvailable: true,
                        hasFreeShipping: true,
                      ),

                      const SizedBox(height: 8),

                      // Quantity Selector
                      Obx(() => QuantitySelectorWidget(
                            quantity: ctrl.quantity.value,
                            onDecrease: ctrl.decreaseQuantity,
                            onIncrease: ctrl.increaseQuantity,
                          )),

                      const SizedBox(height: 8),

                      // Description
                      MedicineDescriptionWidget(
                        description: ctrl.medicine.description ?? 
                            'Prove D3-1000 adalah suplemen kesehatan yang mengandung Vitamin D3 1000 IU untuk membantu menjaga daya tahan tubuh dan kesehatan tulang. Dikemas dalam bentuk tablet salut selaput, cocok untuk dikonsumsi sehari-hari.',
                      ),

                      const SizedBox(height: 8),

                      // Reviews
                      MedicineReviewsWidget(
                        onSeeAllReviews: ctrl.showAllReviews,
                      ),

                      // Bottom padding for button
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),

              // Add to Cart Button (Fixed at bottom)
              AddToCartButtonWidget(
                onPressed: ctrl.addToCart,
              ),
            ],
          );
        },
      ),
    );
  }
}
