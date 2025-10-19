class BalanceModel {
  final String id;
  final double amount;
  final String type;
  final String description;
  final DateTime date;
  final String status;

  BalanceModel({
    required this.id,
    required this.amount,
    required this.type,
    required this.description,
    required this.date,
    this.status = 'completed',
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      id: json['id'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      type: json['type'] ?? 'earning',
      description: json['description'] ?? '',
      date: DateTime.parse(json['date']),
      status: json['status'] ?? 'completed',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'type': type,
      'description': description,
      'date': date.toIso8601String(),
      'status': status,
    };
  }

  bool get isEarning => type == 'earning';
  bool get isWithdrawal => type == 'withdrawal';
}


