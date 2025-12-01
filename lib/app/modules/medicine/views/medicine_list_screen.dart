import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/medicine_controller.dart';
import '../widgets/medicine_header_widget.dart';
import '../widgets/category_tabs_widget.dart';
import '../widgets/medicine_card_widget.dart';
import '../../../common/themes/colors.dart';

class MedicineListScreen extends StatelessWidget {
  const MedicineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
      ),
      body: GetBuilder<MedicineController>(
        init: MedicineController(),
        builder: (ctrl) {
          return Column(
            children: [
              // Header with address and search
              MedicineHeaderWidget(
                selectedAddress: ctrl.selectedAddress.value,
                onAddressTap: () async {
                  final result = await Get.toNamed('/address/select');
                  if (result != null) {
                    ctrl.updateAddress(result.fullAddress);
                  }
                },
              ),

              // Category Tabs
              const CategoryTabsWidget(),

              // Medicine Grid
              Expanded(
                child: ctrl.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: ctrl.fetchMedicines,
                        child: GridView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: ctrl.filteredMedicines.length,
                          itemBuilder: (context, index) {
                            final medicine = ctrl.filteredMedicines[index];
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  '/medicine/detail',
                                  arguments: medicine,
                                );
                              },
                              child: MedicineCardWidget(
                                medicine: medicine,
                                onAddToCart: () => ctrl.addToCart(medicine),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/cart');
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.shopping_cart, color: Colors.white),
        ),
      ),
    );
  }
}
