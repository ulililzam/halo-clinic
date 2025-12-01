import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/address_model.dart';
import '../../../common/widgets/app_snackbar.dart';

class AddressSelectionController extends GetxController {
  // Address selection properties
  final RxString displayAddress = ''.obs;
  final RxDouble selectedLat = 0.0.obs;
  final RxDouble selectedLng = 0.0.obs;
  final detailAddressController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    detailAddressController.dispose();
    super.onClose();
  }

  void setSelectedLocation(double lat, double lng, String address) {
    selectedLat.value = lat;
    selectedLng.value = lng;
    displayAddress.value = address;
    update();
  }

  void saveAddress() {
    if (displayAddress.value.isEmpty) {
      AppSnackBar.warning(
        title: 'Peringatan',
        message: 'Silakan pilih lokasi di peta terlebih dahulu',
      );
      return;
    }

    // Gabungkan alamat utama dengan detail
    String fullAddress = displayAddress.value;
    if (detailAddressController.text.isNotEmpty) {
      fullAddress += '\n${detailAddressController.text}';
    }

    final address = AddressModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      label: 'Alamat Baru',
      fullAddress: fullAddress,
      recipientName: '',
      phoneNumber: '',
      latitude: selectedLat.value,
      longitude: selectedLng.value,
      isDefault: false,
    );

    // Reset form
    displayAddress.value = '';
    detailAddressController.clear();
    selectedLat.value = 0.0;
    selectedLng.value = 0.0;
    
    Get.back(result: address);
    
    AppSnackBar.success(
      title: 'Berhasil',
      message: 'Alamat berhasil disimpan',
    );
  }
}
