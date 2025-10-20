class MobileBankingModel {
  final String id;
  final String provider; // Bkash, Nagad, Rocket
  final String phoneNumber;
  final String fullName;
  final DateTime createdAt;

  MobileBankingModel({
    required this.id,
    required this.provider,
    required this.phoneNumber,
    required this.fullName,
    required this.createdAt,
  });

  // Get logo path based on provider
  String get logoPath {
    switch (provider.toLowerCase()) {
      case 'bkash':
        return 'assets/figma_exports/ef0732e1521d2d146fd4db0ce0fd76de695f5e96.png';
      case 'nagad':
        return 'assets/figma_exports/nogod.png';
      case 'rocket':
        return 'assets/figma_exports/rocket.png';
      default:
        return 'assets/figma_exports/ef0732e1521d2d146fd4db0ce0fd76de695f5e96.png';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider': provider,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory MobileBankingModel.fromJson(Map<String, dynamic> json) {
    return MobileBankingModel(
      id: json['id'] ?? '',
      provider: json['provider'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      fullName: json['fullName'] ?? '',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  String get maskedNumber {
    if (phoneNumber.length <= 4) return phoneNumber;
    return '${phoneNumber.substring(0, 3)}****${phoneNumber.substring(phoneNumber.length - 3)}';
  }
}

