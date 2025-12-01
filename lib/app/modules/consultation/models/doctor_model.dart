class DoctorModel {
  final String id;
  final String name;
  final String specialization;
  final String? imageUrl;
  final double rating;
  final int experience; // years
  final int consultationFee;
  final String? hospital;
  final bool isAvailable;
  final String? nextAvailableTime;
  final String availableDay;
  final String availableTime;
  final String clinicAddress;
  final bool isOnline;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    this.imageUrl,
    required this.rating,
    required this.experience,
    required this.consultationFee,
    this.hospital,
    this.isAvailable = false,
    this.nextAvailableTime,
    required this.availableDay,
    required this.availableTime,
    required this.clinicAddress,
    this.isOnline = true,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      specialization: json['specialization'] ?? '',
      imageUrl: json['image_url'],
      rating: (json['rating'] ?? 0).toDouble(),
      experience: json['experience'] ?? 0,
      consultationFee: json['consultation_fee'] ?? 0,
      hospital: json['hospital'],
      isAvailable: json['is_available'] ?? false,
      nextAvailableTime: json['next_available_time'],
      availableDay: json['available_day'] ?? 'Senin - Jumat',
      availableTime: json['available_time'] ?? '08:00 - 16:00',
      clinicAddress: json['clinic_address'] ?? 'Klinik',
      isOnline: json['is_online'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'image_url': imageUrl,
      'rating': rating,
      'experience': experience,
      'consultation_fee': consultationFee,
      'hospital': hospital,
      'is_available': isAvailable,
      'next_available_time': nextAvailableTime,
      'available_day': availableDay,
      'available_time': availableTime,
      'clinic_address': clinicAddress,
      'is_online': isOnline,
    };
  }
}
