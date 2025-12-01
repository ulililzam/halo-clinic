import 'package:get/get.dart';
import '../models/doctor_model.dart';

class ConsultationController extends GetxController {
  final doctors = <DoctorModel>[].obs;
  final allDoctors = <DoctorModel>[].obs;
  final isLoading = false.obs;
  final selectedSpecialization = 'Semua'.obs;
  final isOnlineSelected = true.obs;
  final isDropdownExpanded = false.obs;
  final selectedAddress = 'Hubungi dokter terbaikmu'.obs;
  final searchQuery = ''.obs;

  final List<String> specializations = [
    'Semua',
    'Anak',
    'Jantung',
    'Kulit',
    'Mata',
    'Kandungan',
    'Gizi',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      
      allDoctors.value = [
        DoctorModel(
          id: '1',
          name: 'Dr. Rizky Andini, Sp.A',
          specialization: 'Spesialis anak',
          rating: 4.9,
          experience: 3,
          consultationFee: 50000,
          isAvailable: true,
          availableDay: 'Senin - Jumat',
          availableTime: '08:00 - 14:00',
          clinicAddress: 'Klinik Sehat Sentosa, Semarang',
          isOnline: true,
        ),
        DoctorModel(
          id: '2',
          name: 'Dr. Fajar Prasetyo, Sp.PD',
          specialization: 'Spesialis penyakit dalam',
          rating: 4.8,
          experience: 5,
          consultationFee: 60000,
          isAvailable: true,
          availableDay: 'Senin - Sabtu',
          availableTime: '10:00 - 16:00',
          clinicAddress: 'Klinik Harmoni Medika, Semarang',
          isOnline: true,
        ),
        DoctorModel(
          id: '3',
          name: 'Dr. Andi Wibowo, Sp.JP',
          specialization: 'Spesialis jantung dan pembuluh darah',
          rating: 4.9,
          experience: 7,
          consultationFee: 75000,
          isAvailable: true,
          availableDay: 'Selasa & Kamis',
          availableTime: '09:00 - 13:00',
          clinicAddress: 'Klinik Kesuma medika, Yogyakarta',
          isOnline: true,
        ),
        DoctorModel(
          id: '4',
          name: 'Dr. Nadya Fitri, Sp.KK',
          specialization: 'Spesialis kulit dan kelamin',
          rating: 4.9,
          experience: 6,
          consultationFee: 65000,
          isAvailable: true,
          availableDay: 'Senin & Kamis',
          availableTime: '08:00 - 12:00',
          clinicAddress: 'Klinik Bunda Kasih, Surabaya',
          isOnline: true,
        ),
        DoctorModel(
          id: '5',
          name: 'Dr. Salsabila Putri, Sp.M',
          specialization: 'Spesialis mata',
          rating: 4.8,
          experience: 3,
          consultationFee: 55000,
          isAvailable: true,
          availableDay: 'Rabu & Jumat',
          availableTime: '13:00 - 17:00',
          clinicAddress: 'Klinik Mata Sejahtera, Bogor',
          isOnline: true,
        ),
        DoctorModel(
          id: '6',
          name: 'Dr. Maya Lestari, Sp.OG',
          specialization: 'Spesialis obstetri dan ginekologi',
          rating: 4.9,
          experience: 8,
          consultationFee: 80000,
          isAvailable: true,
          availableDay: 'Senin & Sabtu',
          availableTime: '16:00 - 20:00',
          clinicAddress: 'Klinik KUlit Dermasblow, Bekasi',
          isOnline: true,
        ),
        // Offline doctors
        DoctorModel(
          id: '7',
          name: 'Dr. Budi Santoso, Sp.A',
          specialization: 'Spesialis anak',
          rating: 4.7,
          experience: 5,
          consultationFee: 45000,
          isAvailable: true,
          availableDay: 'Senin - Jumat',
          availableTime: '09:00 - 15:00',
          clinicAddress: 'RS Husada, Jakarta',
          isOnline: false,
        ),
        DoctorModel(
          id: '8',
          name: 'Dr. Dewi Lestari, Sp.KK',
          specialization: 'Spesialis kulit dan kelamin',
          rating: 4.8,
          experience: 6,
          consultationFee: 70000,
          isAvailable: true,
          availableDay: 'Selasa & Kamis',
          availableTime: '10:00 - 14:00',
          clinicAddress: 'Klinik Kulit Prima, Bandung',
          isOnline: false,
        ),
      ];
      
      filterDoctors();
    } finally {
      isLoading.value = false;
    }
  }

  void selectSpecialization(String specialization) {
    selectedSpecialization.value = specialization;
    filterDoctors();
  }

  void toggleOnlineOffline(bool isOnline) {
    isOnlineSelected.value = isOnline;
    filterDoctors();
  }

  void toggleDropdown() {
    isDropdownExpanded.value = !isDropdownExpanded.value;
  }

  void onSearch(String query) {
    searchQuery.value = query;
    filterDoctors();
  }

  void filterDoctors() {
    if (allDoctors.isEmpty) {
      doctors.value = [];
      return;
    }

    List<DoctorModel> filtered = List.from(allDoctors);

    // Filter by online/offline
    filtered = filtered.where((doc) => doc.isOnline == isOnlineSelected.value).toList();

    // Filter by specialization
    if (selectedSpecialization.value != 'Semua') {
      filtered = filtered.where((doc) => 
        doc.specialization.toLowerCase().contains(selectedSpecialization.value.toLowerCase())
      ).toList();
    }

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered.where((doc) => 
        doc.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        doc.specialization.toLowerCase().contains(searchQuery.value.toLowerCase())
      ).toList();
    }

    doctors.value = filtered;
    update();
  }
}
