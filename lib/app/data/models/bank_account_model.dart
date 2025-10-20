class BankAccountModel {
  final String id;
  final String bankName;
  final String bankNumber;
  final String branchName;
  final String routingNumber;
  final DateTime createdAt;

  BankAccountModel({
    required this.id,
    required this.bankName,
    required this.bankNumber,
    required this.branchName,
    required this.routingNumber,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bankName': bankName,
      'bankNumber': bankNumber,
      'branchName': branchName,
      'routingNumber': routingNumber,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(
      id: json['id'] ?? '',
      bankName: json['bankName'] ?? '',
      bankNumber: json['bankNumber'] ?? '',
      branchName: json['branchName'] ?? '',
      routingNumber: json['routingNumber'] ?? '',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  String get maskedNumber {
    if (bankNumber.length <= 4) return bankNumber;
    return '${bankNumber.substring(0, 4)}${'*' * (bankNumber.length - 8)}${bankNumber.substring(bankNumber.length - 4)}';
  }
}

