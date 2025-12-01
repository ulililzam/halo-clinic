class ConsultationModel {
  final String id;
  final String doctorId;
  final String userId;
  final DateTime scheduledAt;
  final String status; // scheduled, ongoing, completed, cancelled
  final String? notes;
  final int fee;

  ConsultationModel({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.scheduledAt,
    required this.status,
    this.notes,
    required this.fee,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json) {
    return ConsultationModel(
      id: json['id'] ?? '',
      doctorId: json['doctor_id'] ?? '',
      userId: json['user_id'] ?? '',
      scheduledAt: json['scheduled_at'] != null
          ? DateTime.parse(json['scheduled_at'])
          : DateTime.now(),
      status: json['status'] ?? 'scheduled',
      notes: json['notes'],
      fee: json['fee'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'user_id': userId,
      'scheduled_at': scheduledAt.toIso8601String(),
      'status': status,
      'notes': notes,
      'fee': fee,
    };
  }
}
