import 'package:get/get.dart';
import '../../../data/models/medicine_model.dart';
import '../../../common/widgets/app_snackbar.dart';

class MedicineController extends GetxController {
  final RxList<MedicineModel> medicines = <MedicineModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedCategory = 'Populer'.obs;
  final RxString selectedAddress = 'Alamat Pengiriman'.obs;

  final List<String> categories = [
    'Populer',
    'Influenza',
    'Vitamin',
    'Suplemen',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchMedicines();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> fetchMedicines() async {
    try {
      isLoading.value = true;
      update();

      // Simulasi data (ganti dengan API call)
      await Future.delayed(const Duration(seconds: 1));

      medicines.value = [
        MedicineModel(
          id: '1',
          name: 'Prove D3-1000 IU 10 Tablet',
          price: 35000,
          unit: 'Per Strip',
          imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300',
          category: 'Populer',
          description: 'Prove D3-1000 adalah suplemen kesehatan yang mengandung Vitamin D3 1000 IU untuk membantu menjaga daya tahan tubuh dan kesehatan tulang. Dikemas dalam bentuk tablet salut selaput, cocok untuk dikonsumsi sehari-hari.',
        ),
        MedicineModel(
          id: '2',
          name: 'Betadine Mouthwash and Gargle 1% 100ml',
          price: 32000,
          unit: 'Per Botol',
          imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300',
          category: 'Populer',
          description: 'Betadine Mouthwash adalah obat kumur antiseptik yang mengandung povidone-iodine 1% untuk membantu membunuh kuman penyebab infeksi tenggorokan dan mulut.',
        ),
        MedicineModel(
          id: '3',
          name: 'Betadine Feminine Hygiene 60 ml',
          price: 49000,
          unit: 'Per Botol',
          imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300',
          category: 'Populer',
          description: 'Betadine Feminine Hygiene adalah cairan pembersih kewanitaan yang mengandung povidone-iodine untuk menjaga kesehatan dan kebersihan area kewanitaan.',
        ),
        MedicineModel(
          id: '4',
          name: 'Siladex Mucoltic & Expectorant 60 ml',
          price: 20000,
          unit: 'Per Botol',
          imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300',
          category: 'Populer',
          description: 'Siladex adalah obat batuk yang mengandung ambroxol dan chlorpheniramine untuk meredakan batuk berdahak dan gejala flu lainnya.',
        ),
        MedicineModel(
          id: '5',
          name: 'Dicom Pseudoefedrin 30 mg',
          price: 22000,
          unit: 'Per Strip',
          imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300',
          category: 'Populer',
          description: 'Dicom mengandung pseudoefedrin yang berfungsi untuk meredakan hidung tersumbat akibat flu, alergi, atau sinusitis.',
        ),
        MedicineModel(
          id: '6',
          name: 'Panadol Paracetamol 30 mg',
          price: 18000,
          unit: 'Per strip',
          imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300',
          category: 'Populer',
          description: 'Panadol mengandung paracetamol yang efektif untuk meredakan demam, sakit kepala, sakit gigi, dan nyeri ringan hingga sedang.',
        ),
      ];

    } finally {
      isLoading.value = false;
      update();
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    update();
  }

  List<MedicineModel> get filteredMedicines {
    if (selectedCategory.value == 'Populer') {
      return medicines;
    }
    return medicines
        .where((medicine) => medicine.category == selectedCategory.value)
        .toList();
  }

  void updateAddress(String address) {
    selectedAddress.value = address;
    update();
  }

  void addToCart(MedicineModel medicine) {
    AppSnackBar.success(
      title: 'Berhasil',
      message: '${medicine.name} ditambahkan ke keranjang',
      duration: const Duration(seconds: 2),
    );
  }
}

